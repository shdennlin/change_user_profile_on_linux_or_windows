<#
.SYNOPSIS
This script can change the username or computername.

.PARAMETER ou
The old username.

.PARAMETER nu
The new username.

.PARAMETER cn
The new computername.

.EXAMPLE
.\main.ps1 -ou "username" -nu "newusername" -cn "newcomputername"
#>

param(
    [Parameter(HelpMessage = "old username.")]
    [string] $ou,

    [Parameter(HelpMessage = "new username")]
    [string] $nu,

    [Parameter(HelpMessage = "new computername")]
    [string] $cn
)


if ($cn -ne "") {
    Write-Output "change computername to '$cn'"
    Rename-Computer -NewName $cn
}

if ($ou -ne "" -and $nu -ne "") {
    Write-Output "change user '$ou' to '$nu'"

    $sid = (Get-WmiObject -Class win32_userAccount -Filter "name='$ou' and domain='$env:computername'").SID
    if ($sid -eq $null) {
        Write-Output "user '$ou' not found"
        exit
    }
    $registryPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\$sid"
    $valueName = "ProfileImagePath"
    $newValue = "C:\Users\$nu"

    $value = Get-ItemProperty -Path $registryPath -Name $valueName | Select-Object -ExpandProperty $valueName
    Write-Output "$registryPath"
    Write-Output "Old value: $value"
    
    Set-ItemProperty -Path $registryPath -Name $valueName -Value $newValue

    $value = Get-ItemProperty -Path $registryPath -Name $valueName | Select-Object -ExpandProperty $valueName
    Write-Output "New value: $value"

    Rename-LocalUser -Name "$ou" -NewName "$nu"
    Rename-Item -Path C:\Users\$ou -NewName C:\Users\$nu
}