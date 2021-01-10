#!/bin/bash
error3() {
  clear
  echo "please install wget"
  exit
}
error2() {
  clear
  echo "please install nyx"
  exit
}
error1() {
  clear
  echo "please install tor and edit your /etc/tor/torrc file to enable ControlPort 9051"
  exit
}
start_tor() {
  sudo systemctl start tor.service
}
check() {
  ls /usr/bin | grep -w "wget" || error3
  ls /usr/bin | grep -w "tor" || error1
  ls /usr/bin | grep -w "nyx" || error2
  ls | grep firefox || download
  clear
}
download() {
  wget https://github.com/srevinsaju/Firefox-Appimage/releases/download/firefox-v84.0.r20201221152838/firefox-84.0.r20201221152838-x86_64.AppImage
  one_time=$(ls | grep firefox)
  chmod +x $one_time
}
check
one_time=$(ls | grep firefox)
start_tor
konsole --separate -e nyx & ./$one_time
sudo systemctl stop tor.service
