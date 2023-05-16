#!/bin/bash

echo "Ajout de la table epytodo.sql à MySQL..."
mysql -u root -p < server/epytodo.sql

echo "Lancement du serveur Express..."
cd server
npm install

nodemon server.js &

sleep 1

echo "Lancement de l'application Flutter..."
cd ../client
flutter run

exit 0
