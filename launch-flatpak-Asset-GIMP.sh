#!/usr/bin/env bash

# launch the flatpak version of GIMP, using a different workspace
workspace=$HOME/.config/GIMP/Master-Flatpak-Assets
mkdir -p $workspace

# launch a flatpak version of GIMP, with a specified workspace
flatpak --env=GIMP3_DIRECTORY="$workspace" run org.gimp.GIMP --verbose --console-messages -s


