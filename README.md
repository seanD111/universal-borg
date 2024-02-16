# universal-borg
This mod adds support for automated backups to any LinuxServer container. It is based on the script at https://borgbackup.readthedocs.io/en/latest/quickstart.html, and installs SSH for remote repositories.

To enable this mod, set an environment variable:
DOCKER_MODS=seand111/universal-borg

By default the mod will install the latest version of borgbackup (https://borgbackup.readthedocs.io/en/latest/installation.html), and
will create a backup via cron every 5 minutes. This behavior can be changed by mounting your own cron table in the /config/crontab/abc directory.

The following environment variables define how the mod works:

- BORG_REPO defines where borg will backup to
