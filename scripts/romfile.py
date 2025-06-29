class ROMFile:
    nes2hex = lambda n: (n // 0x10000 * 0x4000) + (n % 0x4000) + 0x10
    hex2nes = lambda n: ((n - 0x10) // 0x4000 * 0x10000) + ((n - 0x10) % 0x4000) + 0x8000

    def __init__(self, fp):
        self.file = open(fp, 'rb')

    def read(self, n):
        return self.file.read(n)

    def read_int(self, n):
        return int.from_bytes(self.read(n), 'little')

    def seek(self, addr):
        return self.file.seek(ROMFile.nes2hex(addr))

    def tell(self):
        return ROMFile.hex2nes(self.file.tell())
