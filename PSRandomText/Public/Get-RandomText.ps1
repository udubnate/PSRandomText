function Get-RandomText {
    [CmdletBinding()]
    param(
        [Parameter()]
        [ValidateSet("lorem","gibberish")]
        [String]$Generator = "gibberish",

        [Parameter()]
        [ValidateSet("p","ul","ol","h1","h2","h3","h4")]
        [String]$Element = "p",

        [Parameter()]
        [Int32]$ElementCount = 5,

        [Parameter()]
        [Int32]$WordMin = 50,
        
        
        [Parameter()]
        [Int32]$WordMax = 150,

        [Parameter()]
        [switch]$RemoveTags
        
    )

    process {

        $Uri = "http://www.randomtext.me/api/" + $Generator + "/" + $Element + "-" + $ElementCount + "/" + $WordMin + "-" + $WordMax

        $RandomText = Invoke-RestMethod -uri $Uri

        if ($RemoveTags){
            #add logic to remove tags
        } else {
        $RandomText.text_out
        }
    }
    
}