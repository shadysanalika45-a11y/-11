#!/usr/bin/env python3
from __future__ import annotations

import argparse
import base64
import json
import re
from pathlib import Path
from typing import Any, Dict, List, Tuple


BASE64_RE = re.compile(r"^[A-Za-z0-9+/=\r\n]+$")


def maybe_decode_base64(raw: bytes) -> str:
    text = raw.decode("utf-8", errors="ignore")
    if BASE64_RE.match(text) and "|" not in text:
        try:
            decoded = base64.b64decode(text)
            decoded_text = decoded.decode("utf-8", errors="ignore")
            if "|" in decoded_text:
                return decoded_text
        except Exception:
            return text
    return text


def place_bit_indexes(bit: int) -> List[int]:
    indexes: List[int] = []
    for i in range(32):
        if bit & (1 << i):
            indexes.append(i)
    return indexes


def parse_lines(lines: List[str]) -> Dict[str, Any]:
    clothes: List[Dict[str, Any]] = []
    inventory: List[Dict[str, Any]] = []
    smileys: List[Dict[str, Any]] = []
    subtypes: Dict[int, List[Dict[str, Any]]] = {}
    genders = ["m", "f"]

    for line in lines:
        if not line:
            continue
        parts = line.split("|")
        if len(parts) == 7:
            base_key = parts[0]
            colors = parts[1].split(",")
            place_bit = int(parts[2])
            states = int(parts[3])
            adjust_x = int(parts[4])
            adjust_y = int(parts[5])
            version = int(parts[6])
            for gender in genders:
                for color in colors:
                    key = f"{gender}_{base_key}_{color}"
                    product_key = f"{gender}_{base_key}"
                    entry = {
                        "clip": key,
                        "productKey": product_key,
                        "baseKey": base_key,
                        "gender": gender,
                        "color": int(color),
                        "placeBit": place_bit,
                        "placeBitIndexes": place_bit_indexes(place_bit),
                        "states": states,
                        "adjustX": adjust_x,
                        "adjustY": adjust_y,
                        "version": version,
                    }
                    clothes.append(entry)
                    for idx in entry["placeBitIndexes"]:
                        subtypes.setdefault(idx, []).append(entry)
        elif len(parts) == 4:
            base_key = parts[0]
            field1 = int(parts[1])
            field2 = int(parts[2])
            version = int(parts[3])
            for gender in genders:
                inventory.append(
                    {
                        "clip": f"{gender}_{base_key}",
                        "baseKey": base_key,
                        "gender": gender,
                        "field1": field1,
                        "field2": field2,
                        "version": version,
                    }
                )
        elif len(parts) == 2:
            smileys.append({"key": parts[0], "version": int(parts[1])})

    summary = {
        "clothesCount": len(clothes),
        "inventoryCount": len(inventory),
        "smileyCount": len(smileys),
        "subtypeCount": len(subtypes),
        "mandatorySubtypes": [],
        "notes": [
            "Client code does not enforce mandatory clothing subtypes; mandatorySubtypes is left empty.",
            "placeBitIndexes correspond to bit positions in ClothType.",
        ],
    }
    return {
        "clothes": clothes,
        "inventory": inventory,
        "smileys": smileys,
        "subtypes": {str(k): v for k, v in subtypes.items()},
        "summary": summary,
    }


def parse_file(path: Path) -> Dict[str, Any]:
    raw = path.read_bytes()
    text = maybe_decode_base64(raw)
    lines = [line.strip() for line in text.splitlines() if line.strip()]
    data = parse_lines(lines)
    data["file"] = str(path)
    data["lineCount"] = len(lines)
    return data


def main() -> None:
    parser = argparse.ArgumentParser(description="Parse Sanalika vf/ifile data files.")
    parser.add_argument("files", nargs="+", type=Path, help="Input vf/ifile paths")
    parser.add_argument("--json-out", type=Path, help="Write JSON output to file")
    parser.add_argument("--text-out", type=Path, help="Write human-readable summary to file")
    args = parser.parse_args()

    results = [parse_file(path) for path in args.files]
    output = {"files": results}

    if args.json_out:
        args.json_out.write_text(json.dumps(output, indent=2), encoding="utf-8")

    if args.text_out:
        lines: List[str] = []
        for result in results:
            summary = result["summary"]
            lines.append(f"File: {result['file']}")
            lines.append(f"Lines: {result['lineCount']}")
            lines.append(f"Clothes: {summary['clothesCount']}")
            lines.append(f"Inventory: {summary['inventoryCount']}")
            lines.append(f"Smileys: {summary['smileyCount']}")
            lines.append(f"Subtypes: {summary['subtypeCount']}")
            lines.append("")
        args.text_out.write_text("\n".join(lines), encoding="utf-8")

    print(json.dumps(output, indent=2))


if __name__ == "__main__":
    main()
