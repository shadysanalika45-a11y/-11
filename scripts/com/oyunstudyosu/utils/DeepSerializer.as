package com.oyunstudyosu.utils
{
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	import com.smartfoxserver.v2.entities.data.ISFSArray;
	import com.smartfoxserver.v2.entities.data.SFSDataWrapper;

	/**
	 * DeepSerializer - NO TRUNCATION serializer for AS3 objects
	 *
	 * RULES:
	 * - Full depth, no maxDepth limits
	 * - Full arrays, no maxItems limits
	 * - ByteArray: full hex + base64
	 * - Handles circular references
	 * - Supports all AS3 types + SFS types
	 */
	public class DeepSerializer
	{
		private static const MAX_RECURSION:uint = 1000; // Safety limit for circular refs

		/**
		 * Serialize any AS3 object to JSON string
		 * NO TRUNCATION
		 */
		public static function serialize(obj:*, visited:Dictionary = null, depth:uint = 0):String
		{
			// Safety check for extreme recursion
			if (depth > MAX_RECURSION)
			{
				return '"[MAX_RECURSION_REACHED]"';
			}

			// Initialize visited tracking for circular refs
			if (visited == null)
			{
				visited = new Dictionary(true); // weak keys
			}

			// Handle primitives
			if (obj == null)
			{
				return "null";
			}

			if (obj is Boolean)
			{
				return obj ? "true" : "false";
			}

			if (obj is Number || obj is int || obj is uint)
			{
				if (isNaN(obj as Number))
				{
					return '"NaN"';
				}
				if (!isFinite(obj as Number))
				{
					return obj > 0 ? '"Infinity"' : '"-Infinity"';
				}
				return String(obj);
			}

			if (obj is String)
			{
				return escapeString(obj as String);
			}

			// Check for circular reference
			if (visited[obj] !== undefined)
			{
				return '"[CIRCULAR_REF]"';
			}

			visited[obj] = true;

			try
			{
				// Handle special types
				if (obj is Date)
				{
					return '"' + (obj as Date).toUTCString() + '"';
				}

				if (obj is ByteArray)
				{
					return serializeByteArray(obj as ByteArray);
				}

				if (obj is XML || obj is XMLList)
				{
					return serializeXML(obj);
				}

				// SFS2X types
				if (obj is ISFSObject)
				{
					return serializeSFSObject(obj as ISFSObject, visited, depth);
				}

				if (obj is ISFSArray)
				{
					return serializeSFSArray(obj as ISFSArray, visited, depth);
				}

				// Array
				if (obj is Array)
				{
					return serializeArray(obj as Array, visited, depth);
				}

				// Vector
				var className:String = getQualifiedClassName(obj);
				if (className.indexOf("__AS3__.vec::Vector") == 0)
				{
					return serializeVector(obj, visited, depth);
				}

				// Dictionary
				if (obj is Dictionary)
				{
					return serializeDictionary(obj as Dictionary, visited, depth);
				}

				// Generic Object or custom class
				return serializeObject(obj, visited, depth);
			}
			finally
			{
				delete visited[obj];
			}
		}

		private static function escapeString(str:String):String
		{
			// Full JSON string escaping
			var result:String = '"';

			for (var i:int = 0; i < str.length; i++)
			{
				var char:String = str.charAt(i);
				var code:uint = str.charCodeAt(i);

				switch (char)
				{
					case '"':
						result += '\\"';
						break;
					case '\\':
						result += '\\\\';
						break;
					case '\b':
						result += '\\b';
						break;
					case '\f':
						result += '\\f';
						break;
					case '\n':
						result += '\\n';
						break;
					case '\r':
						result += '\\r';
						break;
					case '\t':
						result += '\\t';
						break;
					default:
						if (code < 32 || code > 126)
						{
							// Unicode escape
							result += '\\u' + ("0000" + code.toString(16)).substr(-4);
						}
						else
						{
							result += char;
						}
				}
			}

			result += '"';
			return result;
		}

		/**
		 * Serialize ByteArray - FULL HEX + BASE64, no truncation
		 */
		private static function serializeByteArray(ba:ByteArray):String
		{
			ba.position = 0;

			// Generate full hex
			var hex:String = "";
			for (var i:uint = 0; i < ba.length; i++)
			{
				var byte:uint = ba.readUnsignedByte();
				hex += ("0" + byte.toString(16)).substr(-2);
			}

			// Generate full base64
			ba.position = 0;
			var base64:String = encodeBase64(ba);

			var obj:Object = {
				_type: "ByteArray",
				length: ba.length,
				hex: hex,
				b64: base64
			};

			return serialize(obj, new Dictionary(true), 0);
		}

		private static function encodeBase64(data:ByteArray):String
		{
			var base64Chars:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
			var output:String = "";

			data.position = 0;
			var remaining:uint = data.length;
			var i:uint = 0;

			while (remaining >= 3)
			{
				var b1:uint = data.readUnsignedByte();
				var b2:uint = data.readUnsignedByte();
				var b3:uint = data.readUnsignedByte();

				output += base64Chars.charAt(b1 >> 2);
				output += base64Chars.charAt(((b1 & 0x03) << 4) | (b2 >> 4));
				output += base64Chars.charAt(((b2 & 0x0F) << 2) | (b3 >> 6));
				output += base64Chars.charAt(b3 & 0x3F);

				remaining -= 3;
			}

			if (remaining == 2)
			{
				var b1:uint = data.readUnsignedByte();
				var b2:uint = data.readUnsignedByte();

				output += base64Chars.charAt(b1 >> 2);
				output += base64Chars.charAt(((b1 & 0x03) << 4) | (b2 >> 4));
				output += base64Chars.charAt((b2 & 0x0F) << 2);
				output += "=";
			}
			else if (remaining == 1)
			{
				var b1:uint = data.readUnsignedByte();

				output += base64Chars.charAt(b1 >> 2);
				output += base64Chars.charAt((b1 & 0x03) << 4);
				output += "==";
			}

			return output;
		}

		private static function serializeXML(xml:*):String
		{
			var obj:Object = {
				_type: xml is XML ? "XML" : "XMLList",
				value: xml.toXMLString() // Full XML string, no truncation
			};

			return serialize(obj, new Dictionary(true), 0);
		}

		/**
		 * Serialize SFSObject - FULL DEPTH
		 */
		private static function serializeSFSObject(sfsObj:ISFSObject, visited:Dictionary, depth:uint):String
		{
			var obj:Object = {
				_type: "SFSObject"
			};

			var keys:Array = sfsObj.getKeys();
			for each (var key:String in keys)
			{
				var wrapper:SFSDataWrapper = sfsObj.get(key);
				obj[key] = unwrapSFSData(wrapper, visited, depth + 1);
			}

			return serialize(obj, visited, depth);
		}

		private static function serializeSFSArray(sfsArr:ISFSArray, visited:Dictionary, depth:uint):String
		{
			var arr:Array = [];
			arr.push("_SFSARRAY_TYPE_MARKER_"); // Mark as SFSArray

			for (var i:int = 0; i < sfsArr.size(); i++)
			{
				var wrapper:SFSDataWrapper = sfsArr.get(i);
				arr.push(unwrapSFSData(wrapper, visited, depth + 1));
			}

			return serialize(arr, visited, depth);
		}

		private static function unwrapSFSData(wrapper:SFSDataWrapper, visited:Dictionary, depth:uint):*
		{
			if (wrapper == null)
			{
				return null;
			}

			var typeId:int = wrapper.getTypeId();

			// Use SFSDataType constants
			switch (typeId)
			{
				case 0: // NULL
					return null;
				case 1: // BOOL
					return wrapper.getObject();
				case 2: // BYTE
				case 3: // SHORT
				case 4: // INT
				case 5: // LONG
				case 6: // FLOAT
				case 7: // DOUBLE
					return wrapper.getObject();
				case 8: // UTF_STRING
				case 9: // TEXT (deprecated)
					return wrapper.getObject();
				case 10: // BOOL_ARRAY
				case 11: // BYTE_ARRAY
				case 12: // SHORT_ARRAY
				case 13: // INT_ARRAY
				case 14: // LONG_ARRAY
				case 15: // FLOAT_ARRAY
				case 16: // DOUBLE_ARRAY
				case 17: // UTF_STRING_ARRAY
					return wrapper.getObject();
				case 18: // SFS_OBJECT
					return wrapper.getObject();
				case 19: // SFS_ARRAY
					return wrapper.getObject();
				default:
					return wrapper.getObject();
			}
		}

		private static function serializeArray(arr:Array, visited:Dictionary, depth:uint):String
		{
			var result:String = "[";

			for (var i:int = 0; i < arr.length; i++)
			{
				if (i > 0)
				{
					result += ",";
				}
				result += serialize(arr[i], visited, depth + 1);
			}

			result += "]";
			return result;
		}

		private static function serializeVector(vec:*, visited:Dictionary, depth:uint):String
		{
			var arr:Array = [];

			var len:uint = vec.length;
			for (var i:uint = 0; i < len; i++)
			{
				arr.push(vec[i]);
			}

			return serializeArray(arr, visited, depth);
		}

		private static function serializeDictionary(dict:Dictionary, visited:Dictionary, depth:uint):String
		{
			var obj:Object = {
				_type: "Dictionary"
			};

			var i:int = 0;
			for (var key:* in dict)
			{
				// Dictionary keys can be objects, so serialize key and value
				var keyStr:String = "key_" + i;
				obj[keyStr] = {
					key: serialize(key, visited, depth + 1),
					value: serialize(dict[key], visited, depth + 1)
				};
				i++;
			}

			return serialize(obj, visited, depth);
		}

		/**
		 * Serialize generic object or class instance
		 * FULL property depth
		 */
		private static function serializeObject(obj:*, visited:Dictionary, depth:uint):String
		{
			var result:String = "{";
			var first:Boolean = true;

			// Add type marker
			var className:String = getQualifiedClassName(obj);
			result += '"_type":' + escapeString(className);
			first = false;

			// Dynamic properties
			for (var key:String in obj)
			{
				if (!first)
				{
					result += ",";
				}
				result += escapeString(key) + ":" + serialize(obj[key], visited, depth + 1);
				first = false;
			}

			// For typed objects, also get declared properties via reflection
			if (className != "Object")
			{
				try
				{
					var typeDesc:XML = describeType(obj);
					var accessors:XMLList = typeDesc..accessor.(@access == "readwrite" || @access == "readonly");
					var variables:XMLList = typeDesc..variable;

					for each (var prop:XML in accessors)
					{
						var propName:String = prop.@name.toString();
						if (obj.hasOwnProperty(propName))
						{
							if (!first)
							{
								result += ",";
							}
							result += escapeString(propName) + ":" + serialize(obj[propName], visited, depth + 1);
							first = false;
						}
					}

					for each (var varProp:XML in variables)
					{
						var varName:String = varProp.@name.toString();
						if (obj.hasOwnProperty(varName))
						{
							if (!first)
							{
								result += ",";
							}
							result += escapeString(varName) + ":" + serialize(obj[varName], visited, depth + 1);
							first = false;
						}
					}
				}
				catch (e:Error)
				{
					// Reflection failed, skip
				}
			}

			result += "}";
			return result;
		}
	}
}
