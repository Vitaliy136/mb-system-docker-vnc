FROM ubuntu:latest
ENV DEBIAN_FRONTEND noninteractive

RUN ln -s -f /bin/true /usr/bin/chfn
RUN mkdir -p /tmp/.X11-unix
RUN chmod 1777 /tmp/.X11-unix

RUN apt update \
 && apt install -y \
  xvfb xfonts-100dpi xfonts-75dpi xfonts-scalable xfonts-cyrillic

RUN apt install fluxbox -y
RUN apt install x11vnc -y
RUN apt install wget -y
RUN apt install sudo -y

RUN apt install -y build-essential cmake

RUN apt-get install -y libnetcdf-dev libgdal-dev netcdf-bin \
  gmt libgmt6 libgmt-dev libproj-dev \
  libfftw3-3 libfftw3-dev libmotif-dev \
  xfonts-100dpi libglu1-mesa-dev \
  libopencv-dev gfortran libntirpc-dev gv

RUN apt install -y mc
RUN apt install -y firefox
RUN apt install -y terminator
RUN apt install -y git
RUN apt install -y man-db

RUN useradd -rm -d /home/researcher -s /bin/bash -g root -G sudo -u 1001 researcher
RUN echo "researcher ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

ADD start.sh /home/researcher/start.sh
RUN chmod +x /home/researcher/start.sh

RUN groupadd -g 1002 data
RUN usermod -aG data researcher


ENV HOME /home/researcher
WORKDIR /home/researcher


ENV MB_SYSTEM_V 5.7.9
ENV GMT_V 5.4.4
ENV GSHHG_V 2.3.7
ENV DCW_V 2.1.2
ENV MB_SYSTEM_V_TAG trndev-5.7.9beta58


VOLUME /home/researcher/Data
RUN mkdir /home/researcher/requirements


RUN cd /home/researcher/requirements && wget ftp://ftp.soest.hawaii.edu/dcw/dcw-gmt-$DCW_V.tar.gz && \
    tar -xvzf dcw-gmt-$DCW_V.tar.gz

RUN cd /home/researcher/requirements && wget ftp://ftp.soest.hawaii.edu/gshhg/gshhg-gmt-$GSHHG_V.tar.gz && \
    tar -xvzf gshhg-gmt-$GSHHG_V.tar.gz

RUN cd /home/researcher/requirements && git clone https://github.com/dwcaress/MB-System.git && \
     cd /home/researcher/requirements/MB-System && git checkout $MB_SYSTEM_V_TAG

RUN cd /home/researcher/requirements/MB-System && \

    sudo env CPPFLAGS=-I/usr/include/tirpc ./configure \
        --enable-mbtrn --enable-mbtnav --enable-opencv \
        --with-opencv-include=/usr/include/opencv4 \
        --with-opencv-lib=/lib/x86_64-linux-gnu && \

    export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH && \

    sudo make && \
    sudo make check && \
    sudo make install


RUN cpan Parallel::ForkManager
RUN gmt gmtset IO_NC4_CHUNK_SIZE classic
RUN gmt gmtset GMT_CUSTOM_LIBS /usr/local/lib/mbsystem.so

USER researcher

ENTRYPOINT ["/home/researcher/start.sh"]
