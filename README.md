# Setting up a new Mac

The setup for my computers, for use with
[suited](https://github.com/norm/suited).

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

## Run `suited`

```bash
curl -O https://raw.githubusercontent.com/norm/suited/master/suited.sh 
bash suited.sh github:SteveMarshall/suit:initial_setup.conf
suited github:SteveMarshall/suit:main.conf
```
