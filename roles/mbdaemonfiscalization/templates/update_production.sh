#!/bin/bash

UPDATE_SERVER="{{ billing.update_server }}"
if [[ -n $1 ]]; then
  TESTING=1
  case "$1" in
    "-t") UPDATE_SERVER="{{ billing.testing_server }}" ;;
    "--testing") UPDATE_SERVER="{{ billing.testing_server }}" ;;
    *) exit 0 ;;
  esac
else
  TESTING=0
fi

LICENSE_DIR="{{ billing.dirs.home }}/license"
URL="http://free.${UPDATE_SERVER}"
if [ "$(ls -A "${LICENSE_DIR}")" ]; then
  URL="http://pay.${UPDATE_SERVER}"
fi

FILE_NAME="mbdaemonfiscalization"
MODULE="{{ mbdaemonfiscalization.dirs.module }}"
BILL_HOME="{{ billing.dirs.home }}"
VERSION="{{ mbdaemonfiscalization.dirs.production }}"
WORK_DIR="${BILL_HOME}/${MODULE}/${VERSION}"
UPD_DIR="${BILL_HOME}/${MODULE}/${VERSION}/{{ mbdaemonfiscalization.dirs.updates }}"
BKP_DIR="${BILL_HOME}/${MODULE}/${VERSION}/{{ billing.dirs.backups }}"
TMP_DIR="{{ billing.dirs.tmp }}"

UPDATER_REVISION=1
UPDATER_NAME="{{ mbdaemonfiscalization.files.updates }}"

DATENAME=$(date +%F_%H-%M)
INFO="[${DATENAME} ${VERSION}]"
LOG_DIR="${BILL_HOME}/{{ billing.dirs.logs }}/${MODULE}"
FILE_LOG="${LOG_DIR}/{{ mbdaemonfiscalization.files.log_update }}"

function upd_log() {
  echo "${INFO} $1" >>"${FILE_LOG}"
}

if [ ! -d "${TMP_DIR}" ]; then
  upd_log "create tmp ${TMP_DIR}"
  mkdir "${TMP_DIR}"
fi

if [ ! -d "${WORK_DIR}" ]; then
  upd_log "${WORK_DIR} dir not found"
  exit 0
fi

if [ $TESTING -eq 1 ]; then
    upd_log "use testing update server"
fi

cd "${UPD_DIR}" || exit
upd_log "check version UPDATER SOFT"
SITE_REVISION=$(wget -qO- "${URL}/${UPDATER_NAME}.revision")
if [ -n "${SITE_REVISION}" ]; then
  if [ "${SITE_REVISION}" != "${UPDATER_REVISION}" ]; then
    upd_log "found new version for UPDATER SOFT"
    wget -q -O "${UPD_DIR}/${UPDATER_NAME}.new" "${URL}/${UPDATER_NAME}"
    if [ $? -ne 0 ]; then
      upd_log "download FAILED! please check DNS and connection to ${URL}/${UPDATER_NAME}"
      if [ -f "${UPD_DIR}/${UPDATER_NAME}.new" ]; then
        rm -f "${UPD_DIR}/${UPDATER_NAME}.new"
      fi
      exit 0
    fi

    upd_log "run NEW VERSION UPDATER SOFT"
    if [ -f "${UPD_DIR}/${UPDATER_NAME}" ]; then
      rm -f "${UPD_DIR}/${UPDATER_NAME}"
    fi

    mv "${UPD_DIR}/${UPDATER_NAME}.new" "${UPD_DIR}/${UPDATER_NAME}"
    chmod +x "${UPD_DIR}/${UPDATER_NAME}"
    bash "${UPD_DIR}/${UPDATER_NAME}"
    exit 0
  else
    upd_log "installed latest version UPDATER SOFT"
  fi
fi

wget -O "${FILE_NAME}.downloaded.checksum" -q "${URL}/${FILE_NAME}.checksum"
if [ $? -ne 0 ]; then
  upd_log "download FAILED! please check DNS and connection to ${URL}/${FILE_NAME}.checksum"
  if [ -f "${FILE_NAME}.downloaded.checksum" ]; then
    rm -f "${FILE_NAME}.downloaded.checksum"
  fi
  exit 0
fi

if [ ! -f "${FILE_NAME}.current.checksum" ]; then
  echo 0 >"${FILE_NAME}.current.checksum"
fi

MD5_CURRENT=$(cat "${FILE_NAME}.current.checksum")
MD5_DOWNLOADED=$(cat "${FILE_NAME}.downloaded.checksum")
if [ "${MD5_CURRENT}" != "${MD5_DOWNLOADED}" ]; then
  upd_log "download ${FILE_NAME} update..."
  cd "${TMP_DIR}" || exit

  wget -O "${FILE_NAME}.tar.gz" -q "${URL}/${FILE_NAME}.tar.gz"
  if [ $? -ne 0 ]; then
    upd_log "download FAILED! please check DNS and connection to ${URL}/${FILE_NAME}"
    if [ -f "${FILE_NAME}.tar.gz" ]; then
      rm -f "${FILE_NAME}.tar.gz"
    fi
    exit 0
  fi

  if [ $TESTING -eq 0 ]; then
    echo "${MD5_DOWNLOADED}" > "${UPD_DIR}/${FILE_NAME}.current.checksum"
  fi

  mv "${FILE_NAME}.tar.gz" "${WORK_DIR}/"
  cd "${WORK_DIR}" || exit

  if [ -f "./mbdaemonfiscalization.php" ]; then
    if [ ! -d "${BKP_DIR}" ]; then
      mkdir -p "${BKP_DIR}"
    fi

    upd_log "backup current version to ${BKP_DIR}/${FILE_NAME}_${VERSION}.${DATENAME}.tar.gz"
    tar -zcf "${BKP_DIR}/${FILE_NAME}_${VERSION}.${DATENAME}.tar.gz" "mbdaemonfiscalization.php"
  fi

  if [ -f "${FILE_NAME}.tar.gz" ]; then
    upd_log "install new ${FILE_NAME} update"
    tar -zxf "${FILE_NAME}.tar.gz"
    rm -f "${FILE_NAME}.tar.gz"
  fi
else
  upd_log "installed latest ${FILE_NAME}"
fi

exit 0