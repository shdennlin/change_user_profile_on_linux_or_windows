# Windows Change User Profile

## Feature

1. Change user from A to B
   - Change username from A to B
   - Change the user home folder from A to B
2. Change the current computer name

## Requirement

1. Need to use Administrator account to run
   use `net user administrator /active:yes` to enable Administrator account
2. change ExecutionPolicy use `Set-ExecutionPolicy unrestricted` to enable, and use `Get-ExecutionPolicy` to check

## Usage

```powershell
Set-ExecutionPolicy unrestricted
curl -O https://raw.githubusercontent.com/shdennlin/change_user_profile_on_linux_or_windows/main/windows/main.ps1
.\main.ps1 -ou oldUserName -nu newUserName -cn newComputerName
```

## Parameter

- ou: Old username
- nu: New username
- cn: Computer name
