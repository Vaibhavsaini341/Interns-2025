New-Item -ItemType Directory -Path "C:\Temp" -Force | Out-Null

### Install Google Chrome ###
$chromeInstaller = "C:\Temp\chrome_installer.exe"
$chromeURL = "https://dl.google.com/chrome/install/latest/chrome_installer.exe"

Write-Host "Downloading Google Chrome..."
Invoke-WebRequest -Uri $chromeURL -OutFile $chromeInstaller

Write-Host "Installing Google Chrome..."
Start-Process -FilePath $chromeInstaller -ArgumentList "/silent /install" -NoNewWindow -Wait

Remove-Item -Path $chromeInstaller -Force
Write-Host "✅ Google Chrome installed successfully!"

### Install Python ###
$pythonVersion = "3.9.6" #or specify version you need
$pythonInstaller = "C:\Temp\python-installer.exe"
$pythonURL = "https://www.python.org/ftp/python/$pythonVersion/python-$pythonVersion-amd64.exe" # Adjust URL as needed

Write-Host "Downloading Python..."
Invoke-WebRequest -Uri $pythonURL -OutFile $pythonInstaller

Write-Host "Installing Python..."
Start-Process -FilePath $pythonInstaller -ArgumentList "/quiet InstallAllUsers=1 Include_test=0" -NoNewWindow -Wait

$pythonPath = "C:\Python$pythonVersion-amd64"  # Adjust path if needed
$envPath = [Environment]::GetEnvironmentVariable("Path", "Machine")
if ($envPath -notcontains $pythonPath) {
    [Environment]::SetEnvironmentVariable("Path", "$envPath;$pythonPath;$pythonPath\Scripts", "Machine")
    Write-Host "✅ Python added to PATH."
} else {
    Write-Host "✅ Python is already in PATH."
}

Remove-Item -Path $pythonInstaller -Force
Write-Host "✅ Python $pythonVersion installed successfully!"