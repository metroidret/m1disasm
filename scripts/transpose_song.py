import argparse

def transpose_song(infile, transpose):
    with open(infile, "r") as f:
        lines = f.readlines()
    
    for line in lines:
        start_index = 0
        end_index = line.find(";")
        if end_index == -1:
            end_index = len(line)
        end_index = line[start_index:end_index].rfind("\"")
        if end_index == -1:
            print(line, end="")
            continue
        
        start_index = line[start_index:end_index].find("SongNote \"")
        if start_index == -1:
            print(line, end="")
            continue
        start_index += len("SongNote \"")
        
        old_strNote = line[start_index]
        old_strAccidentals = line[start_index+1:end_index-1]
        old_strOctave = line[end_index-1]
        
        old_noteValue = int(old_strOctave) * 12
        
        if old_strNote == "C":
            old_noteValue += 0
        elif old_strNote == "D":
            old_noteValue += 2
        elif old_strNote == "E":
            old_noteValue += 4
        elif old_strNote == "F":
            old_noteValue += 5
        elif old_strNote == "G":
            old_noteValue += 7
        elif old_strNote == "A":
            old_noteValue += 9
        elif old_strNote == "B":
            old_noteValue += 11
        else:
            raise Exception("bad strNote " + old_strNote)
        
        for accidental in old_strAccidentals:
            if accidental == "#":
                old_noteValue += 1
            elif accidental == "s":
                old_noteValue += 1
            elif accidental == "b":
                old_noteValue -= 1
            else:
                raise Exception("bad accidental " + accidental)
        
        new_noteValue = old_noteValue + int(transpose)
        
        new_octave = new_noteValue // 12
        new_strNote = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"][new_noteValue % 12]
        
        print(line[:start_index] + new_strNote + str(new_octave) + line[end_index:], end="")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('infile', help='Input song ASM file')
    ap.add_argument('-t', '--transpose', required=True, help='Input song ASM file')
    args = ap.parse_args()

    transpose_song(args.infile, args.transpose)


if __name__ == "__main__":
    main()
