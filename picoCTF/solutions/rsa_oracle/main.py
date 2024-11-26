from pwn import *
context(arch = 'i386', os = 'linux')
context.log_level='debug'

p = remote("titan.picoctf.net", 51130)

p.recvuntil(b"decrypt.")

c = int(open("password.enc").read())
# print(c)

p.sendline(b"E")
p.recvuntil(b"keysize):")
p.sendline(b"\x02")
p.recvuntil(b"mod n) ")
c_a = int(p.recvline())

p.sendline(b"D")
p.recvuntil(b"decrypt: ")
p.sendline(str(c * c_a).encode())
p.recvuntil(b"mod n): ")
m = int(int(p.recvline(), 16) / 2)
print(str(m).encode().decode('utf-8')) # m in decimal

p.interactive()
