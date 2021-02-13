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
  ls /usr/bin | grep -w "sudo" && sudo systemctl start tor.service || ls /usr/bin | grep -w "doas" && doas systemctl start tor.service
}
check() {
  ls /usr/bin | grep -w "wget" || error3
  ls /usr/bin | grep -w "tor" || error1
  ls /usr/bin | grep -w "nyx" || error2
  ls | grep LibreWolf || download
  clear
}
download() {
  touch first_time
  clear
  wget https://gitlab.com/librewolf-community/browser/linux/uploads/cfdd906e663aef41c869573abbd0fb06/LibreWolf-85.0.1-1.x86_64.AppImage
  one_time=$(ls | grep LibreWolf)
  chmod +x $one_time
}
check
one_time=$(ls | grep LibreWolf)
start_tor
ls | grep -w "first_time" && (gnome-terminal -- nyx & ./$one_time https://wiki.archlinux.org/index.php/Tor'#Web_browsing') || (gnome-terminal -- nyx & ./$one_time)
ls /usr/bin | grep -w "sudo" && sudo systemctl stop tor.service || (ls /usr/bin | grep -w "doas" ) && doas systemctl stop tor.service
ls | grep -w "first_time" && rm first_time
clear
