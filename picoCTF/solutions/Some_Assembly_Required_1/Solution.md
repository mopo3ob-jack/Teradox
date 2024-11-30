# Solution

[http://mercury.picoctf.net:36152/index.html](http://mercury.picoctf.net:36152/index.html)

My first thought was to analyze the long string response from the JIFxzHyW8W
request, which cyberchef identified as a wasm binary.

Firefox's Debugger tab revelead the G82XCw5CX3.js file under `wasm://` , which contains the flag at the bottom.
