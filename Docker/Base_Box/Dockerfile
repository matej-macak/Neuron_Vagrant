FROM python:3.6

WORKDIR /work

RUN pip install jupyter -U && pip install jupyterlab

COPY requirements.txt /work

RUN pip install --trusted-host pypi.python.org -r requirements.txt

# replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# update the repository sources list
# and install dependencies
RUN apt-get update \
    && apt-get install -y curl \
    && apt-get -y autoclean

# nvm environment variables
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 8.10.0

# install nvm
# https://github.com/creationix/nvm#install-script
RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash

# install node and npm
RUN source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

# add node and npm to path so the commands are available
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# confirm installation
RUN node -v
RUN npm -v

# Run jupyter notebook
RUN jupyter nbextension enable --py --sys-prefix ipympl
RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager

# Install neuron
ARG NRN_VERSION="7.4"
ARG NRN_ARCH="x86_64"
ARG NRN_CONFIGURE_OPT="--without-iv --with-nrnpython=/usr/local/bin/python3.6 --with-paranrn --enable-static=yes"
ARG NRN_CFLAGS="-O3"
ARG NRN_CXXFLAGS="-O3"

RUN apt-get update \
    && apt-get install -y \
        locales \
        wget \
        gcc \
        g++ \
        build-essential \
        libpython-dev \
        libpython3-dev \
        libncurses-dev \
        cython \
        openmpi-bin \
        openmpi-common \
        libopenmpi-dev \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
    && wget http://www.neuron.yale.edu/ftp/neuron/versions/v${NRN_VERSION}/nrn-${NRN_VERSION}.tar.gz \
    && tar xvzf nrn-${NRN_VERSION}.tar.gz \
    && rm nrn-${NRN_VERSION}.tar.gz \
    && cd nrn-${NRN_VERSION} \
    && ./configure --prefix=`pwd` ${NRN_CONFIGURE_OPT} CFLAGS=${NRN_CFLAGS} CXXFLAGS=${NRN_CXXFLAGS} \
    && make \
    && make install \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get autoclean

RUN cd /work/nrn-7.4/src/nrnpython \
    && python3.6 setup.py install

# RUN useradd -m neuron
# USER neuron

ENV LANG en_US.utf8
ENV PATH $PATH:/work/nrn-7.4/x86_64/bin

WORKDIR /shared

EXPOSE 8888

ENTRYPOINT ["jupyter", "lab","--ip=0.0.0.0","--allow-root","--port=8888","--no-browser"]

# Start with: docker run -it -p 8888:8888 -v ~/OneDrive/Docker/Jupyter:/work jupyter
# -v flag binds the folder as a shared one for the image to see
