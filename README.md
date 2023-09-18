# mb-system-docker-vnc
Remote work with mb-system inside a Docker, run GUI applications

docker compose build
docker compose up

Run docker container with shared Data dir

TigerVNC Viewer can be used to connect to the container with params:
localhost:5920, passwd: SecretKey

<p align="center">
  <img src="Imgs/Screenshot_1.png" height="150"/>
  <img src="Imgs/Screenshot_2.png" height="150"/>
</p>

Desktop resolution and password can be changed in the start.sh file

<p align="center">
  <img src="Imgs/Screenshot_3.png" height="200"/>
  <img src="Imgs/Screenshot_4.png" height="200"/>
</p>

Some data to check the operation of the system can be downloaded from the resource
https://www.ngdc.noaa.gov/ships/ocean_alert/Loihi_mb.html

<p align="center">
  <img src="Imgs/Screenshot_5.png" height="300"/>
</p>


ls -1 | grep mb57 > list
mbdatalist -F-1 -I list > datalist.mb-1
mbm_plot -F-1 -I datalist.mb-1 -C -G1

<p align="center">
  <img src="Imgs/Screenshot_6.png" height="200"/>
  <img src="Imgs/Screenshot_7.png" height="200"/>
</p>

./datalist.mb-1.cmd

<p align="center">
  <img src="Imgs/Screenshot_8.png" height="200"/>
  <img src="Imgs/Screenshot_9.png" height="200"/>
</p>


Versions:
ENV MB_SYSTEM_V 5.7.9
ENV GMT_V 6.3.0
ENV GSHHG_V 2.3.7
ENV DCW_V 2.1.2
