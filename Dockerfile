FROM ubuntu:16.04
RUN apt-get -y update
RUN apt-get install -y libboost-dev
RUN apt-get install -y libboost-test-dev
RUN apt-get install -y libboost-filesystem-dev
RUN apt-get install -y libboost-program-options-dev
RUN apt-get install -y libboost-graph-parallel-dev
RUN apt-get install -y libboost-thread-dev
RUN apt-get install -y libboost-regex-dev
RUN apt-get install -y python
RUN apt-get install -y g++
RUN apt-get install -y libeigen3-dev
RUN apt-get install -y python-simplejson
RUN apt-get install -y libboost-mpi-dev
RUN apt-get install -y openmpi-common
RUN apt-get install -y openmpi-bin
RUN apt-get install -y libgoogle-perftools-dev
RUN apt-get install -y git
RUN apt-get install -y wget
RUN apt-get install -y libtbb-dev
RUN apt-get install -y vim 
ENV LD_LIBRARY_PATH /usr/libx86_64-linux-gnu
RUN mkdir ~/git

# Installation et Configuration de Sferes2
RUN cd ~/git && git clone https://github.com/sferes2/sferes2.git && cd sferes2 && ./waf configure && ./waf build

# Installation et Configuration de LibFastSim
RUN cd ~/git/ && git clone https://github.com/jbmouret/libfastsim && cd libfastsim && ./waf configure && ./waf build

# Installation et Configuration de FastSim
RUN cd ~/git/sferes2/modules/ && git clone https://github.com/sferes2/fastsim && cd .. && echo fastsim >> modules.conf && ./waf configure && ./waf build

# Installation et Configuration de NN2
RUN cd ~/git/sferes2/modules/ && git clone https://github.com/sferes2/nn2 && cd .. && echo nn2 >> modules.conf && ./waf configure && ./waf build

# Installation et Configuration de CollectBall
RUN cd ~/git/sferes2/exp && git clone https://github.com/doncieux/collectball
RUN cd ~/git/sferes2/ && ./waf configure && ./waf build --exp=collectball

# Installation et Configuration de Modular_QD
RUN cd ~/git/sferes2/exp && git clone git clone https://github.com/sferes2/modular_QD.git
RUN cd ~/git/sferes2/ && ./waf configure  --cpp14=yes --exp modular_QD && ./waf build --exp=modular_QD

