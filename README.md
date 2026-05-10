## Nous auron besoin des Rpmfusion 

*Configuration tester sous fedora et ubuntu avec le bureau gnome*

[Rpmfusion](https://rpmfusion.org/)

`sudo dnf install mpd`

créer un dossier `mpd` dans `.config` mettez y le fichier `mpd.conf` et ouvrir dans le terminal click droit dans le dossier voulu

et taper cette commande 

`mpd mpd.conf`

Si mpd était déjà démarré faite un killall mpd puis lancer la commande si dessu.

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


<details>
  
<summary>Nous auron aussi besoin de ncmpcpp un player en ligne de commande</summary>

<img width="916" height="748" alt="Capture d’écran du 2026-05-10 15-27-45" src="https://github.com/user-attachments/assets/3fe0ccef-7505-4e0d-82bf-6d30577f4303" />

`sudo dnf install ncmpcpp`

Vous avez un pdf d'utilisation [ici](https://github.com/neecride/mpdconfig/blob/main/ncmpcpp-installation-configuration-et-utilisation.pdf)

Les racourcis clavier basique de `ncmpcpp` 

| Commande	| description |
|------------|----------|
|`maj + 2`| permet de naviguer dans votre dossier musique| 
|`maj + 1`| permet d'afficher la playliste |
| <kbd style="background-color:#f4f4f4; border:1px solid #ccc; border-radius:4px; padding:0.2em 0.6em; font-weight:bold;">Backspace ⌫</kbd> | permet de mettre une musique en playlist|
| <kbd style="background-color:#f4f4f4; border:1px solid #ccc; border-radius:4px; padding:0.2em 0.6em; font-weight:bold;">Enter ⏎</kbd> | permet de mettre la lecture | 
</details>

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
## Résulta attendu 

<img width="423" height="350" alt="Capture d’écran du 2026-05-10 15-37-27" src="https://github.com/user-attachments/assets/2a04f90f-eae8-47a3-a014-c4fdb43eb9ef" />
