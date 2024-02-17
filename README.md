# universal-borgmatic
This mod adds support for automated backups to any LinuxServer container. It includes borg, borgmatic, and ssh. 
By default, this mod will backup all contents from /config into /tmp/borgmatic-backup. 

To enable this mod, set an environment variable:
DOCKER_MODS=seand111/universal-borgmatic

This mod will install the latest version of borgbackup (https://borgbackup.readthedocs.io/en/latest/installation.html) and borgmatic (https://torsion.org/borgmatic/). 
The behviour of the mod is determined by borgmatic's configuration file and crontab, in their respective directories:
- /config/borgmatic.yaml
- /config/crontabs/abc

By default, this mod will backup all contents from /config into a repository at /tmp/borgmatic-backup. The default crontab will run borgmatic nightly at 3:00 am.
Users should modify the borgmatic.yaml and crontab config file to suit their needs.
These files will be automatically created if they are not volume or bind mounted. If these configurations are modified, the container should be restarted for borgmatic and
cron to use the new settings.

This mod uses the following environment variables:
- BORG_SOURCE_DIRECTORY # defaults to /config; this will get inserted into 'source_directories' 
- BORG_REPO             # defaults to /tmp/borgmatic-backup; the borg repository to store backups
- BORG_REPO_KEY         # optional; this will get inserted into 'encryption_passphrase'. If not set, the borg repo will not be encrypted. 
- BORG_RESTORE_ARCHIVE  # optional; if used, the mod will extract the named archive contents of the borg repository into BORG_SOURCE_DIRECTORY, overwriting any duplicate files. 
                        # The "latest" keyword can also be used instead of a named archive 
- BORG_SSH_PRIVATE_KEY  # optional; if backing up to a remote repo via ssh, this is the containers' private key. 
                        # The corresponding public key should be placed into the 'authorized_keys' file on the repo server

As with any LinuxServer container, any of the above can be set via secrets by prepending them with 'FILE__' 
e.g., FILE__BORG_REPO_KEY=/run/secrets/some-repo-key
