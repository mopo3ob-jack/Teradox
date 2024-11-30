# Solution

Solved using [apktool](https://apktool.org/).
Used for disassembling apk files.

```bash
java -jar apktool/apktool_2.10.0.jar d timer.apk
```

From there a simple grep reveals the flag in [apktool.yml](timer/apktool.yml).

```yml
  versionName: picoCTF{t1m3r_r3v3rs3d_succ355fully_17496}
```

-Lqnk4
