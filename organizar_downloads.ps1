$DownloadsPath = [System.IO.Path]::Combine($env:USERPROFILE, 'Downloads')

# Verifica se a pasta de Downloads existe

if (!(Test-Path -Path $DownloadsPath)) {
    Write-Host "A pasta de Downloads não foi encontrada."
    exit
}

# Obtém todos os arquivos na pasta Downloads

$files = Get-ChildItem -Path $DownloadsPath -File

foreach ($file in $files) {
    $extension = $file.Extension.TrimStart('.')
    
    # Ignora arquivos sem extensão
    
    if (-not $extension) {
        continue
    }
    
    $destinationFolder = [System.IO.Path]::Combine($DownloadsPath, $extension.ToUpper())
    
    # Cria a pasta de destino se não existir
    
    if (!(Test-Path -Path $destinationFolder)) {
        New-Item -ItemType Directory -Path $destinationFolder | Out-Null
    }
    
    # Move o arquivo para a pasta correspondente

    $destinationPath = [System.IO.Path]::Combine($destinationFolder, $file.Name)
    Move-Item -Path $file.FullName -Destination $destinationPath -Force
}

Write-Host "Concluido!"