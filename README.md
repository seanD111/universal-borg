# universal-borgmatic
This mod adds support for automated backups to any LinuxServer container. It includes borg, borgmatic, and ssh. 
By default, this mod will backup all contents from /config into /tmp/borgmatic-backup. 

To enable this mod, set an environment variable:
DOCKER_MODS=seand111/universal-borgmatic

This mod will install the latest version of borgbackup (https://borgbackup.readthedocs.io/en/latest/installation.html) and borgmatic (https://torsion.org/borgmatic/). 
The behviour of the mod is determined by borgmatic's configuration file and crontab, in their respective directories:
- /config/borgmatic.yaml
- /config/crontabs/root

By default, this mod will backup all contents from /config into a repository at /tmp/borgmatic-backup. The default crontab will run borgmatic nightly at 3:00 am.
Users should modify the borgmatic.yaml and crontab config file to suit their needs.
These files will be automatically created if they are not volume or bind mounted. If these configurations are modified, the container should be restarted for borgmatic and
cron to use the new settings.

