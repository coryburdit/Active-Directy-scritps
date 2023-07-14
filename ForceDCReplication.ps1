<#
 Get Force Domain Controler Replication                                       
 Author: Cory Burditt                                                         
 Date: July 14, 2023														  
 Description: This script forces a Domain Controler Replication to occur	  
 Version 1.0
#>

#Are you admin No then RuN AS ADMIN 
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
{
  # Relaunch as an elevated process:
  Start-Process powershell.exe "-File",('"{0}"' -f $MyInvocation.MyCommand.Path) -Verb RunAs
  exit
}

repadmin /syncall /AeD

#Completion notice and exit prompt.
Write-Host ("Completed" )
write-host "Press any key to close..."
[void][System.Console]::ReadKey($true)