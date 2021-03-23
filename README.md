# RDM Linux for SVN noobs

Make sure `msbuild`, `nuget` and `mono` are availables.

Clone this repository and update submodules.

```
$ git submodule init
$ git submodule update --depth=1 --remote
```

Use the `RDMOX-Shared.sh` script to fetch RDM library Shared among all platforms.

```
$ ./RDMOX-Shared.sh
```

Build using
```
$ ./build.sh
```

