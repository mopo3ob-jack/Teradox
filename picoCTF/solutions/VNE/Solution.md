# Solution
``` bash
export SECRET_DIR='/root && cd /root && cat flag.txt'
```

The prompt gives us a binary in the home directory, which will run `ls` as root with an argument provided by the `SECRET_DIR` variable. 

Doing some digging in the root directory, we can see there is something suspicious in the `/root` folder due to the file permissions from `ls -al`. Running the binary on this directory reveals the `flag.txt` file.

The trick is that the script will not sanitize the input, instead it will treat anything in the `SECRET_DIR` variable as an argument to `ls`. It is revealed that the script is using `system()` behind the scenes when provided with an invalid payload in `SECRET_DIR`. To exploit this, simply put additional valid bash commands after satisfying the required arguments to `ls` and they will be executed as root. From there, you can simply `cat` the file.

Look at my 'ASCII' username C:

-Lqnk4
