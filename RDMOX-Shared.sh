#/bin/bash
set -euo pipefail

SCRIPTPATH=$(realpath $0)
DIRECTORY=$(dirname $SCRIPTPATH)

REPOSITORY=`mktemp -d`
cd $REPOSITORY
echo $REPOSITORY

svn checkout --username bcortier svn://svn2.devolutions.net/RDM/trunk/devolutions/RemoteDesktopManager/Shared

[ -d "${DIRECTORY}/RDMOX/Shared" ] && mv "${DIRECTORY}/RDMOX/Shared" "${DIRECTORY}/RDMOX/Shared.$(date +%Y%m%d%H%M%S)"
mv Shared "${DIRECTORY}/RDMOX/"
