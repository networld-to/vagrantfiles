#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

######################################
# Some color definitions
######################################
__RAINBOWPALETTE="1"
function __colortext() {
  echo -e " \e[$__RAINBOWPALETTE;$2m$1\e[0m"
}
function echogreen() {
  echo $(__colortext "$1" "32")
}
function echored() {
  echo $(__colortext "$1" "31")
}
function echoblue() {
  echo $(__colortext "$1" "34")
}
function echopurple() {
  echo $(__colortext "$1" "35")
}
function echoyellow() {
  echo $(__colortext "$1" "33")
}
function echocyan() {
  echo $(__colortext "$1" "36")
}

if ! [ -f ${DIR}/.env ]; then
  echocyan "[ENV] Copying .env file"
  cp ${DIR}/.env-example ${DIR}/.env
  echoyellow "TODO: Please change the environment variables in '${DIR}/.env' and start this script again"
else
  echogreen "[ENV] Previous .env file found. Not overriding it!"
  . ${DIR}/.env
fi

if ! [ -f ${DIR}/private/id_rsa ]; then
  echocyan "[SSH] Generating new keypair under '${DIR}/private/id_rsa'"
  mkdir ${DIR}/private && ssh-keygen -C "foobar@example.org" -N '' -f ${DIR}/private/id_rsa
else
  echogreen "[SSH] Old ssh key pair found. Not overriding it!"
fi
vagrant up
