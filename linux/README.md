# Linux Change User Profile

## Feature

1. Change user from A to B
   - Change username from A to B
   - Change the user home directory from A to B
2. Change the current hostname

## Requirement

1. Need to login with root account to run

## Usage

```bash
# download script (main.sh)
curl -O https://raw.githubusercontent.com/shdennlin/change_user_profile_on_linux_or_windows/main/linux/main.sh
chmod +x main.sh
./main.sh -ou old_username -nu new_username -hn new_computer_name
```

## Parameter

- ou: Old username
- nu: New username
- hn: Computer name
