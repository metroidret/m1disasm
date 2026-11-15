import os
from pathlib import Path


class GfxEntry:
    def __init__(self, nes_bank, nes_address, size, path, alt_paths=[]):
        self.rom_address = (nes_bank * 0x4000) + (nes_address & 0x3fff)
        self.size = size
        self.path = {}
        self.path[""] = Path(f"./SRC/{path}.chr")
        self.path["mzm"] = Path(f"./SRC/{path}_mzm.chr") if "mzm" in alt_paths else self.path[""]
        self.path["cns"] = Path(f"./SRC/{path}_cns.chr") if "cns" in alt_paths else self.path["mzm"]

gfx_list = [
    GfxEntry(0x1,0x8D60, 0x400, "ending/end_font", ["mzm", "cns"]),
    GfxEntry(0x1,0x9160, 0x400, "brinstar/sprite_tiles", ["cns"]),
    GfxEntry(0x2,0x8D60, 0x400, "norfair/sprite_tiles", ["cns"]),
    GfxEntry(0x2,0x9160, 0x400, "tourian/sprite_tiles", ["cns"]),
    GfxEntry(0x3,0x8D60, 0x400, "kraid/sprite_tiles", ["cns"]),
    GfxEntry(0x3,0x9160, 0x400, "ridley/sprite_tiles", ["cns"]),
    GfxEntry(0x4,0x8D60, 0x520, "ending/sprite_tiles", ["cns"]),
    GfxEntry(0x4,0x9360, 0x200, "kraid/bg_chr_3", ["mzm", "cns"]),
    GfxEntry(0x5,0x8D60, 0x450, "common_chr/bg_CRE", ["mzm", "cns"]),
    GfxEntry(0x5,0x91B0, 0x300, "tourian/font_chr", ["cns"]),

    GfxEntry(0x6,0x8000, 0x7B0, "common_chr/samus", ["cns"]),
    GfxEntry(0x6,0x87B0, 0x1F0, "common_chr/items", ["cns"]),
    GfxEntry(0x6,0x89A0, 0x100, "common_chr/intro_sprites"),
    GfxEntry(0x6,0x8BE0, 0x500, "common_chr/title", ["mzm", "cns"]),
    GfxEntry(0x6,0x90E0, 0x7B0, "common_chr/samus_suitless", ["cns"]),
    GfxEntry(0x6,0x9890,  0x10, "common_chr/exclamation_point", ["mzm"]),
    GfxEntry(0x6,0x9980,  0x40, "common_chr/solid"),
    GfxEntry(0x6,0x9DA0, 0x150, "brinstar/bg_chr_1", ["mzm", "cns"]),
    GfxEntry(0x6,0x9EF0, 0x800, "common_chr/bg_CRE_2", ["mzm", "cns"]),
    GfxEntry(0x6,0xA6F0, 0x260, "norfair/bg_chr_1", ["mzm", "cns"]),
    GfxEntry(0x6,0xA950,  0x70, "norfair/bg_chr_2", ["mzm", "cns"]),
    GfxEntry(0x6,0xA9C0, 0x2E0, "common_chr/bg_boss_areas", ["mzm", "cns"]),
    GfxEntry(0x6,0xACA0, 0x600, "tourian/bg_chr", ["mzm", "cns"]),
    GfxEntry(0x6,0xB2A0,  0x90, "tourian/zebetite_chr", ["cns"]),
    GfxEntry(0x6,0xB330,  0xC0, "kraid/bg_chr_2", ["mzm", "cns"]),
    GfxEntry(0x6,0xB3F0,  0xC0, "ridley/bg_chr", ["mzm", "cns"]),
    GfxEntry(0x6,0xB4C0, 0x400, "common_chr/font", ["mzm", "cns"]),
]

gfx_folder_list = {
    "GFX_Samus": ["common_chr/samus", 0x7B0, "common_chr/items"],
    "GFX_EndingSprites": ["ending/sprite_tiles"],
    "GFX_TheEndFont": ["ending/end_font_mzm"],
    "GFX_BrinBG1": ["brinstar/bg_chr_1_mzm"],
    "GFX_CREBG1": ["common_chr/bg_CRE_mzm"],
    "GFX_CREBG2": ["common_chr/bg_CRE_2_mzm"],
    "GFX_BrinstarSprites": ["brinstar/sprite_tiles"],
    "GFX_NorfBG1": ["norfair/bg_chr_1_mzm"],
    "GFX_NorfBG2": ["norfair/bg_chr_2_mzm"],
    "GFX_NorfairSprites": ["norfair/sprite_tiles"],
    "GFX_BossBG": ["common_chr/bg_boss_areas_mzm"],
    "GFX_TourBG": ["tourian/bg_chr_mzm"],
    "GFX_Zebetite": ["tourian/zebetite_chr"],
    "GFX_TourianSprites": ["tourian/sprite_tiles"],
    "GFX_KraiBG2": ["kraid/bg_chr_2_mzm"],
    "GFX_KraiBG3": ["kraid/bg_chr_3_mzm"],
    "GFX_KraidSprites": ["kraid/sprite_tiles"],
    "GFX_RidlBG": ["ridley/bg_chr_mzm"],
    "GFX_RidleySprites": ["ridley/sprite_tiles"],
    "GFX_IntroSprites": ["common_chr/intro_sprites"],
    "GFX_Title": ["common_chr/title_mzm"],
    "GFX_Solid": ["common_chr/solid"],
    "GFX_Font": ["common_chr/font_mzm"],
    "GFX_SamusSuitless": ["common_chr/samus_suitless"],
    "GFX_ExclamationPoint": ["common_chr/exclamation_point_mzm"],
}


def extract_target(target_path, path_type):
    target_path = Path(target_path)
    try:
        with open(target_path, "rb") as f:
            target_bytes = f.read()
        if (len(target_bytes) & 0xFF) == 0x10:
            target_bytes = target_bytes[0x10:]
        for gfx in gfx_list:
            try:
                with open(gfx.path[path_type], "xb") as f:
                    f.write(target_bytes[gfx.rom_address:gfx.rom_address+gfx.size])
            except FileExistsError:
                pass
    except FileNotFoundError:
        print(f"{__name__}: warning, target baserom not found: {target_path}")


# svc #$11
def decomp_lz_bios(src: bytes, idx: int) -> tuple[bytes, int]:
    magic = src[idx]
    assert magic == 0x10
    
    decomp_size = int.from_bytes(src[idx+1:idx+4], byteorder='little', signed=True)
    
    output = bytearray(decomp_size)

    start = idx
    dst = 0
    
    idx += 4

    while (True):
        cflag = src[idx]
        idx += 1

        for _ in range(8):
            if (cflag & 0x80) == 0:
                # Uncompressed
                output[dst] = src[idx]
                idx += 1
                dst += 1
            else:
                # Compressed
                amount_to_copy = (src[idx] >> 4) + 3
                window = ((src[idx] & 0xF) << 8) + src[idx + 1] + 1
                idx += 2

                for _ in range(amount_to_copy):
                    output[dst] = output[dst - window]
                    dst += 1

            if dst >= decomp_size:
                if dst > decomp_size:
                    raise ValueError("Too many bytes copied at end")
                comp_size = idx - start
                return bytes(output), comp_size
            cflag <<= 1


def extract_from_mzm_gfx_folder():
    if Path("baserom/gfx").exists():
        for mzm_gfx, gfx_l in gfx_folder_list.items():
            mzm_gfx_comp_path = Path(f"baserom/gfx/{mzm_gfx}.nes.lz")
            try:
                with open(mzm_gfx_comp_path, "rb") as f:
                    mzm_gfx_comp_data = f.read()
            except FileNotFoundError:
                print(f"{__name__}: warning, mzm gfx folder entry not found: {target_path}")
                continue
            mzm_gfx_decomp_data, _ = decomp_lz_bios(mzm_gfx_comp_data, 0)
            
            for i in range(0, len(gfx_l), 2):
                gfx_path = Path(f"./SRC/{gfx_l[i+0]}.chr")
                gfx_len = len(mzm_gfx_decomp_data)
                if i+1 < len(gfx_l):
                    gfx_len = gfx_l[i+1]
                gfx_data = mzm_gfx_decomp_data[:gfx_len]
                mzm_gfx_decomp_data = mzm_gfx_decomp_data[gfx_len:]
                try:
                    with open(gfx_path, "xb") as f:
                        f.write(gfx_data)
                except FileExistsError:
                    pass
    else:
        print(f"{__name__}: warning, mzm gfx folder not found: baserom/gfx")
    
    # special case for GFX_TourianFont, it is already in M1_NES_MZM
    target_path = Path("baserom/M1_NES_MZM.nes")
    path_type = "mzm"
    try:
        with open(target_path, "rb") as f:
            target_bytes = f.read()
        if (len(target_bytes) & 0xFF) == 0x10:
            target_bytes = target_bytes[0x10:]
        gfx = [gfx for gfx in gfx_list if "tourian/font_chr" in str(gfx.path[path_type])][0]
        try:
            with open(gfx.path[path_type], "xb") as f:
                f.write(target_bytes[gfx.rom_address:gfx.rom_address+gfx.size])
        except FileExistsError:
            pass
    except FileNotFoundError:
        print(f"{__name__}: warning, target baserom not found: {target_path}")


def extract():
    extract_target("baserom/M1_NES_NTSC.nes", "")
    extract_target("baserom/M1_NES_PAL.nes", "")
    extract_from_mzm_gfx_folder()
    extract_target("baserom/M1_NES_MZM_G.nes", "mzm")
    extract_target("baserom/M1_NES_CNS.nes", "cns")


def clean():
    for gfx in gfx_list:
        for path in gfx.path.values():
            if os.path.exists(path):
                os.remove(path)

# EoF
