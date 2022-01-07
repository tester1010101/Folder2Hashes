##################################################
#             ~ Folder2Hashes v1.2 ~             #
# ._.       ~ Made by: tester1010101 ~       ._. #
#   Get all files in the folder and gets their   #
#   hashes then export-all to a file in user's   #
# home folder, can be used for large directories #
# or for anything that needs hash values stored. #
#            github.com/tester1010101/           #
##################################################

########################################################################
# Prompt user: enter folder path, trims path & save it in $MyPath >    #
########################################################################
Write-Host "Folder path?"
$MyPath = Read-Host

if ($MyPath[0] -eq "`'")
{
    $MyPath = ($MyPath).TrimStart("`'").TrimEnd("`'")
} else { $MyPath = ($MyPath).TrimStart("`"").TrimEnd("`"") }

########################################################################
# Test-Path to the Hash3s folder, if not present, creates it >         #
########################################################################
$TestPath = Test-Path $env:USERPROFILE\0xFF\Hash3s
if ($TestPath -eq $False) {mkdir $env:USERPROFILE\0xFF\Hash3s}

########################################################################
# Creates metadata for the hashes being stored (date formatting) >     #
########################################################################
$ASCIIDate = Get-Date -Format MM_dd_yyyy-HH_mm_ss
$Header = "Folder2Hashes Session # $ASCIIDate `n"
$Path1 = "$env:USERPROFILE\0xFF\Hash3s\Hashes-$ASCIIDate-_Files.txt"
$Path2 = "$env:USERPROFILE\0xFF\Hash3s\Hashes-$ASCIIDate-_Integrity.txt"

########################################################################
# TestSession in the Hash3s folder, if False, creates one >            #
########################################################################
$TestSession = Test-Path $Path1
if ($TestSession -eq $True)
{
    Write-Host "File already exist, verify folder? [Y/N]"
    $Verify = Read-Host
    if ($Verify -match "Y")
    {
        Write-Host "Filename: Hashes-$ASCIIDate.txt" -ForegroundColor Red -BackgroundColor Yellow
        explorer $env:USERPROFILE\0xFF\Hash3s\
        Write-Host "Exiting... Restart script after file deletion/backup." -ForegroundColor Red -BackgroundColor Yellow
        pause
        exit
    } 
    elseif ($Verify -match "N")
    { 
        Write-Host "Exiting... Restart script after file deletion/backup." -ForegroundColor Red -BackgroundColor Yellow
        Write-Host "Path: $env:USERPROFILE\0xFF\Hash3s\" -ForegroundColor Red -BackgroundColor Yellow
        pause
        exit 
    } 
    else 
    { 
        Write-Host "Wrong Selection, restart the script please."
        pause
        exit
    }
}

########################################################################
# Copy Hashes to the Hash3s folder, reformats them to fit width >      #
########################################################################
$Header | Out-File -Width 512 $Path1
ls "$MyPath" | Get-FileHash | Format-Table -AutoSize | Out-File -Width 512 $Path1 -Append
Get-FileHash $Path1 | Out-File -Width 512 $Path2

########################################################################
# Completion ~ User-Friendly Prompts >                                 #
########################################################################
Write-Host "Hashes successfully extracted and pasted them in: $Path1" -ForegroundColor Red
Write-Host "RECOMMENDED: store files in a safe/print them to ensure integrity." -ForegroundColor Red -BackgroundColor Yellow
Write-Host "Open destination folder?`nHashes File: $Path1`nIntegrity File: $Path2" -ForegroundColor Green
Write-Host "--------------------------------------------------------> [Y/N]" -ForegroundColor Green
$Answer = (Read-Host)
if ($Answer -eq "Y")
{
    explorer $ENV:USERPROFILE\0xFF\Hash3s\
}
Write-Host "Press Enter to exit..." -ForegroundColor Red
Read-Host

########################################################################
# Final ~ Reset variables to 0 or default values >                     #
########################################################################
$MyPath = $null
$TestPath = $null
$TestSession = $null
$ASCIIDate = $null
$Verify = $null
$Header = $null
$Path1 = $null
$Path2 = $null
$Hashes = $null
$Answer = $null