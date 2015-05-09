# Display

Description
===========
Display is a somewhat nasty program that leverages rootpipe and keychaindump to decrypt the user's keychain and upload credentials to a server. It displays a funny "uploading passwords" dialog and then a splash screen while playing music in the background. It disables all user interaction (no root necessary) and the computer must be force restarted.

Usage
======
All releases are shipped with the actual exploit disabled to avoid accidents. To enable the password stealing option, simply run the `togglestealpasswords.sh` script included in the project and edit `display/server.txt` to the URL of the PHP script listening on your server. After these changes have been made, type `Make`.

Disclaimer
==========
This program is to be used only with written permission of the owner of the device on which it is run. The authors of this program take absolutely no responsibility for misuse of this program.
