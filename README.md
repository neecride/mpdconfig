Guide en construction

# Fedora post install

## Nous auron besoin des Rpmfusion 

*Configuration tester sous fedora avec le bureau gnome*

Avant l'installation vérifier si vous n'avez pas déjà les rpm installer

`dnf repolist`

Passer par ce lien pour les [Rpmfusion](https://rpmfusion.org/)


<details>
  
<summary>Installation de music player daemon</summary>

## Après avoir intaller les Rpm passon a l'installation de mpd 

*Mpd (music player daemon) qui agit comme un serveur mais pour la musique en réseau.*

`sudo dnf install mpd`

|Fichier |	Rôle |
|------|---------|
| `~/.config/mpd/mpd.conf`	|Configuration de MPD|
| `~/.config/mpd/database`	|Base de données de votre bibliothèque|
| `~/.config/mpd/state` |	État de la lecture (piste en cours, volume, etc.)|

|Commande	|Que fait-elle ?|
|-----------|-------------|
| `systemctl --user start mpd`	|Démarre MPD maintenant|
| `systemctl --user stop mpd`	|Arrête MPD immédiatement|
| `systemctl --user restart mpd`	|Redémarre MPD (stop + start)|
| `systemctl --user status mpd`	|Affiche l'état de MPD (actif/arrêté/erreur)|

|Commande	| Que fait-elle ?|
|------|------|
| `systemctl --user enable mpd`	| Active le démarrage automatique au login|
| `systemctl --user disable mpd`	| Désactive le démarrage automatique|
| `systemctl --user is-enabled mpd`	| Vérifie si l'auto-démarrage est activé|

Créer un dossier `mpd` dans `.config` mettez y le fichier `mpd.conf` et ouvrir dans le terminal click droit dans le dossier et ouvrir avec un terminal, et ensuite entré cette commande 

`mpd ~/.config/mpd/mpd.conf`

Si mpd était est déjà démarré faite un `killall mpd` puis relancer la commande si dessu.

Pour utiliser `mpd` dans une conssole

*Si mpc n'est pas installer la console vous deamdera si elle peut l'installer, alors faite le*

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

---
</details>

---

<details>
  
<summary>Nous auron aussi besoin de ncmpcpp un player en ligne de commande</summary>

<img width="367" height="300" alt="Capture d’écran du 2026-05-10 15-27-45" src="https://github.com/user-attachments/assets/3fe0ccef-7505-4e0d-82bf-6d30577f4303" />

## installation

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

---

<details>
  
<summary>Installation de mpdris2</summary>

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
</details>

---

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

---

<details>
  
<summary> Bonus </summary>

## Access en local depuis votre smartphone (pour mon utilisation ça sera l'iphone)

Pour que les chose soit plus simple installon firewall-config

`sudo dnf install firewall-config`

Une fois installer démarrer le, et la première chose a faire et de selectionner configuration permanante

<img width="924" height="112" alt="Capture d’écran du 2026-05-11 10-56-38" src="https://github.com/user-attachments/assets/45f263bf-b9be-4071-9a87-a3a61098541e" />

---

Ensuite choisissez juste mpd dans la liste services et faite options > recharger le firewall

Pour trouver rapidement l'adresse IP locale utiliser cette commande : 

`ip a | grep "inet " | grep -v 127.0.0.1`

Cette commande retourne (exemple)

```
inet 192.168.1.45/24 brd 192.168.1.255 scope global dynamic wlp7s0
inet 192.168.1.10/24 brd 192.168.1.255 scope global dynamic enp8s0
```
Dans cette liste choisissez en fonctione de votre connexion wifi ou ethernet 

Dans mon cas j'ai choisis eternet `enp8s0` 

Maintenant installer sur votre iphone [MPD pilot](https://mpdpilot.app) la version gratuite suffit amplement.

Pour vous connecter depuis MPD pilot il faudra créer un profile local.

|Non de la connexion (faluctatif)|
|---------|
|Fedora|

|Nom d'hôte adresse ou adresse ip|
|--------|
|Utiliser une des IP wifi ou ethernet sans le `/24`|

|Port|
|----|
|6600|

|Dans le fichier `mpd.conf` modifié comme suite|
|-----------------------------|
```
bind_to_address			"any"
port				"6600"
```


Si tout fonctionne comme prévue vous pourrez utilisez votre smartphone comme télécommande 

<img width="300" height="650" alt="mpdpilot-main" src="https://github.com/user-attachments/assets/e3705489-b462-4ab0-9bb1-d6cf06479100" />

---

### Pour la configuration de ma g502 j'utilise piper qui remplace dans une moindre mesure g-hub de logitech 

`sudo dnf install piper`

</details>











