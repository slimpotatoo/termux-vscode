# termux-vscode
Scripts to setup a working vs code setup in android systems

# Prerequisites
install termux

# Setup
Go to user home dir and paste the content of dev.sh, to go to user home dir: 

ˋˋˋ
$cd ~
ˋˋˋ

This will create dev.sh file in user home dir, to verify:

ˋˋˋ
$ls
ˋˋˋ

Make it executable and add the alias to bash file: 

ˋˋˋ
$chmod +x dev.sh
$echo "alias code='~/dev.sh'" >> ~/.bashrc
ˋˋˋ

# Use
Just type the command code in the termux, it will first start the debian, then it will start the code server.
If the environment is not setup, it will download the required libraries and finish the setup.

ˋˋˋ
$code
ˋˋˋ







# DETAILS
Note: Above script installs the full fledged developer work station


Steps for a minimal developer station with limited capacity android device:

1. Install f-droid: repo for opensource tools for android

2. From f-droid download termux and install: terminal access


3. Create a linux virtual env using proot

# Update core package indexes
pkg update && pkg upgrade -y

# Install the Linux distribution manager
pkg install proot-distro -y

# Download and install a full Debian system instance
proot-distro install debian

# Login directly into your newly constructed Linux engine
proot-distro login debian


4. Inside linux env install engine server and run

# Install core system management updates and Node.js
apt update && apt upgrade -y
apt install curl NodeJS npm git build-essential -y

# Download and set up the localized code-server framework
curl -fsSL https://code-server.dev | sh

# Boot up the server locally on your device
code-server --auth none --port 8080


5. Access the engine server through browser
http://localhost:8080/








Steps for a full fledged developer station with high capacity android device:

1. First perform step 1 to 3 from above to boot linux env

2. Update and install core toolchain

# Update repositories and install foundational developer tools
apt update && apt upgrade -y
apt install curl git build-essential software-properties-common nano wget unzip -y

# Install Python 3 and its package manager
apt install python3 python3-pip python3-venv -y

# Install the latest stable Node.js runtime and NPM
curl -fsSL https://nodesource.com | bash -

apt install nodejs -y

3. Deploy the Visual Studio Code Server

# Download and install code-server automatically, if this does not work try other two commands
curl -fsSL https://code-server.dev | sh

# Download and save the script to a named local file curl -fsSL https://code-server.dev/install.sh -o setup-vscode.sh 

# Run the saved file manually 
sh setup-vscode.sh

# Enable and start the background process loop - this usually doesn't work in android and we can ignore this.
systemctl enable --now code-server@$USER || true

4. Boot Your Workspace

code-server --auth none --port 8080



