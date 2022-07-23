# RISC-V Snake

Play snake on the [emulsiV](<http://tice.sea.eseo.fr/riscv/> "emulsiV") RISC-V microcontroller emulator. Completely written in RISC-V assembly (integer subset RV32I).

You can either take the direct link or build from source.

## Direct Link

Play the game preconfigured on the emulator [here](<http://tice.sea.eseo.fr/riscv/#EAAAAG8AgAJvAMAAAAAAAAAAAADQ:EAAQABMBwf8jIBEA7wDARYMgAQAg:EAAgABMBQQBzACAwlxEAAJOBQbIJ:EAAwABcRAAATAQG9lxIAAJOCQrEV:EABAABcTAAATA8OwY/hiACOgAgB7:EABQAJOCQgDj7GL+7wBAAW8AAAB7:EABgAAAAAAAAAAAAAAAAABMBwf+8:EABwACMgEQDvAAA+7wAQGZcSAAA+:EACAAJOCMqYjkAIAlxIAAJOCYqUJ:EACQACOAAgCXEgAAk4JCqCOgAgBO:EACgAJcSAACTgoKjNyMAACOgYgDu:EACwAJcSAACTgsKiNxMAABMDg7uA:EADAACOQYgATBRAA7wAAP+8AAF15:EADQAO8AwCrvAAAl7wCQFJcSAAD3:EADgAJOCAqCD0gIAEwMAAG8AgAD9:EADwABMDEwDjHlP+lxIAAJOCAqIj:EAEAAAOlAgBjCAUAkwIQAOMIVfb6:EAEQAO8AwAmXEgAAk4JCnAOlAgDh:EAEgAJcSAACTguKbg8UCAO8AAA5N:EAEwABMEBQCTAhAAYxRUAhMFAAAZ:EAFAAO8AgDfvAFAPlxIAAJOCcpny:EAFQAAPVAgDvANAP7wCAFW/wH/ID:EAFgAJcSAACTguKXA8MCAGMUAwAW:EAFwAO8AwHqTAiAAszJUAJPCEgAB:EAGAABcTAAATA+OVIwBTAOOIAvTg:EAGQAO8AwA3vAAAZ7wDADm/wH/Rs:EAGgAIMgAQATAUEAZ4AAAJcSAADG:EAGwAJOCwpIDowIAkwMABGMYdQCk:EAHAALcDQABjEHMEZ4AAALcjAACK:EAHQAGMYdQC3gwAAYxZzAmeAAAAg:EAHgALcDQABjGHUAkwMABGMccwCZ:EAHwAGeAAAC3gwAAYxh1ALcjAAAU:EAIAAGMEcwAjoKIAZ4AAABMBwf/0:EAIQACMgEQCTAgUAE4UFABMDAAQ5:EAIgAGMWUwDvAABObwCAAzcjAAB5:EAIwAGMWUwDvAEBTbwCAAjcDQAAF:EAJAAGMWUwDvAMBYbwCAATeDAAAx:EAJQAGMWUwDvAEBebwCAABMFAAA+:EAJgAIMgAQATAUEAZ4AAAJcSAAAF:EAJwAJOCMocD0wIAEwMTACOQYgCa:EAKAAGeAAACXEgAAk4KChQPTAgDq:EAKQAGMOAwCTA9AHEw5QRmNkbgCR:EAKgAJMDsAQzA3NAI5BiAGeAAAAf:EAKwAJcSAACTgoKGEwMQAIOjAgAq:EALAAOMec/5ngAAAk5VVALOFpQB7:EALQALcSAACTggLAs4KyACOAwgAy:EALgAGeAAACTlVUAs4WlALcSAAAE:EALwAJOCAsCzgrIAA8UCAGeAAACP:EAMAALcSAACTggLANxMAABMD8//7:EAMQAJMDAAAjoHIAk4JCAOPsYv6M:EAMgAGeAAAATAcH/IyARAO8AAAbJ:EAMwAJcCAACTgmJ+I4CiAKOAsgAV:EANAABMGcAfv8F/4gyABABMBQQDu:EANQAGeAAACXAgAAk4IifAPDAgCi:EANgAIPDEgBjGGUAY5Z1ABMFEAC/:EANwAGeAAAATBQAAZ4AAAJcCAAD+:EAOAAJOCknkjoAIAZ4AAABMBAf+N:EAOQACMgEQAjIoEAIySRACMmIQEA:EAOgAO8AgAcTBAUAk4QFABMJAACD:EAOwAO/wX/NjAgUEEwQUAJOEFABI:EAPAAJMCAAJjFFQAEwQAAGOUVABp:EAPQAJMEAAATCRkAYxpZABMJAABf:EAPgABMEFABjFFQAEwQAABMFBADk:EAPwAJOFBABv8N/7EwUEAJOFBABw:EAQAAIMgAQADJEEAgySBAAMpwQDL:EAQQABMBAQFngAAAlwIAAJOCkmwz:EAQgABcDAAATA1Nvg0MDABOeEwBN:EAQwALOCwgEDxQIAg8USAJODEwB3:EARAAJMCoAFj5FMAkwMAACMAcwCw:EARQAGeAAAC3AgDQNwMAARMD8//p:EARgACOgYgA3o0AAEwMTBCOiYgD5:EARwAGeAAAATAUH/IyCBACMikQCn:EASAACMkIQE3BADQgySEAGOKBADc:EASQABcJAAATCYloIyCZACMkBAAI:EASgACMmBAADJAEAgyRBAAMpgQBC:EASwABMBwQBngAAAtwIA0GMGBQCJ:EATAADcDAAFvAIAAEwMAACOoYgC/:EATQAGeAAACXAgAAk4JCChMDUADV:EATgAKOBYggTAwAEI4JiCGeAAABu:EATwABOPAADvAAAFg0IFABMDMABW:EAUAADMTswCz8mIAM9WyAJMADwCP:EAUQAGeAAAATjwAA7wDAAoNCBQDX:EAUgABMDMAAzE7MAE0Pz/7PyYgA9:EAUwADMWtgCz4sIAIwBVAJMADwBL:EAVAAGeAAACTjwAAk5VVADMFtQA4:EAVQAJMFQADvAEASlwIAAJOCAgLQ:EAVgADMFVQATAzAAMwOzQJMVEwDU:EAVwAJOADwBngAAAAAAAAAAAAABy:EAZwAAAAAAAAAAAAkwIAAGOKBQDz:EAaAAG8AwAAzBbVAk4ISAON8tf7V:EAaQAJMFBQAThQIAZ4AAABMBwf9o:EAagACMgEQDv8N/F7/Df4hMF4ADb:EAawAJMFAAHvAAA0EwbwD+/w38Do:EAbAABMF8ACTBQABEwbwD+/w37/0:EAbQABMFAAGTBQABEwbwD+/w377U:EAbgABMFEAGTBQABEwYQAO8AQC/B:EAbwABMG8A/v8F+9gyABABMBQQDu:EAcAAGeAAAATAUH/IyARACMigQCU:EAcQACMkkQDvAEAqEwQFAJOEBQBw:EAcgAGOCBRiThfX/7wDAGWMcBRZZ:EAcwABMFBACThQQAEwYAAO/wn90N:EAdAABMFBACThfT/7wCAKRMG8A/S:EAdQAO/wn7cTBQQAk4X0/+/wn78A:EAdgAGMWBRRvAIATEwFB/yMgEQBN:EAdwACMigQAjJJEA7wAAJBMEBQCs:EAeAAJOEBQCTAvABYw5VEBMFFQDE:EAeQAO8AQBNjGAUQEwUEAJOFBABP:EAegABMGEADv8B/XEwUUAJOFBAAD:EAewAO8AACMTBvAP7/AfsRMFFAA0:EAfAAJOFBADv8B+5YxIFDm8AAA1S:EAfQABMBQf8jIBEAIyKBACMkkQDT:EAfgAO8AgB0TBAUAk4QFAJMC8AG/:EAfwAGOKVQqThRUA7wDADGMUBQo/:EAgAABMFBACThQQAEwYgAO/wn9Ap:EAgQABMFBACThRQA7wCAHBMG8A/t:EAggAO/wn6oTBQQAk4UUAO/wn7Io:EAgwAGMeBQZvAIAGEwFB/yMgEQCP:EAhAACMigQAjJJEA7wAAFxMEBQDo:EAhQAJOEBQBjCAUEEwX1/+8AgAaH:EAhgAGMSBQQTBQQAk4UEABMGMACJ:EAhwAO/wX8oTBfT/k4UEAO8AQBYE:EAiAABMG8A/v8F+kEwX0/5OFBABH:EAiQAO/wX6xjHAUAbwBAABMFAAAj:EAigAG8AAAETBRAAbwCAABMFIACJ:EAiwAIMgAQADJEEAgySBABMBwQAv:EAjAAGeAAACTjwAAEw8EAJOOBADU:EAjQABMOCQATBAUAk4QFABMJBgCU:EAjgAO/wX6CTAvAPYx5VAO8AAA7D:EAjwAGMWhQBjlJUAYwYJABMFEADU:EAkAAG8AgAATBQAAk4APABMEDwCY:EAkQAJOEDgATCQ4AZ4AAABMBQf9N:EAkgACMgEQAjIoEAIySRAO8AAArc:EAkwABMEBQCThAUA7wAACGMWhQCK:EAlAAGOUlQBvAEABEwUEAJOFBAAz:EAlQABMGAADv8F+XEwUEAJOFBABx:EAlgAO/wH7mTAgAAYxZVAJOE9P9j:EAlwAG8AgAKTAhAAYxZVABMEFADo:EAmAAG8AgAGTAiAAYxZVAJOEFADJ:EAmQAG8AgAATBPT/EwUEAJOFBAAm:EAmgAO8AQAWDIAEAAyRBAIMkgQDf:EAmwABMBwQBngAAAlwIAAJOCQhZ1:EAnAAAPFAgCDxRIAZ4AAAJcCAACD:EAnQAJOCIhUDxQIAg8USAGeAAADA:EAngAJcCAACTgsITI4CiAKOAsgBq:EAnwAGeAAACXAgAAk4KiEiOAogBp:EAoAAKOAsgBngAAAk48AABcFAADs:EAoQABMFRRHvAIAKk4APAGeAAADm:EAogAJOPAAAXBQAAEwWlEO8AAAnD:EAowAJOADwBngAAAk48AABcFAABv:EApAABMFpQ/vAIAHk4APAGeAAABb:EApQAJOPAAATDwQAEwQFABcFAAAW:EApgABMFZQ7vAIAFEwUEAJMFQAaN:EApwAGNstQDv8F/A7wBAAxOFBQAl:EAqAAJMFoABvAMAAkwWgAGNotQBH:EAqQAO/wn77vAIABE4UFAO8AAAEd:EAqgABMEDwCTgA8AZ4AAABMFBQP3:EAqwALcCAMAjgKIAZ4AAALcCAMAY:EArAAANDBQBjCAMAI4BiABMFFQA7:EArQAG/wH/9ngAAAAQAAAAAAAACx:EArgAAATCQ8UCBUQEAUFDw8fHxcN:EArwAB0HAggCDQMTCgAMAAALCwZx:EAsAAAYHHAocFw4fAQ4ODxERBBHv:EAsQAAMAHwICAAAAAAAAAAAAAACv:EAsgACoqKiBTbmFrZSAqKioAClM6:EAswAHRhcnQhAApHYW1lIE92ZXKZ:EAtAACEAIFNjb3JlOiAAAAAAAAAO:EBAAAAABAAAAAAABAQABAAAAAADc:EBAQAAABAAAAAAAAAAAAAAAAAAPM:AAAAAf8=>).

## Build From Source

1. Install RISC-V bare-metal compiler and bin utils. For example, in Manjaro:
  ```bash
  pamac install riscv64-elf-gcc riscv64-unknown-elf-binutils
  ```
  * If your distro uses a differently named compiler, install that and change line 1 in Makefile accordingly. For example `gcc-riscv64-unknown-elf` on Ubuntu.
2. Run Makefile:
```
make
```
3. Open [emulsiV](<http://tice.sea.eseo.fr/riscv/> "emulsiV") and upload executable `snake.hex` (button top left).

## Controls

To start the program, press "Run", top right. Afterwards, you can control the game via the gpio buttons.
