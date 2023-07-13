#!/bin/bash

export NC='\033[0m' # No Color
export GREEN='\033[0;32m'
export YELLO='\033[0;33m'
export BLUE='\033[0;34m'
export MAGENTA='\033[0;35m'
export RED='\033[0;31m'

export INFO="${GREEN}INFO: ${NC}"
export WARNING="${YELLO}WARNING: ${NC}"
export ERROR="${RED}ERROR: ${NC}"

help() {
  echo "Usage: $0 [options...]"
  echo "Options:"
  echo "  -ou, --old-username    Old username"
  echo "  -nu, --new-username    New username"
  echo "  -hn, --hostname        Hostname"
  echo "  -h,  --help            Display help"
  echo ""
  echo "Example:"
  echo "  $0 -ou old_username -nu new_username -hn hostname"
  echo ""
}

check_param() {
  if [ -z "$1" ]; then
    echo -e "${ERROR}Missing parameter: $2"
    exit 1
  fi
}

# Parse arguments
while [[ "$#" -gt 0 ]]; do
  case $1 in
  -ou | --old-username)
    check_param "$2" "old-username"
    old_username="$2"
    shift
    ;;
  -nu | --new-username)
    check_param "$2" "new-username"
    new_username="$2"
    shift
    ;;
  -hn | --hostname)
    check_param "$2" "hostname"
    hostname="$2"
    shift
    ;;
  -h | --help)
    help
    exit 0
    ;;
  *)
    echo "Unknown parameter passed: $1"
    exit 1
    ;;
  esac
  shift
done

# check old-username and new-username are exist
if [ ! -z "$old_username" ] && [ ! -z "$new_username" ]; then
  echo -e "${INFO}old username is $old_username, new username is $new_username"
  mv /home/$old_username /home/$new_username
  usermod -l $new_username $old_username
  usermod -d /home/$new_username $new_username
  groupmod -n $new_username $old_username
else
  echo -e "${ERROR}Missing parameter: old-username or new-username"
  exit 1
fi

if [ ! -z $hostname ]; then
  old_hostname=$(cat /etc/hostname)
  echo -e "${INFO}old hostname is $old_hostname, new hostname is $hostname"
  echo $hostname >/etc/hostname
fi
