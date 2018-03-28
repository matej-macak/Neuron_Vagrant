# Installation
This directory contains the base box for `Docker` installation of neuron base box. This includes installation of `Python3.6` and dependencies as described in the file `requirements.txt`. The final container contains the following:

- Installation of `Python3.6` with standard data science and scientific libraries
- Installation of `Jupyter Lab` and exposure to port `8888` (this can be changed in the `Dockerfile`)
- Installation of `NodeJS` dependency for Jupyter Lab extensions
- `Neuron` installation with `Python` bindings (`version 7.4`)

Additional base boxes for specific purposes are contained in other folders.
