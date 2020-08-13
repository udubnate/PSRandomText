BeforeAll {
    $projectRoot = Resolve-Path "$PSScriptRoot\.."
    $moduleRoot = Split-Path (Resolve-Path "$projectRoot\*\*.psd1")
    $moduleName = Split-Path $moduleRoot -Leaf
    }

Describe "Module Based Tests" {

    it 'the module imports successfully' {
        { Import-Module -Name "$projectRoot\PSRandomText\PSRandomText.psm1" -ErrorAction Stop } | Should -Not -Throw
    }

    it 'the module has an associated manifest' {
        Test-Path "$projectRoot\PSRandomText\PSRandomText.psd1" | should -Be $true
    }

}