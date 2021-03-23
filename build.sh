#!/bin/bash
set -euo pipefail

if ! command -v mono &> /dev/null; then
	echo "mono is missing"
	exit
fi

if ! command -v nuget &> /dev/null; then
	echo "nuget is missing"
	exit
fi

if ! command -v msbuild &> /dev/null; then
	echo "msbuild is missing"
	exit
fi

SCRIPTPATH=$(realpath $0)
DIRECTORY=$(dirname $SCRIPTPATH)
RDM_TOP_DIR="${DIRECTORY}/RDMOX/Linux/RemoteDesktopManager/"
RDM_CLIENT_DIR="${RDM_TOP_DIR}/Clients/RemoteDesktopManager/"
LIB_DIR="${RDM_TOP_DIR}/Lib/"

[ ! -d "${DIRECTORY}/RDMOX/Shared" ] && "${DIRECTORY}/RDMOX-Shared.sh"

cd "${RDM_TOP_DIR}"
nuget restore RemoteDesktopManager.sln

cd "${RDM_CLIENT_DIR}"
msbuild /p:Configuration="Release" /p:Platform="AnyCPU" RemoteDesktopManager.csproj

cp "${LIB_DIR}/Core.XmlSerializers.dll" "${RDM_CLIENT_DIR}/bin/Release"
cp "${LIB_DIR}/RemoteDesktopManager.Core.XmlSerializers.dll" "${RDM_CLIENT_DIR}/bin/Release"

cd "${RDM_CLIENT_DIR}/bin/Release"
mkbundle -o RemoteDesktopManager --simple --keeptemp RemoteDesktopManager.exe --i18n all --config ./config --machine-config /etc/mono/4.5/machine.config

