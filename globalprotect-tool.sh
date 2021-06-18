#!/bin/bash

# Variables for the openconnect command
VPNURL='https://sssnssvpn.bor.usg.edu'
VPNC_SCRIPT='/usr/share/vpnc-scripts/vpnc-script'
CA_FILE="$HOME/.cert/sssnssvpn.bor.usg.edu.crt"
OPENCONNECT_PID=$(ps -A | grep 'openconnect' | grep -v grep | awk '{print $1}')

# Make sure the user is running the script as root.
if [ $(id -u) -ne 0 ]; then
  echo 'Please run this script with superuser privileges.'
  exit 1
fi

# Display usage info if no cli arguments are passed
if [ "$#" -eq 0 ]; then
  echo 'Usage: anyconnect-tool.sh [--connect] [--disconnect] [--refresh-connection] [--cleanup]'
  echo 'Required packages: openconnect vpnc (unless vpnc-script included at compile time)'
  echo 'Note: If running this in a chroot you need to remove resolvconf'
  exit 0
fi

# Connects to the vpn
connect () {
  # For OS X
  if [ $(uname) == 'Darwin' ]; then
    echo | openconnect -b --disable-ipv6 --no-dtls --protocol=gp --cafile=$CA_FILE $VPNURL
  fi
  # For GNU/Linux
  if [ $(uname) == 'Linux' ]; then
    # Create a tun interface
    ip tuntap add dev tun0 mode tun
    # Bring up the tun interface
    ip link set dev tun0 up
    # It can take moment to bring up the tun interface.
    sleep 3
    # Connect using openconnect
    echo | openconnect -b --disable-ipv6 --no-dtls --protocol=gp --interface=tun0 --cafile=$CA_FILE $VPNURL
  fi
  echo 'CONNECTED!'
}

# Disconnects from the vpn and cleans up.
disconnect () {
  # Send openconnect the graceful disconnect signal
  kill -s SIGINT $OPENCONNECT_PID
  if [ "$?" -ne 0 ]; then
    echo "Openconnect doesn't appear to be running. If you want to clean up old TUN interface run this script with the '--cleanup' option (Linux only)."
    exit 1
  fi
  # Wait a bit for openconnect to disconnect gracefully
  sleep 3
  echo

  # For Linux - Remove tun0 interface
  if [ $(uname) == 'Linux' ]; then
    # Bring down the tun interface
    ip link set dev tun0 down
    # Remove the tun interface
    ip tuntap del dev tun0 mode tun
  fi
  echo 'DISCONNECTED!'
}

refresh_connection () {
  # Send openconnect a signal to disconnect and immediately reconnect
  kill -s SIGUSR2 $OPENCONNECT_PID
  if [ "$?" -ne 0 ]; then
    echo "Openconnect doesn't appear to be running. If you want to clean up old TUN interface run this script with the '--cleanup' option (Linux only)."
    exit 1
  fi
  sleep 3
  echo 'CONNECTION REFRESHED!'
}

cleanup () {
  if [ $(uname) == 'Darwin' ]; then
    echo "This doesn't do anything on OS X."
  fi
  if [ $(uname) == 'Linux' ]; then
    # Bring down the tun interface
    ip link set dev tun0 down
    if [ "$?" -ne 0 ]; then
      echo "The interface tun0 doesn't exist. It was likely already removed."
      exit 1
    fi
   
    # Remove the tun interface
    ip tuntap del dev tun0 mode tun
    echo 'The TUN interface has been downed and removed.'   
  fi
}

# Call the connect function
if [ "$1" = "--connect" ]; then
  connect
  exit 0
# Call the disconnect function
elif [ "$1" = "--disconnect" ]; then
  disconnect
  exit 0
# Call the refresh connection function
elif [ "$1" = "--refresh-connection" ]; then
  refresh_connection
  exit 0
# Call the cleanup function
elif [ "$1" = "--cleanup" ]; then
  cleanup
  exit 0
# If anything else is passed print the usage message.
else
  echo 'Usage: anyconnect-tool.sh [--connect] [--disconnect] [--refresh-connection] [--cleanup]'
  exit 0
fi
