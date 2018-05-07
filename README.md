# mb-system-docker-vnc
Remote work with mb-system inside a Docker, run GUI applications

sudo docker build -t mb-system .

Run docker container with shared dir

sudo docker run -p 5920:5920 -v mb/Data:/home/researcher/Data mb-system

vncviewer localhost:5920
(passwd: SecretKey)


Versions:
MB_SYSTEM 5.5.2334
GMT 5.4.3
GSHHG 2.3.7
DCW 1.1.3


<p align="center">
  <img src="Screenshot 1.png" height="300"/>
  <img src="Screenshot 2.png" height="300"/>
</p>

