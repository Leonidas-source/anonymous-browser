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
  ls /usr/bin | (grep -w "sudo") && (clear && sudo systemctl start tor.service) || ls /usr/bin | (grep -w "doas") && (clear && doas systemctl start tor.service)
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
  wget https://gitlab.com/librewolf-community/browser/linux/uploads/b87285386bed26dc6d6d4cf252ca7adf/LibreWolf-85.0.2-1.x86_64.AppImage
  one_time=$(ls | grep LibreWolf)
  chmod +x $one_time
}
saved_profile() {
  clear
  echo "Should i save your browser profile in this folder?
  1) yes
  2) no"
  read answr
  [ "$answr" == "1" ] && move_profile
}
move_profile() {
  clear
  source_folder=$(pwd)
  cd ~/.librewolf/
  profile_name=$(ls | grep default)
  mv $profile_name $source_folder
  cd ..
  rm -r .librewolf
  cd $source_folder
}
profile_detection() {
  clear
  profile_name=$(ls | grep default) && (gnome-terminal -- nyx & ./$one_time --profile $profile_name) || (gnome-terminal -- nyx & ./$one_time)
}
check
one_time=$(ls | grep LibreWolf)
start_tor
ls | grep -w "first_time" && (gnome-terminal -- nyx & ./$one_time https://wiki.archlinux.org/index.php/Tor'#Web_browsing' && saved_profile) || profile_detection
ls /usr/bin | (grep -w "sudo") && (sudo systemctl stop tor.service) || (ls /usr/bin | grep -w "doas" ) && (clear && doas systemctl stop tor.service)
ls | grep -w "first_time" && rm first_time
clear
