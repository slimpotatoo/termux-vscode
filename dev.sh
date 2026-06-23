cat << 'EOF' > dev.sh
#!/data/data/com.termux/files/usr/bin/bash

clear
echo "================================================================"
echo "⚡ SMART DEVELOPER WORKSPACE LAUNCHER"
echo "================================================================"

# Step 1: Check if Debian is even installed
if proot-distro list | grep -q "debian.*installed"; then
    
    # Create a temporary test runner to see if code-server is installed inside Debian
    cat << 'TEST_EOF' > $PREFIX/var/lib/proot-distro/installed-rootfs/debian/root/check_vs.sh
#!/bin/bash
if command -v code-server >/dev/null 2>&1; then
    exit 0 # Success
else
    exit 1 # Missing
fi
TEST_EOF

    # Execute the test inside the sandbox
    proot-distro login debian -- sh /root/check_vs.sh
    VS_CODE_STATUS=$?
    
    # Clean up the test file
    proot-distro login debian -- rm /root/check_vs.sh

    # If VS Code exists, start the system immediately and stop the script
    if [ $VS_CODE_STATUS -eq 0 ]; then
        echo "🚀 Workspace detected! Starting Visual Studio Code Server..."
        echo "🌐 Open your tablet browser and go to: http://localhost:8080"
        echo "🛑 To stop the server, press Ctrl + C in this terminal."
        echo "================================================================"
        
        # Log into Debian and boot the workspace directly
        proot-distro login debian -- code-server --auth none --port 8080
        exit 0
    fi
fi

# Step 2: Fallback Setup Wizard (Runs ONLY if the system isn't fully installed)
echo "🔍 Workspace components missing. Initialising Setup Wizard..."
echo "📦 This will take a few minutes on your 12GB RAM system..."
echo "================================================================"

# Core Termux updates
pkg update -y && pkg upgrade -y
pkg install proot-distro wget -y
termux-setup-storage

# Install Debian image if missing
if ! proot-distro list | grep -q "debian.*installed"; then
    proot-distro install debian
fi

# Inject full installation sequence into the sandbox
cat << 'INSTALL_EOF' > $PREFIX/var/lib/proot-distro/installed-rootfs/debian/root/full_install.sh
#!/bin/bash
apt update && apt upgrade -y
apt install curl git build-essential software-properties-common nano wget unzip python3 python3-pip python3-venv -y

# Setup Node.js
curl -fsSL https://nodesource.com | bash -
apt-get install -y nodejs

# Setup VS Code Server via NPM
npm install -g code-server --unsafe-perm
apt clean && apt autoremove -y
INSTALL_EOF

# Run installer inside sandbox
proot-distro login debian -- sh /root/full_install.sh
proot-distro login debian -- rm /root/full_install.sh

clear
echo "================================================================"
echo "🎉 SETUP COMPLETE! Launching your brand new workstation now..."
echo "🌐 Browser URL: http://localhost:8080"
echo "================================================================"

# Boot immediately after installation finishes
proot-distro login debian -- code-server --auth none --port 8080
EOF

# Make it executable
# chmod +x dev.sh

# Add alias to bashrc for easy access
# echo "alias code='~/dev.sh'" >> ~/.bashrc
