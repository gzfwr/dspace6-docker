# Dieses Script führt auf einem frisch installierten Debian 10.7 alle Installationsschritte durch, um die aktuellen Docker-Container für DSpace6 (dspace und dspacedb) aus dem GzFWR-GitHub-Repository zu holen und zu starten. Vorerst zum Erstellen einer DSpace-Testinstanz.
# Script als Root-User ausführen!
# Autoren: Jannis, Stefan, Clemens
# Doku: https://github.com/DSpace/DSpace/tree/dspace-6_x/dspace/src/main/docker-compose

#!/bin/sh
# Prüfen, ob Script als root ausgeführt wird
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

# Paketquellen aktualisieren
apt-get update -y
apt-get upgrade -y

# Benötigte Pakete installieren
apt-get install curl -y
apt-get install git -y # sollte aber eigentlich schon vorher installiert sein

# Docker-Install
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

# Docker-Compose "Install"
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Container starten
cd dspace6-docker # Ordner des heruntergeladenen GzFWR-Git-Repositories
docker-compose up -d
date
echo "5 Minuten warten, bis Container gestartet wurden"
sleep 5m # Warten bis Container gestartet

# Administrator-Konto mit Beispiel-Daten anlegen
docker-compose -f docker-compose-cli.yml run dspace-cli create-administrator -e test@test.edu -f admin -l user -p admin -c en
echo "1 Minute warten, bis Container gestartet wurden"
date
sleep 1m # Warten bis Container gestartet

# Testdaten in Respoitory laden
docker-compose -f docker-compose-cli.yml -f dspace/cli.ingest.yml run dspace-cli

echo "$(tput setaf 2)Skript vollständig durchlaufen.$(tput sgr 0)"
echo "Frontend sollte jetzt im Browser unter http://localhost:8080/xmlui aufrufbar sein"
