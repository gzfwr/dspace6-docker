# DSpace 6 Docker Deployment

## Lokales Testen

### Einrichten einer lokalen Testinstanz

Auf einem frisch installierten Debian 10 wird Git installiert und das GzFWR-Repo gecloned.
`sudo apt-get install git -y
git clone https://github.com/gzfwr/dspace6-docker`

Anschließend wird das Skript *install-testsetup-from-scratch.sh* ausführbar gemacht und ausgeführt.
`cd dspace6-docker
chmod +x ./install-testsetup-from-scratch.sh
sh ./install-testsetup-from-scratch.sh`

Nach erfolgreichem Durchlaufen des Skripts sollte das DSpace-Frontend unter *http://localhost:8080/xmlui* aufrufbar sein.


## Production Deployment (repository.gzfwr.de)

Auf Server x ist dieses Git Repository gecloned. Folgende
