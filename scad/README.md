# scad

Experimental spike of the bioreactor Sehan is developing, remade in OpenSCAD using the
[`iso4796-bottle-scad`](https://github.com/CameronBrooks11/iso4796-bottle-scad) and
[`din168-thread-scad`](https://github.com/CameronBrooks11/din168-thread-scad) libraries created
during the design and commissioning of
[`open-source-bioreactor`](https://github.com/uwo-fast/open-source-bioreactor).

## Libraries

Both libraries are pinned in [`scadman.toml`](../scadman.toml), and
[`scadman.lock`](../scadman.lock) records the exact commit and a content hash of each. With
[scadman](https://github.com/CameronBrooks11/scadman) installed:

```sh
just setup        # install the pinned libraries into .scadman/env
just check-scad   # render every file here, failing on any warning
```

The justfile puts `.scadman/env` first on `OPENSCADPATH`. To open a model in the OpenSCAD GUI
with the same libraries, run `scadman run scad/bioreactor.scad`, or set `OPENSCADPATH` to what
`scadman env` prints.
