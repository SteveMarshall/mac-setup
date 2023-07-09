# Setting up a new Mac

The setup for my computer.

## Account setup

During the installation of macOS:

* don't sign into iCloud during the finalisation
* create alternate `StevenAdm` account

Once logged in, open System Preferences and:

* create the `Steven` account
* turn off fast user switching

Log out, then back in as `Steven`, signing into iCloud during the
finalisation.

## Set up GitHub SSH keys

1. Create an SSH key for the new device:

    ```bash
    ssh-keygen -trsa -b4096 -C "$USER@$HOST" -f ~/.ssh/id_rsa
    ssh-add ~/.ssh/id_rsa
    ```
2. Copy the SSH key to the clipboard:

    ```bash
    pbcopy < ~/.ssh/id_rsa.pub
    ```
3. [Add the new SSH key on GitHub](https://github.com/settings/keys)

## Run `setup.sh`

Make sure you've `export`ed values for `BACKBLAZE_USER` and
`BACKBLAZE_PASSWORD`, and a `MACHINE_TYPE` of either `dev` or `server`,
as appropriate, and then run:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/SteveMarshall/mac-setup/main/setup.sh)"
```

## Post-`setup` manual steps

- Set [Backblaze's Private Encryption Key](https://help.backblaze.com/hc/en-us/articles/217666268-Security-Settings-Mac-)
