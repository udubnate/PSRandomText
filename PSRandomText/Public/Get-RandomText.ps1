function Get-RandomText {
    [CmdletBinding()]
    param(
        [Parameter()]
        [ValidateSet("lorem","gibberish")]
        [String]$Generator = "gibberish",

        [Parameter()]
        [ValidateSet("paragraphs","unorderedlist","orderedlist","h1","h2","h3","h4")]
        [String]$Element = "paragraphs",

        [Parameter()]
        [Int32]$ElementCount = 5,

        [Parameter()]
        [Int32]$WordCount = 25   
    )

    process {

        $Uri = "http://www.randomtext.me/api/" + $Generator + "/"

        $RandomText = Invoke-RestMethod -uri "http://www.randomtext.me/api/gibberish/p-1/50-150"
    }
    
}