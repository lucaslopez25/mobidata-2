import os
from pathlib import Path

RESULTFILENAME = "tudo.sql"

def generate_unifile():
    filelist = []
    place = Path(__file__).parent

    try:
        for file in Path(place).glob("*.sql"):
            with open(file, 'r', encoding='utf-8') as f:
                filelist.append(f.read())

        #print(filelist)

        with open(RESULTFILENAME, 'w', encoding='utf-8') as f:
            f.write(''.join(filelist))
            f.write('\n')
    except Exception as e:
        print("Error", str(e))

if __name__ == "__main__":
    generate_unifile()