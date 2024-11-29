# Solution

Script stolen from [Dvd848](https://github.com/Dvd848/CTFs/blob/master/2021_picoCTF/Mini_RSA.md) as the original haskell code had a bug.

Since e is small, we can simply take the $(1/e)$ power of our ciphertext c. However, c only satisfies $m^e = c mod n$. The
padding means that we will have to try combinations of $(c + kn)^(1/e)$.

-Lqnk4
