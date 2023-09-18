# mb-system-docker-vnc
Remote work with mb-system inside a Docker, run GUI applications

docker compose build
docker compose up

Run docker container with shared Data dir

TigerVNC Viewer can be used to connect to the container with params:
localhost:5920, passwd: SecretKey

<p align="center">
  <img src="Imgs/Screenshot_1.png" height="300"/>
  <img src="Imgs/Screenshot_2.png" height="300"/>
</p>


Desktop resolution and password can be changed in the start.sh file

Some data to check the operation of the system can be downloaded from the resource
https://www.ngdc.noaa.gov/ships/ocean_alert/Loihi_mb.html
In Data dir

mbari_1998_53_msn.mb57
mbari_1998_53_msnp.mb57
mbari_1998_54_msn.mb57
mbari_1998_54_msnp.mb57
mbari_1998_55_msn.mb57
mbari_1998_55_msnp.mb57
mbari_1998_56_msn.mb57
mbari_1998_56_msnp.mb57
mbari_1998_57_msn.mb57
mbari_1998_57_msnp.mb57
mbari_1998_58_msn.mb57
mbari_1998_58_msnp.mb57
mbari_1998_59_msn.mb57
mbari_1998_59_msnp.mb57
mbari_1998_60_msn.mb57
mbari_1998_60_msnp.mb57
mbari_1998_61_msn.mb57
mbari_1998_61_msnp.mb57


ls -1 | grep mb57 > list
mbdatalist -F-1 -I list > datalist.mb-1
mbm_plot -F-1 -I datalist.mb-1 -C -G1
./datalist.mb-1.cmd


Versions:
ENV MB_SYSTEM_V 5.7.9
ENV GMT_V 6.3.0
ENV GSHHG_V 2.3.7
ENV DCW_V 2.1.2


<p align="center">
  <img src="Screenshot 1.png" height="300"/>
  <img src="Screenshot 2.png" height="300"/>
</p>

