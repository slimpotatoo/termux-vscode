# termux-vscode
Scripts to setup a working vs code setup in android systems

# Prerequisites
install termux

# Setup
Paste the file dev.sh in the user home location: 

ˋˋˋ
$cd ~
ˋˋˋ

Make it executable and add the alias to bash file: 

ˋˋˋ
$chmod +x dev.sh && echo "alias code='~/dev.sh'" >> ~/.bashrc
ˋˋˋ

# Use
Just type the command code in the termux, it will first start the debian, then it will start the code server.
If the environment is not setup, it will download the required libraries and finish the setup.

ˋˋˋ
$code
ˋˋˋ
