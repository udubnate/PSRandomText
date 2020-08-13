$buildVersion = $env:BUILDVER
$moduleName = 'PSRandomText'

## Find the module manifest while running on the build agent
$manifestPath = Join-Path -Path "$env:SYSTEM_DEFAULTWORKINGDIRECTORY/$moduleName" -ChildPath "$moduleName.psd1"

## Update version in the manifest to the current build
$manifestContent = Get-Content -Path $manifestPath -Raw
$manifestContent = $manifestContent -replace '<ModuleVersion>', $buildVersion

## Find all of the public functions and create a string for the manifest
$publicFuncFolderPath = Join-Path -Path "$PSScriptRoot/$moduleName" -ChildPath 'public'
if ((Test-Path -Path $publicFuncFolderPath) -and ($publicFunctionNames = Get-ChildItem -Path $publicFuncFolderPath -Filter '*.ps1' | Select-Object -ExpandProperty BaseName)) {
    $funcStrings = "'$($publicFunctionNames -join "','")'"
} else {
    $funcStrings = $null
}

## Add all public functions to FunctionsToExport attribute
$manifestContent = $manifestContent -replace "'<FunctionsToExport>'", $funcStrings
$manifestContent | Set-Content -Path $manifestPath