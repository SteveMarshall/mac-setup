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

## Running `suited`

```bash
curl -O https://raw.githubusercontent.com/norm/suited/master/suited.sh 
bash suited.sh github:SteveMarshall/suit:initial_setup.conf
```
