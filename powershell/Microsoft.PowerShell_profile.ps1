##### CONFIGURE/LIST MODULES #####
# PSReadLine
Set-PSReadlineOption -EditMode Emacs
Set-PSReadlineOption -BellStyle Visual

# posh-git
# No config yet

# Get-ChildItem-Color
. "~\Documents\WindowsPowerShell\Get-ChildItem-Color\Get-ChildItem-Color.ps1"
Set-Alias l Get-ChildItem-Color -Option AllScope
Set-Alias ls Get-ChildItem-Format-Wide -Option AllScope

##################################

# Start in the home directory
Set-Location ~

# Customize prompt
function prompt {
    $origLastExitCode = $LASTEXITCODE

    # Display the username and computername
    Write-Host "$env:UserName@$env:ComputerName" -ForegroundColor DarkGreen -NoNewline
    Write-Host ":" -ForegroundColor White -NoNewline

    # Display the path
    $currPath = $ExecutionContext.SessionState.Path.CurrentLocation.Path
    if ($currPath.ToLower().StartsWith($Home.ToLower()))
    {
        $currPath = "~" + $currPath.SubString($Home.Length)
    }
    Write-Host $currPath -ForegroundColor Cyan -NoNewline

    # Display the Git status text
    # The conditional prevents the posh-git module from being loaded every time
    # PowerShell is started. This way, it's only loaded the first time a git
    # repo is entered.
    if (Get-GitDirectory) {
        Write-VcsStatus
    }

    $LASTEXITCODE = $origLastExitCode

    # Display the prompt character
    If ($nestedPromptLevel -eq 0) {
        $promptChar = "$"
    } Else {
        $promptChar = ">"
    }
    "$($promptChar * ($nestedPromptLevel + 1)) "
}

##### FUNCTIONS #####

# An efficient alternative to "git rev-parse" to determine if you're in a git
# repo, and if so, what its path is.
function Get-GitDirectory {
    [OutputType([String])]
    $currDir = Get-Item -Path "."
    while ($currDir) {
        $gitDirPath = Join-Path $currDir.FullName ".git"
        if (Test-Path -LiteralPath $gitDirPath -PathType Container) {
            return $gitDirPath
        }
        $currDir = $currDir.Parent
    }
    return $null
}

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}
