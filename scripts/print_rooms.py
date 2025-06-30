import romfile

area_data = [
    ('brinstar', 0x10000, 0x32, 0x2F),
    ('norfair', 0x20000, 0x31, 0x2E),
    ('tourian', 0x30000, 0x20, 0x15),
    ('kraid', 0x40000, 0x27, 0x25),
    ('ridley', 0x50000, 0x1D, 0x2A),
]

enemy_names = {
    'brinstar': [
        'Sidehopper',
        'Ceiling sidehopper',
        'Waver',
        'Ripper',
        'Skree',
        'Zoomer',
        'Rio',
        'Zeb',
        'Kraid',
        "Kraid's lint",
        "Kraid's nail",
        'Null',
        'Null',
        'Null',
        'Null',
        'Null'
    ],
    'norfair': [
        'Geruta',
        'Geruta?',
        'Ripper II',
        'Null',
        'Null',
        'Null',
        'Nova',
        'Gamet',
        'Null',
        'Null',
        'Null',
        'Squeept',
        'Multiviola',
        'Dragon',
        'Polyp',
        'Null'
    ],
    'tourian': [
        'Red metroid',
        'Green metroid',
        '?',
        'Null',
        'Rinka',
        'Null',
        'Null',
        'Null',
        'Null',
        'Null',
        'Null',
        'Null',
        'Null',
        'Null',
        'Null',
        'Null'
    ],
    'kraid': [
        'Sidehopper',
        'Ceiling sidehopper',
        'Null',
        'Ripper',
        'Skree',
        'Zeela',
        'Null',
        'Geega',
        'Kraid',
        "Kraid's lint",
        "Kraid's nail",
        'Null',
        'Null',
        'Null',
        'Null',
        'Null'
    ],
    'ridley': [
        'Holtz',
        'Holtz?',
        'Dessgeega',
        'Ceiling dessgeega',
        'Null',
        'Null',
        'Viola',
        'Zebbo',
        'Null',
        'Ridley',
        "Ridley's fireball",
        'Null',
        'Multiviola',
        'Null',
        'Polyp',
        'Null'
    ]
}

door_names = [
    'Red door',
    'Blue door',
    '10-missile door',
    'Blue door that changes music to Mother Brain'
]

def print_structs(addr, num_structs):
    print('StrctPtrTbl:')
    for struct_i in range(num_rooms):
        print(f'    .word Structure{struct_i:02X}')
    print()
    for struct_i in range(num_structs):
        rom.seek(addr+struct_i*2)
        rom.seek((addr&0xFF0000)+rom.read_int(2))

        print(f'Structure{struct_i:02X}:')
        while True:
            n = rom.read_int(1)
            if n == 0xFF:
                print('    .byte $FF\n')
                break
            print(f'    .byte ${n:02X}, ', end='')
            print('    '*(n >> 4), end='$')
            row = [rom.read_int(1) for _ in range(0x10 if n & 0xF == 0 else n & 0xF)]
            print(',$'.join(f'{b:02X}' for b in row))

def print_rooms(addr, num_rooms, area_name):
    print('RmPtrTbl:')
    for room_i in range(num_rooms):
        print(f'    .word Room{room_i:02X}')
    print()
    for room_i in range(num_rooms):
        rom.seek(addr+room_i*2)
        rom.seek((addr&0xFF0000)+rom.read_int(2))

        print(f'Room{room_i:02X}:')
        print(f'    .byte ${rom.read_int(1):02X}')
        while True:
            pos = rom.read_int(1)
            if pos == 0xFF:
                print('    .byte $FF\n')
                break
            elif pos == 0xFE:
                print('    .byte $FE')
                continue
            elif pos == 0xFD:
                print('    .byte $FD')
                while True:
                    control = rom.read_int(1)
                    if control == 0xFF:
                        print('    .byte $FF\n')
                        break

                    num_params = (0, 2, 1, 0, 1, 0, 0, 2)[control & 0xF]
                    enemy = [control] + [rom.read_int(1) for _ in range(num_params)]
                    print(f'    .byte ${', $'.join(f'{b:02X}' for b in enemy)}', end='')

                    match control & 0xF:
                        case 1:
                            print(f' ; {enemy_names[area_name][enemy[1] & 0xF]}')
                        case 2:
                            print(f' ; {door_names[enemy[1] & 3]}')
                        case 4:
                            print(f' ; Elevator')
                        case 6:
                            print(f' ; Statues')
                        case 7:
                            print(f' ; {enemy_names[area_name][enemy[1] & 0xF]}')
                        case _:
                            print('')
                break
            struct_i = rom.read_int(1)
            pal = rom.read_int(1)
            print(f'    .byte ${pos:02X}, ${struct_i:02X}, ${pal:02X}')

rom = romfile.ROMFile('M1.nes')

for area_name, bank, num_structs, num_rooms in area_data:
    rom.seek(bank+0x959C)
    print_structs(bank+rom.read_int(2), num_structs)

    rom.seek(bank+0x959A)
    print_rooms(bank+rom.read_int(2), num_rooms, area_name)
