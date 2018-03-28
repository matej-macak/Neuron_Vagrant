FROM neuron:latest

# Copy mods to the new file folder
WORKDIR /shared
COPY /Mods/* /work/nrn-7.4/x86_64/bin/

RUN cd /work/nrn-7.4/x86_64/bin \
	&& nrnivmodl

EXPOSE 8888

ENTRYPOINT ["jupyter", "lab","--ip=0.0.0.0","--allow-root","--port=8888","--no-browser"]

# Start with: docker run -it -p 8888:8888 -v ~/OneDrive/Docker/Jupyter:/work jupyter
# -v flag binds the folder as a shared one for the image to see
