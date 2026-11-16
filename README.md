# lab-grade-bioreactor

> An open source, lab-grade bioreactor with closed-loop control over culture
> parameters.

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.24148456.svg)](https://doi.org/10.5281/zenodo.24148456)
[![check](https://github.com/uwo-fast/lab-grade-bioreactor/actions/workflows/check.yml/badge.svg)](https://github.com/uwo-fast/lab-grade-bioreactor/actions/workflows/check.yml)
[![Software: GPL-3.0-or-later](https://img.shields.io/badge/Software-GPL--3.0--or--later-blue.svg)](LICENSES/GPL-3.0-or-later.txt)
[![Hardware: CERN-OHL-S-2.0](https://img.shields.io/badge/Hardware-CERN--OHL--S--2.0-orange.svg)](LICENSES/CERN-OHL-S-2.0.txt)
[![Contributions welcome](https://img.shields.io/badge/Contributions-welcome-brightgreen.svg)](https://github.com/uwo-fast/.github/blob/main/CONTRIBUTING.md)

## Overview

The aims are closed-loop control over culture parameters, a vessel that can be
autoclaved, and a modular, extensible build that serves as a test bed for biological
research and new system developments ([docs/](docs/README.md)).

**Status:** early design. Dated CAD exports (STEP) and bills of materials are
committed here, alongside an OpenSCAD spike of the vessel and lid in `scad/`. Open
work is in the [issues](https://github.com/uwo-fast/lab-grade-bioreactor/issues).

## Repository layout

- `cad/` -- CAD exports, one dated folder per export (`cad/YYYY-MM-DD/`)
- `bom/` -- bills of materials, dated the same way
- `scad/` -- the OpenSCAD model of the vessel and lid
- `software/` -- points at where the control software is developed for now
- `docs/` -- objectives and the release procedure
- `scripts/`, `tests/` -- the release script and its tests

## Getting started

The OpenSCAD model needs [OpenSCAD](https://openscad.org/) (developed on the
2026.10.15 snapshot), [just](https://github.com/casey/just) and
[scadman](https://github.com/CameronBrooks11/scadman), which installs the two
libraries it uses at the revisions `scadman.lock` pins:

```sh
just setup   # install the pinned OpenSCAD libraries into .scadman/env
just check   # shell format and lint, and render every scad/ file
```

See [scad/README.md](scad/README.md) for opening the model in the OpenSCAD GUI.

## Releases

Releases are dated snapshots (`YYYY.MM.DD`). What changed is in
[CHANGELOG.md](CHANGELOG.md); how one is cut is in
[docs/releasing.md](docs/releasing.md). Each release is archived on Zenodo; the
DOI badge above resolves to the latest one.

## Contributing

Contributions are welcome. See the organization
[contribution guide](https://github.com/uwo-fast/.github/blob/main/CONTRIBUTING.md).

## Citation

If you use this project in your work, please cite it. Use the **Cite this
repository** button on GitHub, or see [`CITATION.cff`](CITATION.cff).

## License

Copyright (C) 2025–2026 FAST Research Group

This project is free software: you may redistribute it and/or modify it under the
terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) any later version.
Hardware design files and the outputs generated from them are licensed instead
under [CERN-OHL-S-2.0](LICENSES/CERN-OHL-S-2.0.txt). See
[`LICENSING.md`](LICENSING.md) for what applies where, and the organization
[licensing policy](https://github.com/uwo-fast/.github/blob/main/LICENSING.md) for
why.

## Contact

Maintained by the [FAST research group](https://uwo-fast.github.io/). For
research collaboration inquiries, contact Dr. Joshua Pearce
(<joshua.pearce@uwo.ca>).
