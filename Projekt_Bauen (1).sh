#!/bin/sh
# Stoppt das Skript sofort, wenn ein Befehl fehlschlägt
set -e

# Sicherstellen, dass wir uns im Verzeichnis des Skripts befinden
cd "$(dirname "$0")"

# 1. Lilu und MacKernelSDK vorbereiten
if [ ! -d "Lilu" ]; then
    git clone https://github.com/albert-mueller/Lilu
fi
if [ ! -d "MacKernelSDK" ]; then
    git clone https://github.com/acidanthera/MacKernelSDK
fi

# 2. Lilu bauen
echo "Baue Lilu..."
cd Lilu

# Symlink für MacKernelSDK erstellen, falls noch nicht vorhanden
if [ ! -L "MacKernelSDK" ]; then
    ln -s ../MacKernelSDK MacKernelSDK
fi

# Bauen der Debug-Konfiguration
xcodebuild -configuration Debug

echo "Lilu wurde erfolgreich gebaut!"
# Das Ergebnis findest du in: Lilu/build/Debug/Lilu.kext