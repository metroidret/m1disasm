import os
from pathlib import Path


class GfxEntry:
    def __init__(self, nes_bank, nes_address, size, path):
        self.rom_address = (nes_bank * 0x4000) + (nes_address & 0x3fff)
        self.size = size
        self.path = Path(f"./SRC/garbage/{path}.bin")

gfx_lists = {
    "": [
        GfxEntry(0x0,0x871E,  0x3B, "00_871E"),
        GfxEntry(0x0,0x8777,  0x34, "00_8777"),
        GfxEntry(0x0,0x92B4,   0x2, "00_92B4"),
        GfxEntry(0x0,0x952C,  0x34, "00_952C"),
        GfxEntry(0x0,0xA961, 0x29F, "00_A961"),
        GfxEntry(0x0,0xAF03,  0xFD, "song_end"),
        GfxEntry(0x0,0xB135,  0xCB, "song_intro"),
        GfxEntry(0x0,0xBF56,  0x5A, "sound_engine"),
        GfxEntry(0x1,0x8D3C,  0x24, "areas_common"),
        GfxEntry(0x1,0xAFF0,  0x10, "01_02_03_04_05_AFF0"),
        GfxEntry(0x1,0xB135,  0xCB, "song_bank1"),
        GfxEntry(0x1,0xBFD5,  0x25, "reset_switch"),
        GfxEntry(0x2,0xAFEC,   0x4, "metatile_bank2"),
        GfxEntry(0x2,0xB099, 0x167, "song_bank2"),
        GfxEntry(0x3,0xAF49,  0xA7, "metatile_bank3"),
        GfxEntry(0x3,0xB1A0,  0x60, "song_bank3"),
        GfxEntry(0x4,0x9280,  0xE0, "04_9280"),
        GfxEntry(0x4,0xAD32, 0x2BE, "metatile_bank4"),
        GfxEntry(0x4,0xB0E7, 0x119, "song_bank4"),
        GfxEntry(0x5,0x94B0,  0xB0, "05_94B0"),
        GfxEntry(0x5,0xAC23, 0x3CD, "metatile_bank5"),
        GfxEntry(0x5,0xB0E7, 0x119, "song_bank5"),
        GfxEntry(0x6,0x8AA0, 0x140, "06_8AA0"),
        GfxEntry(0x6,0x98A0,  0xE0, "06_98A0"),
        GfxEntry(0x6,0x99C0, 0x3E0, "06_99C0"),
        GfxEntry(0x6,0xB4B0,  0x10, "06_B4B0"),
        GfxEntry(0x6,0xB8C0,  0x10, "06_B8C0"),
        GfxEntry(0x6,0xB8D0, 0x6E0, "06_B8D0"),
        GfxEntry(0x7,0xFFAE,   0x2, "07_FFAE"),
        GfxEntry(0x7,0xFFD5,  0x25, "reset_fixed"),
    ],
    "pal": [
        GfxEntry(0x0,0x871E,  0x3B, "00_871E"),
        GfxEntry(0x0,0x8777,  0x34, "00_8777"),
        GfxEntry(0x0,0x92B4,   0x2, "00_92B4"),
        GfxEntry(0x0,0x952C,  0x34, "00_952C_pal"),
        GfxEntry(0x0,0xA961, 0x29F, "00_A961_pal"),
        GfxEntry(0x0,0xAEDF, 0x121, "song_end_pal"),
        GfxEntry(0x0,0xB135,  0xFB, "song_intro_pal"),
        GfxEntry(0x0,0xBF9F,  0x11, "sound_engine_pal"),
        GfxEntry(0x1,0x8D3C,  0x24, "areas_common"),
        GfxEntry(0x1,0xAFF0,  0x10, "01_02_03_04_05_AFF0_pal"),
        GfxEntry(0x1,0xB183,  0xAD, "song_bank1_pal"),
        GfxEntry(0x1,0xBFD5,  0x25, "reset_switch_pal"),
        GfxEntry(0x2,0xAFEC,   0x4, "metatile_bank2"),
        GfxEntry(0x2,0xB099, 0x197, "song_bank2_pal"),
        GfxEntry(0x3,0xAF49,  0xA7, "metatile_bank3"),
        GfxEntry(0x3,0xB22B,   0x5, "song_bank3_pal"),
        GfxEntry(0x4,0x9280,  0xE0, "04_9280"),
        GfxEntry(0x4,0xAD32, 0x2BE, "metatile_bank4"),
        GfxEntry(0x4,0xB0E7, 0x149, "song_bank4_pal"),
        GfxEntry(0x5,0x94B0,  0xB0, "05_94B0"),
        GfxEntry(0x5,0xAC23, 0x3CD, "metatile_bank5"),
        GfxEntry(0x5,0xB0E7, 0x149, "song_bank5_pal"),
        GfxEntry(0x6,0x8AA0, 0x140, "06_8AA0"),
        GfxEntry(0x6,0x98A0,  0xE0, "06_98A0"),
        GfxEntry(0x6,0x99C0, 0x3E0, "06_99C0"),
        GfxEntry(0x6,0xB4B0,  0x10, "06_B4B0_pal"),
        GfxEntry(0x6,0xB8C0,  0x10, "06_B8C0"),
        GfxEntry(0x6,0xB8D0, 0x6E0, "06_B8D0_pal"),
        GfxEntry(0x7,0xFFAE,   0x2, "07_FFAE_pal"),
        GfxEntry(0x7,0xFFD5,   0x3, "reset_fixed_pt1_pal"),
        GfxEntry(0x7,0xFFDB,  0x1F, "reset_fixed_pt2_pal"),
    ],
    "cns": [
        GfxEntry(0x0,0x871E,  0x3B, "00_871E"),
        GfxEntry(0x0,0x8777,  0x34, "00_8777"),
        GfxEntry(0x0,0x92B4,   0x2, "00_92B4"),
        GfxEntry(0x0,0x952C,  0x34, "00_952C"),
        GfxEntry(0x0,0xA961, 0x29F, "00_A961_cns"),
        GfxEntry(0x0,0xAF03,  0xFD, "song_end_cns"),
        GfxEntry(0x0,0xB135,  0xCB, "song_intro_cns"),
        GfxEntry(0x0,0xBF56,  0x5A, "sound_engine"),
        GfxEntry(0x1,0x8D3C,  0x24, "areas_common"),
        GfxEntry(0x1,0xAFF0,  0x10, "01_02_03_04_05_AFF0"),
        GfxEntry(0x1,0xB135,  0xCB, "song_bank1_cns"),
        GfxEntry(0x1,0xBFD5,  0x25, "reset_switch"),
        GfxEntry(0x2,0xAFEC,   0x4, "metatile_bank2"),
        GfxEntry(0x2,0xB099, 0x167, "song_bank2_cns"),
        GfxEntry(0x3,0xAF49,  0xA7, "metatile_bank3"),
        GfxEntry(0x3,0xB1A0,  0x60, "song_bank3"),
        GfxEntry(0x4,0x9280,  0xE0, "04_9280"),
        GfxEntry(0x4,0xAD32, 0x2BE, "metatile_bank4"),
        GfxEntry(0x4,0xB0E7, 0x119, "song_bank4"),
        GfxEntry(0x5,0x94B0,  0xB0, "05_94B0_cns"),
        GfxEntry(0x5,0xAC23, 0x3CD, "metatile_bank5"),
        GfxEntry(0x5,0xB0E7, 0x119, "song_bank5_cns"),
        GfxEntry(0x6,0x8AA0, 0x140, "06_8AA0"),
        GfxEntry(0x6,0x98A0,  0xE0, "06_98A0"),
        GfxEntry(0x6,0x99C0, 0x3E0, "06_99C0"),
        GfxEntry(0x6,0xB4B0,  0x10, "06_B4B0"),
        GfxEntry(0x6,0xB8C0,  0x10, "06_B8C0_cns"),
        GfxEntry(0x6,0xB8D0, 0x6E0, "06_B8D0"),
        GfxEntry(0x7,0xFFAE,   0x2, "07_FFAE"),
        GfxEntry(0x7,0xFFD5,  0x25, "reset_fixed"),
    ],
}


def extract_target(target_path, path_type):
    target_path = Path(target_path)
    try:
        with open(target_path, "rb") as f:
            target_bytes = f.read()
        if (len(target_bytes) & 0xFF) == 0x10:
            target_bytes = target_bytes[0x10:]
        for gfx in gfx_lists[path_type]:
            try:
                with open(gfx.path, "xb") as f:
                    f.write(target_bytes[gfx.rom_address:gfx.rom_address+gfx.size])
            except FileExistsError:
                pass
    except FileNotFoundError:
        print(f"{__name__}: warning, target baserom not found: {target_path}")


def extract():
    extract_target("baserom/M1_NES_NTSC.nes", "")
    extract_target("baserom/M1_NES_PAL.nes", "pal")
    extract_target("baserom/M1_NES_MZM.nes", "")
    extract_target("baserom/M1_NES_MZM_G.nes", "")
    extract_target("baserom/M1_NES_CNS.nes", "cns")


def clean():
    for gfx_list in gfx_lists.values():
        for gfx in gfx_list:
            if os.path.exists(gfx.path):
                os.remove(gfx.path)


if __name__ == "__main__":
    clean()
    extract()

