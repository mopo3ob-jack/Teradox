#include <stdbool.h>
#include <stdio.h>

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

int foo(int, int, int);

int main(int argc, char** argv) {

    int out = foo(0xba6c5a02, 0xd101e3dd, 0xbb86a173);
    printf("out: %x", out);

    return 0;
}

int foo(int a, int b, int c) {
    union reg_32 eax;
    eax.dword = 0;

    eax.lower.bytes.byte_h = (char)a;         // +5
    eax.lower.word <<= 0x10;                  // +8
    eax.lower.bytes.byte_l -= (char)(b >> 8); // +12
    eax.lower.bytes.byte_h += (char)(b);      // +15
    eax.lower.word ^= (short int)(c >> 16);        // +18

    printf("dword: %x, word: %x, byte_l: %x, byte_h: %x \n", eax.dword,
           eax.lower.word, eax.lower.bytes.byte_l, eax.lower.bytes.byte_h);

    return eax.dword;
}
