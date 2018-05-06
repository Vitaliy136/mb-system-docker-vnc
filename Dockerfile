FROM sameersbn/ubuntu:16.04.20180124
ENV DEBIAN_FRONTEND noninteractive

RUN ln -s -f /bin/true /usr/bin/chfn
RUN mkdir -p /tmp/.X11-unix
RUN chmod 1777 /tmp/.X11-unix

RUN apt-get update \
 && apt-get install -y \
  xvfb xfonts-100dpi xfonts-75dpi xfonts-scalable xfonts-cyrillic \
  python python-pip

RUN apt-get install fluxbox -y
RUN apt-get install x11vnc -y

# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/researcher && \
    echo "researcher:x:${uid}:${gid}:Researcher,,,:/home/researcher:/bin/bash" >> /etc/passwd && \
    echo "researcher:x:${uid}:" >> /etc/group && \
    echo "researcher ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/researcher && \
    chmod 0440 /etc/sudoers.d/researcher && \
    chown ${uid}:${gid} -R /home/researcher

RUN apt-get install -y build-essential cmake

RUN apt-get install -y ghostscript libmotif-dev mesa-common-dev \
    libgdal1-dev libfftw3-3 libfftw3-dev libpcre3-dev libnetcdf-dev \
    netcdf-bin gv csh libproj-dev freeglut3-dev

RUN apt-get install -y mc
RUN apt-get install -y firefox
RUN apt-get install -y terminator


ADD start.sh /home/researcher/start.sh
RUN chmod +x /home/researcher/start.sh


ENV HOME /home/researcher
WORKDIR /home/researcher


ENV MB_SYSTEM_V 5.5.2334
ENV GMT_V 5.4.3
ENV GSHHG_V 2.3.7
ENV DCW_V 1.1.3


VOLUME /home/researcher/Data
RUN mkdir /home/researcher/requirements

RUN cd /home/researcher/requirements && wget ftp://ftp.soest.hawaii.edu/dcw/dcw-gmt-$DCW_V.tar.gz && \
    tar -xvzf dcw-gmt-$DCW_V.tar.gz

RUN cd /home/researcher/requirements && wget ftp://ftp.soest.hawaii.edu/gshhg/gshhg-gmt-$GSHHG_V.tar.gz && \
    tar -xvzf gshhg-gmt-$GSHHG_V.tar.gz

RUN cd /home/researcher/requirements && wget ftp://ftp.soest.hawaii.edu/gmt/gmt-$GMT_V-src.tar.gz && \
    tar -xvzf gmt-$GMT_V-src.tar.gz && \
    DCW_DIR=$(cd dcw-gmt-$DCW_V && pwd) && \
    cd /home/researcher/requirements && \
    GSHHG_DIR=$(cd gshhg-gmt-$GSHHG_V && pwd) && \
    cd /home/researcher/requirements && \
    cd gmt-$GMT_V && \
    cp cmake/ConfigUserTemplate.cmake cmake/ConfigUser.cmake && \
    mkdir build && \
    cd build && \
    sudo cmake -DCMAKE_INSTALL_PREFIX=/usr/local -DCMAKE_BUILD_TYPE=RelWithDebInfo -DDCW_ROOT=$DCW_DIR -DGSHHG_ROOT=$GSHHG_DIR .. && \
    sudo make && \
    sudo make install

RUN cd /home/researcher/requirements && wget ftp://mbsystemftp@ftp.mbari.org/mbsystem-$MB_SYSTEM_V.tar.gz && \
    tar -xvzf mbsystem-$MB_SYSTEM_V.tar.gz && \
    cd mbsystem-$MB_SYSTEM_V && \
    sudo ./configure && \
    sudo make && \
    sudo make install

RUN cd /home/researcher/.gmt && \
    sudo gmt defaults -D > gmt.conf && \
    sudo sed -r -i "s/GMT_CUSTOM_LIBS\\s+=.*/GMT_CUSTOM_LIBS                = \\/usr\\/local\\/lib\\/mbsystem.so/" gmt.conf

USER researcher

ENTRYPOINT ["/home/researcher/start.sh"]
