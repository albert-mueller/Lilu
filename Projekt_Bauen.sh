#!/bin/sh
# Stoppt das Skript sofort, wenn ein Befehl fehlschlägt
set -e

# Sicherstellen, dass wir uns im Verzeichnis des Skripts befinden
cd "$(dirname "$0")"

# Funktion zum Klonen oder Aktualisieren
clone_or_update() {
    if [ ! -d "$1" ]; then
        git clone "$2" "$1"
    else
        echo "Aktualisiere $1..."
        cd "$1" && git pull && cd ..
    fi
}

# 1. Repositories klonen oder aktualisieren
clone_or_update "Lilu" "https://github.com/albert-mueller/Lilu/"
clone_or_update "MacKernelSDK" "https://github.com/acidanthera/MacKernelSDK"

# HINWEIS: Falls ein Fehler wegen 'xcodebuild' kommt, führe diesen Befehl 
# EINMALIG manuell im Terminal aus (nur nötig, wenn das System es noch nicht weiß):
# sudo xcode-select -s /Applications/Xcode.app/Contents/Developer

# 2. Lilu bauen
echo "Baue Lilu..."
cd Lilu
# Symlink für MacKernelSDK erstellen, falls noch nicht vorhanden
[ ! -L "MacKernelSDK" ] && ln -s ../MacKernelSDK MacKernelSDK
xcodebuild -configuration Debug
cd ..

echo "Der Bauprozess ist erfolgreich abgeschlossen!"
