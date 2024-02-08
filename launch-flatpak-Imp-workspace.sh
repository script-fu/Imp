#!/usr/bin/env bash

# launch the flatpak version of GIMP, called Imp, using a different workspace
workspace=$HOME/.config/GIMP/Imp-Workspace
mkdir -p $workspace

# launch a flatpak version of GIMP, called Imp, with a specified workspace
flatpak --env=GIMP3_DIRECTORY="$workspace" run org.gimp.Imp -s
