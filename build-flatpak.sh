#!/usr/bin/env bash

# This script sets up a flatpak build. and install of GIMP from a manifest file

# An identifier, different build storage folders can be created per app version
export VERSION="Source"


# create a log file
exec > >(tee -a "$HOME/build-flatpak-script.log") 2>&1

# get the absolute path to the directory for the Flatpak Repo
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# change to the script directory, so that files are downloaded to here
echo "Changing to script directory: ${SCRIPT_DIR}"
cd "${SCRIPT_DIR}"

# build options for the flatpak builder
export BUILD_OPTIONS="--ccache --keep-build-dirs --force-clean"

# architectures supported with GIMP flatpak are one of 'x86_64' or 'aarch64'
export ARCH="x86_64"

# install folder where flatpak files are stored after being built
export FLATPAKDIR="${SCRIPT_DIR}/flatpak-install/${ARCH}/${VERSION}"

# manifest file location, it controls the flatpak process
export MANIFEST="${SCRIPT_DIR}/org.gimp.GIMP.json"


echo -e "\n************* FLATPAK BUILD STARTED *****************\n"

# build a flatpak version of GIMP, using source code specified by the manifest
flatpak-builder $BUILD_OPTIONS --arch="$ARCH" "${FLATPAKDIR}" \
                "${MANIFEST}" 2>&1 \
               | tee "$HOME/GIMP-flatpak.log"

if [ $? -ne 0 ]; then
    echo "Error: Flatpak build failed. Check the log for details."
    exit 1
fi

echo -e "\n************* FLATPAK BUILD FINISHED *****************\n"

# Install a flatpak version of GIMP, from the pre-built flatpak
flatpak-builder --user --install --force-clean "${FLATPAKDIR}" "${MANIFEST}"

echo -e "\n************* INSTALL FINISHED *****************\n"

