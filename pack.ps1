# pack.ps1
$folders = @("one", "two", "three")

Remove-Item -Recurse -Force site -ErrorAction SilentlyContinue | Out-Null
Remove-Item -Force .\site.zip -ErrorAction SilentlyContinue | Out-Null
New-Item -ItemType Directory -Path site | Out-Null

foreach ($folder in $folders) {
    Write-Host "$folder 🏗️"
    New-Item -ItemType Directory -Path "site\$folder" | Out-Null

    Push-Location $folder

    $env:GIT_CONTRIBS_ON = "True"
    mkdocs build

    Move-Item -Path "site\*" -Destination "..\site\$folder" -Force
    Remove-Item -Recurse -Force site
    Pop-Location
}

# The home is special...
Write-Host "home"
Push-Location home
mkdocs build
Move-Item -Path "site\*" -Destination "..\site\" -Force
Remove-Item -Recurse -Force site
Pop-Location

Write-Host "All done! ✨ 🍰 ✨"
