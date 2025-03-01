# Linux Change User Profile

A utility script to help you change a user's profile information on Linux systems, including username, home directory path, and computer hostname.

## Features

1. Change user from A to B
   - Change username from A to B
   - Change the user home directory from A to B
   - Update the home directory path in user account
   - Change the primary group name from A to B
2. Change the current hostname

## Requirements

1. **Root privileges**: The script must be run with root/sudo permissions as it modifies system user accounts and hostname.
2. **User logout required**: The target user account (whose username you want to change) must be completely logged out of all sessions. No processes should be running under that username.
3. **Root account recommended**: For changing usernames, it's strongly recommended to execute this script while logged in as the root user (not just using sudo) to avoid permission issues.
4. **Backup recommended**: Always backup important data before making system-level changes to user accounts.
5. **System compatibility**: Works on most major Linux distributions (Debian/Ubuntu, RHEL/CentOS, Arch, etc.) that use standard user management commands.

## Usage

1. Download the script:

    ```bash
    curl -O https://raw.githubusercontent.com/shdennlin/change_user_profile_on_linux_or_windows/main/linux/main.sh
    chmod +x main.sh
    ```

2. Run the script with the required parameters:

    ```bash
    sudo ./main.sh -ou old_username -nu new_username -hn new_computer_name
    ```

### Examples

Change only the username:
```bash
sudo ./main.sh -ou john -nu jonathan
```

Change only the hostname:
```bash
sudo ./main.sh -hn new-workstation
```

Change both username and hostname:
```bash
sudo ./main.sh -ou john -nu jonathan -hn new-workstation
```

## Parameters

- `-ou, --old-username`: Old username
- `-nu, --new-username`: New username
- `-hn, --hostname`: New computer name (hostname)
- `-h, --help`:  Display help message

## What happens behind the scenes

The script performs the following operations:
- Renames the home directory (`mv /home/old_username /home/new_username`)
- Changes the username (`usermod -l`)
- Updates the home directory path in user account (`usermod -d`)
- Changes the primary group name (`groupmod -n`)
- Updates the hostname in `/etc/hostname` if provided

[MIT License](../LICENSE)
