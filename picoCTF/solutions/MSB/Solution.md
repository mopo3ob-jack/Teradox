# Solution

As indicated by the title and tags, the image uses MSB, or Most Significant Bit
stenography. This technique involves hiding information within the most
significant bits of the bytes of the image.

I found a python script for decoding the image
*[here](https://github.com/Pulho/sigBits/tree/master)*.

```bash python sigBits.py -t=MSB
Ninja-and-Prince-Genji-Ukiyoe-Utagawa-Kunisada.flag.png ```

From here you can grep the output text for the flag.

```bash grep -o -P '.{0,50}picoCTF.{0,50}' outputSB.txt | grep 'picoCTF' ```

-Lqnk4
