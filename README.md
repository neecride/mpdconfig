## Nous auron besoin des Rpmfusion 

créer un dossier `mpd` dans `.config` mettez y le fichier `mpd.conf` et ouvrir dans le terminal click droit dans le dossier voulu

et taper cette commande 

`mpd mpd.conf`

Si mpd était déjà démarré faite un killall mpd puis lancer la commande si dessu.

Nous auron aussi besoin de `ncmpcpp` un player en ligne de commande

`sudo dnf install ncmpcpp`

Vous avez un pdf d'utilisation [ici](https://github.com/neecride/mpdconfig/blob/main/ncmpcpp-installation-configuration-et-utilisation.pdf)

Les racourcis clavier basique de `ncmpcpp` 

`2` permet de naviguer dans votre dossier la barre despace permet de mettre une musique en playlist et enter permet de mettre la lecture 

Pour utiliser `mpd` dans une conssole

| Commande	| description |
|-----|----|
|`mpc toggle` | Lecture / Pause                                   |
|`mpc next`	  | Piste suivante                                    |
|`mpc prev`	  | Piste précédente                                  |
|`mpc stop`	  | Arrêter la lecture                                |
|`mpc volume` | [+10 / -10]	Monter/baisser le volume              |
|`mpc repeat` | [on/off]	Activer/désactiver la répétition        |
|`mpc random` | [on/off]	Activer/désactiver la lecture aléatoire |
|`mpc clear` | Vider la file d'attente de lecture (playlist)      |

## Utilisation avec mpdris2 et dynamique music pill sous gnome 

Allez chercher dynamique music pill dans gnome extension 

[Gnome extension](https://extensions.gnome.org/extension/9334/dynamic-music-pill)

Installation de mpdris2

`sudo dnf install mpdris2`

Fichier de service manuel (si besoin)

Emplacement : `~/.config/systemd/user/mpdris2.service`

```
[Unit]
Description=MPD to MPRIS2 bridge
After=network.target mpd.service
PartOf=graphical-session.target

[Service]
ExecStart=/usr/bin/mpDris2
Restart=on-failure
RestartSec=5

[Install]
WantedBy=default.target
```

Tester votre configuratiuon `mpdris2`

```
# Recharger
systemctl --user daemon-reload

# Activer
systemctl --user enable mpdris2

# Démarrer
systemctl --user start mpdris2

# Vérifier
systemctl --user status mpdris2
```

## Architecture des dossiers et fichiers de configuration 

```
~/
├── .config/
|   |
│   ├── mpd/
│   │   ├── mpd.conf
│   │   ├── mpd.db
│   │   ├── mpd.log
│   │   ├── mpd.pid
│   │   ├── mpdstate
│   │   └── playlists/
│   ├── mpDris2/
│   │   └── mpDris2.conf
│   └── systemd/
│       └── user/
│           └── mpdris2.service (optionnel)
├── Musique/
```
