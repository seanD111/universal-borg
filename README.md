# universal-borgmatic
This mod adds support for automated backups to any LinuxServer container. It includes borg, borgmatic, and ssh. 
By default, this mod will backup all contents from /config into /tmp/borgmatic-backup. 

To enable this mod, set an environment variable:
DOCKER_MODS=seand111/universal-borgmatic

The mod is also configured by the environment variables:
- BORGMATIC_PERIODIC   # how often borgmatic will run. valid options are '15min', 'hourly', 'daily' (default), 'weekly', or 'monthly'
- BORGMATIC_ENCRYPTION # the repo's encryption type. defaults to 'none'
- BORGMATIC_ROOT       # where borgmatic will store config and key files. defaults to '/config'
- BORGMATIC_SOURCE     # the root directory that will be backed up. defaults to '/config'
- BORGMATIC_REPO       # the directory where backups will be made. defaults to '/tmp/borgmatic-backup'

This mod will install the latest version of borgbackup (https://borgbackup.readthedocs.io/en/latest/installation.html) and borgmatic (https://torsion.org/borgmatic/). 
The behviour of the mod is determined by borgmatic's configuration file, which should be mounted in the directory:
- /config/.config/borgmatic/config.yaml

If using encryption, it is very important to keep your keys used to encrypt the repo. The keys' location is:
- /config/.config/borg/keys


By default, this mod will backup all contents from /config into a repository at /tmp/borgmatic-backup daily.
Users should modify the borgmatic.yaml config file to suit their needs. It will be automatically created if it is not volume or bind mounted.
The container has to be restarted if the BORGMATIC_PERIODIC or BORGMATIC_ENCRYPTION are modified.
