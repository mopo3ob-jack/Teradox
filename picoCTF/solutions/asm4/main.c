#include <stdbool.h>
#include <stdio.h>

int foo(char* s);

union reg_32 {
    union reg_16 {
        struct {
            char byte_l;
            char byte_h;
        } bytes;
        short int word;
    } lower;
    int dword;
};

union reg_64 {
    union reg_32 lower;
    unsigned long qword;
    char* ptr;
};

int main() {
    char* s = "picoCTF_f97bb";
    printf("Out: %x\n", foo(s));
    return 0;
}

int foo(char* s) {
    // hack for pointer arithmetic
    union reg_64 rax;
    union reg_64 rbx;
    union reg_64 rcx;
    union reg_64 rdx;

    union reg_32* eax = &rax.lower;
    union reg_32* ebx = &rbx.lower;
    union reg_32* ecx = &rcx.lower;
    union reg_32* edx = &rdx.lower;

    rax.qword = (unsigned long)0;
    rbx.qword = (unsigned long)0;
    rcx.qword = (unsigned long)0;
    rdx.qword = (unsigned long)0;

    // _start

    int ebp_minus_0x10 = 0x27a; // 7
    int ebp_minus_0xc = 0x0;    // 14
    goto label27;               // 21
label23:
    ebp_minus_0xc += 1; // 23
label27:
    edx->dword = ebp_minus_0xc;         // 27
    rax.ptr = s;                        // 30
    eax->dword += edx->dword;           // 33
    eax->dword = (char)*rax.ptr;        // 35
    if (eax->lower.bytes.byte_l != 0) { // 38
        goto label23;                   // 40
    }
    int ebp_minus_0x8 = 0x1;              // 42
    goto label138;                        // 49
    edx->dword = ebp_minus_0x8;           // 51
    rax.ptr = s;                          // 54
    eax->dword += edx->dword;             // 57
    eax->dword = (char)*rax.ptr;          // 59
    edx->dword = eax->lower.bytes.byte_l; // 62
    eax->dword = ebp_minus_0x8;           // 65
    rcx.ptr = rax.ptr - 0x1;              // 68;
    rax.ptr = s;                          // 71
    eax->dword += ecx->dword;             // 74
    eax->dword = (char)*rax.ptr;          // 76
    eax->dword = eax->lower.bytes.byte_l; // 79
    edx->dword -= eax->dword;             // 82
    eax->dword = edx->dword;              // 84
    edx->dword = eax->dword;              // 86
    eax->dword = ebp_minus_0x10;          // 88
    rbx.ptr = edx->dword + rax.ptr;       // 91
    eax->dword = ebp_minus_0x8;           // 94
    rdx.ptr = rax.ptr + 0x1;              // 97
    rax.ptr = s;                          // 100
    eax->dword += edx->dword;             // 103
    eax->dword = (char)*rax.ptr;          // 105
    edx->dword = eax->lower.bytes.byte_l; // 108
    ecx->dword = ebp_minus_0x8;           // 111
    rax.ptr = s;                          // 114
    eax->dword += ecx->dword; // 117
    eax->dword = (char) *rax.ptr; // 119
    eax->dword = eax->lower.bytes.byte_l; // 122
    edx->dword -= eax->dword; // 125
     


label138:

    // log
    printf("s: | %p | %s\n", s, s);
    printf("rax: | %lx | %x | %x | h: %x | l: %x\n", rax.qword, eax->dword,
           eax->lower.word, eax->lower.bytes.byte_h, eax->lower.bytes.byte_l);
    printf("rbx: | %lx | %x | %x | h: %x | l: %x\n", rbx.qword, ebx->dword,
           ebx->lower.word, ebx->lower.bytes.byte_h, ebx->lower.bytes.byte_l);
    printf("rcx: | %lx | %x | %x | h: %x | l: %x\n", rcx.qword, ecx->dword,
           ecx->lower.word, ecx->lower.bytes.byte_h, ecx->lower.bytes.byte_l);
    printf("rdx: | %lx | %x | %x | h: %x | l: %x\n", rdx.qword, edx->dword,
           edx->lower.word, edx->lower.bytes.byte_h, edx->lower.bytes.byte_l);
    return eax->dword;
}
