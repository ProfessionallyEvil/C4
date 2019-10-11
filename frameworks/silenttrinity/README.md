## Notes

### Checklist

- [x] special reason why good:
  - everything is handled in boolang, which have a few advantages
    - everything is simply text that gets passed around
      - mix of C# and python for ease of readability and coding
    - no necessary pre-compilation step (pretty much just interpreted/compiled(?) on client side)
    - pretty much all DotNet should work, because you are wrapping boolang around DotNet commands
    - Dynamically generate 
    - only 3rd party scripting language found so far that allows p-invoke out of the box (by author)
      - DotNet interopt
        - loading unmanaged dlls
        - calling unmanaged functions
- [x] future plans?
  - WCS in DotNet for peer to peer malware (i.e. inplants)
  - 
- [x] normal C2 functions
  - [x] jitter
  - [x] sleep
  - [ ] redirectors
- [ ] advanced C2 functions
  - [ ] peer to peer comms
- [ ] cool implant modules
  - boo/ps
    - colorize specific known processes (i.e. windows defender, etc..)
  - boo/winrm (lateral movement)
  - boo/minidump
    - dumps lsass from boo to disk (doesn't use mimikatz)
    - compresses and then chunks
    - sends chunks to server and puts it back together
    - get creds out of dump from pypy-cats
    - in tern only dumping on client side and parsing and running mimikatz serverside
    - boo/inject
      - just recently implemented donut
        - donut
          - implements an amsi bypass when it spins up the clr in a non-managed process
          - take DotNet assembley, convert it to position independent shellcode, so you can inject into remote process
- extras
  - convert already developed C# programs
    - install sharp develop (latest version not supported use 4.4)
    - New --> File --> C# --> Class --> Paste current C# code --> Tools --> Convert code to --> Boo
    - paste as SILENTTRINITY module
    - caveats
      - sometimes there are some C#'isms will have to manually convert/correct

### Running with Docker

#### Build

```
docker build --rm -f "Dockerfile" -t st-client:latest .
docker build --rm -f "Dockerfile" -t st-teamserver:latest .
```
#### Commands

```
# allow container dns discoverability
docker network create st

# teamserver
## teamserver listens on 80, 443, etc...
docker container run -d -p 80:80 -p 443:443 --name st-teamserver --net=st st-teamserver

# client
## share a volume with host to copy stagers out
## pass connection string
docker container run  -it --rm --name st-client --net=st  -v "$(pwd)../../stagers":/SILENTTRINITY/stagers/ st-client 'wss://elrey741:password@st-teamserver:5000'

## copy stagers off of client container
$ docker container exec -it st-client /bin/bash
# cp stager.ps1 stagers
```

## How to use
1) stand up teamserver
2) connect from client
3) setup listener
   1) set `BindIP` to 0.0.0.0
   2) set CallBackURLs to your internal Vagrant network IP (i.e. your external ip address in real life)
4) 