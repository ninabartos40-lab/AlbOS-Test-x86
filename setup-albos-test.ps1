$ErrorActionPreference = 'Stop'
$vmName = 'AlbOS Test'
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$isoPath = Join-Path $root 'android-x86_64-9.0-r2.iso'
$vmFolder = Join-Path $root 'vm-data'
$diskPath = Join-Path $vmFolder 'AlbOS-Test.vdi'
$isoUrl = 'https://sourceforge.net/projects/android-x86/files/Release%209.0/android-x86_64-9.0-r2.iso/download'

$vbox = (Get-Command VBoxManage.exe -ErrorAction SilentlyContinue).Source
if (-not $vbox) {
    $candidate = Join-Path $env:ProgramFiles 'Oracle\VirtualBox\VBoxManage.exe'
    if (Test-Path $candidate) { $vbox = $candidate }
}
if (-not $vbox) {
    throw 'VirtualBox nu a fost găsit. Instalează VirtualBox, apoi rulează din nou setup-albos-test.bat.'
}

New-Item -ItemType Directory -Force -Path $vmFolder | Out-Null
if (-not (Test-Path $isoPath)) {
    Write-Host 'Descarc imaginea oficială Android-x86 9.0-r2 (download mare)...'
    Invoke-WebRequest -Uri $isoUrl -OutFile $isoPath
}
if ((Get-Item $isoPath).Length -lt 100MB) {
    Remove-Item $isoPath -Force
    throw 'Descărcarea ISO pare incompletă. Șterge fișierul ISO și încearcă din nou.'
}

$existing = & $vbox list vms
if ($existing -match ('"' + [regex]::Escape($vmName) + '"')) {
    throw "VM-ul '$vmName' există deja. Șterge-l din VirtualBox sau redenumește-l înainte de a rula configurarea din nou."
}

& $vbox createvm --name $vmName --ostype Linux_64 --basefolder $vmFolder --register
if ($LASTEXITCODE -ne 0) { throw 'VirtualBox nu a putut crea VM-ul.' }
& $vbox modifyvm $vmName --memory 4096 --cpus 2 --vram 128 --graphicscontroller vmsvga --nic1 nat --boot1 dvd --boot2 disk
if ($LASTEXITCODE -ne 0) { throw 'Nu s-au putut seta resursele VM-ului.' }
& $vbox createhd --filename $diskPath --size 24576 --format VDI
if ($LASTEXITCODE -ne 0) { throw 'Nu s-a putut crea discul virtual.' }
& $vbox storagectl $vmName --name SATA --add sata --controller IntelAhci
if ($LASTEXITCODE -ne 0) { throw 'Nu s-a putut crea controlerul SATA.' }
& $vbox storageattach $vmName --storagectl SATA --port 0 --device 0 --type hdd --medium $diskPath
if ($LASTEXITCODE -ne 0) { throw 'Nu s-a putut atașa discul virtual.' }
& $vbox storagectl $vmName --name IDE --add ide
if ($LASTEXITCODE -ne 0) { throw 'Nu s-a putut crea controlerul IDE.' }
& $vbox storageattach $vmName --storagectl IDE --port 0 --device 0 --type dvddrive --medium $isoPath
if ($LASTEXITCODE -ne 0) { throw 'Nu s-a putut atașa imaginea ISO.' }

Write-Host 'Pornesc AlbOS Test: acesta bootează Android-x86 în VirtualBox.'
Write-Host 'Alege Live CD pentru testare, sau Installation pentru instalarea în discul virtual.'
& $vbox startvm $vmName
if ($LASTEXITCODE -ne 0) { throw 'VM-ul a fost creat, dar VirtualBox nu l-a putut porni.' }
