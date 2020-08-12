BeforeAll {
    $projectRoot = Resolve-Path "$PSScriptRoot\.."
    $moduleRoot = Split-Path (Resolve-Path "$projectRoot\*\*.psd1")
    $moduleName = Split-Path $moduleRoot -Leaf
}

Describe "PSScriptAnalyzer rule-sets" -Tag Build {

    $rules = Get-ScriptAnalyzerRule
    $scripts = Get-ChildItem $moduleRoot -Include *.ps1, *.psm1, *.psd1 -Recurse | Where-Object fullname -notmatch 'classes' 
    
    if ($scripts.count -gt 0) {
        Context 'PSScriptAnalyzer analysis' {
            It "<Path> Should not violate: <IncludeRule>"`
                -TestCases @(
                Foreach ($script in $scripts) {
                    Foreach ($rule in $rules) {
                        @{
                            IncludeRule = $rule.RuleName
                            Path        = $script.FullName
                        }
                    }
                }
            ) {
                param($IncludeRule, $Path)
                $results = Invoke-ScriptAnalyzer -Path $Path -IncludeRule $IncludeRule
                if ($results.Count -ne 0) {
                    $first = $true
                    foreach ($result in $results) {
                        if ($first){
                        $message = "ScriptName: $($result.ScriptName) :: RuleName: $($result.RuleName) :: Severity: $($result.Severity) :: Line(s) $($result.Line),"
                        $first = $false
                        }
                        else {
                        $message += "$($result.Line),"
                        }
                    }
                    $message = $message.TrimEnd(',')
                    $message | Should -BeNullOrEmpty
                }
            }
        }
    }
}
   

