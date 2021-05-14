################################################################################
# Get Disabled Users                                                           #
# Author: Cory Burditt                                                         #
# Date: August 14, 2018                                                        #
# Description: This script Generates a list of all users who have been         #
#              disabled.                                                       #
################################################################################

#Request number of days for inactivity threshhold.
Write-Host "This script will generate a list of users who disabled on the domain."

#Request filename for output file.
$CurrentUser = $env:UserName
Write-Host "Enter output filename (file will be saved to your desktop), or 'exit' to close."
$FileName = Read-host

#If the file type is not csv or txt, add ".txt" to the filename.
if ((($FileName.substring($FileName.length-4, 4)) -ne ".txt") -and (($FileName.substring($FileName.length-4, 4)) -ne ".csv")) {
    $FileName = $FileName + ".csv"
}

#Check for exit request.
if (($FileName -eq "exit") -or ($FileName -eq "Exit") -or ($FileName -eq "EXIT")) {
    exit
}

#Create full file path from user input.
$Path = "C:\Users\" + $CurrentUser + "\Desktop\" + $FileName

#Add exchange and AD functionality.
Import-Module ActiveDirectory

#Get list of inactive users and export to csv
$InactiveUsers = Get-ADUser -Filter {Enabled -eq $false} -Properties * | Sort-Object
foreach ($InactiveUser in $InactiveUsers) {
          Write-Host "Making the file now"
        Add-Content -Path $Path -Value ($InactiveUser.Name + "," + $InactiveUser.EmailAddress + "," + $InactiveUser.LastLogonDate)
  }

#Completion notice and exit prompt.
Write-Host ("`nFile created at location: " + $Path)
write-host "Press any key to close..."
[void][System.Console]::ReadKey($true)