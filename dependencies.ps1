### Run this to install apps that you commonly use
### ----------------------------------------------

function Check-Command($cmdname)
{
    return [bool](Get-Command -Name $cmdname -ErrorAction SilentlyContinue)
}

# Reload the $env object from the registry
function Refresh-Environment {
    $locations = 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment',
                 'HKCU:\Environment'

    $locations | ForEach-Object {
        $k = Get-Item $_
        $k.GetValueNames() | ForEach-Object {
            $name  = $_
            $value = $k.GetValue($_)
            Set-Item -Path Env:\$name -Value $value
        }
    }

    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}

If (!(Check-Command -cmdname 'choco')) {
    Invoke-WebRequest https://chocolatey.org/install.ps1 -UseBasicParsing | Invoke-Expression
    Refresh-Environment

    # So we don't have to manually confirm installation scripts
    choco feature enable -n=allowGlobalConfirmation
}
Else {
    Write-Output 'Chocolatey is already installed'
}

Write-Output 'Installing dependencies with chocolatey'

# browsers

choco install googlechrome
choco install firefox

# devtools
choco install git
choco install nodejs
choco install yarn
choco install hyper
choco install visualstudiocode
choco install heroku-cli
choco install virtualbox
choco install imagemagick
choco install winmerge

# cloud storage
choco install googledrive
choco install dropbox

# other apps I use
choco install autohotkey
choco install 7zip
choco install keepass
choco install youtube-dl
choco install mpv
choco install kodi
choco install handbrake
choco install sumatrapdf

# Refreshing before continuing
Refresh-Environment

Write-Output 'Installing global node modules'
# installing latest version of npm
npm install -g npm
npm install -g --production windows-build-tools # needed for node-gyp
npm install -g node-gyp
npm install -g create-react-app
npm install -g nodemon
npm install -g http-server
npm install -g node-inspector