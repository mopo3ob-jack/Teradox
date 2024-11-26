#include <stdio.h>

int foo(int, int);

int main() { 
    printf("%d", foo(0xb, 0x2e)); 
    return 0;
}

int foo(int a, int b) {
    int eax = b;  // 6
    int fa = eax; // 9 [ebp-4]
    eax = a;      // 12
    int fb = eax; // 15 [ebp-8]
    goto label28; // 18
label20:
    fa += 0x1;  // 20
    fb -= -128; // 24

label28:
    if (fb < 0x63f3) { // 28
        goto label20;  // 35
    }
    eax = fa;
    return eax;
}
