# https://docs.fedoraproject.org/f28/install-guide/appendixes/Kickstart_Syntax_Reference.html

# Configure installation method
install
url --mirrorlist="https://mirrors.fedoraproject.org/mirrorlist?repo=fedora-28&arch=x86_64"
repo --name=fedora-updates --mirrorlist="https://mirrors.fedoraproject.org/mirrorlist?repo=updates-released-f28&arch=x86_64" --cost=0

# zerombr
zerombr

# Configure Boot Loader
bootloader --location=mbr --driveorder=sda

# Remove all existing partitions
clearpart --all --drives=sda

# Create Physical Partitions
autopart

# Configure Network Interfaces
network --onboot=yes --bootproto=dhcp

# Configure Keyboard Layouts
keyboard us

# Configure Language During Installation
lang cs_CZ

# Configure Time Zone
timezone Europe/Prague --isUtc

# Set up two keyboard layouts (English (US) and Czech (qwerty)).
# Switch between them using Alt+Shift:
keyboard --xlayouts=us,'cz (qwerty)' --switch=grp:alt_shift_toggle

# Configure Authentication
auth --passalgo=sha512 --useshadow

# Create User Account
user --name=clicourse --password=clicourse --plaintext --groups=wheel

# Set Root Password
rootpw --plaintext redhat

# Package Selection
%packages
@^Fedora Workstation
mc
vim-enhanced
nano
%end


# Post-installation Script
%post

# Turn off audible bell
runuser clicourse -s /bin/bash -c "gsettings set org.gnome.desktop.wm.preferences audible-bell false"

%end

# Reboot After Installation
reboot --eject
