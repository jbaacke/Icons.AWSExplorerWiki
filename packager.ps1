# Define the classes I will use to generate the tiddlers from the images

Class IconTiddler
{
   [string]$_canonical_uri
   [string]$title
   [string]$awsexplorerwiki_icon_path


   # Static-ish
   [string]$text = ""
   [string]$type = "image/png"
   [string]$tags = '$:/tags/Image Icons.AWSExplorerWiki.Icons'


   # Constructor
   IconTiddler ([string]$FullFileName)
   {
       $this.awsexplorerwiki_icon_path = $FullFileName.Replace('C:/Gepos/Icons.AWSExplorerWiki/',"")
       $this.title = ("Icons.AWSExplorerWiki/" + $this.awsexplorerwiki_icon_path)
       $this._canonical_uri = ('https://icons.awsexplorerwiki.com/' + $this.awsexplorerwiki_icon_path)
   }

}

Class FriendlyIconTiddler
{
   [string]$title
   [string]$text


   # Static-ish
   [string]$type = "image/png"
   [string]$tags = '$:/tags/Image Icons.AWSExplorerWiki.FriendlyIcons'


   # Constructor
   FriendlyIconTiddler ([string]$Title, [string]$PointsTo)
   {
       $relevantpath = $FullFileName.Replace('C:/Gepos/Icons.AWSExplorerWiki/',"")
       $this.title = ("Icons.AWSExplorerWiki/" + $relevantpath)
       $this._canonical_uri = ('https://icons.awsexplorerwiki.com/' + $relevantpath)
       $this.awsexplorerwiki_icon_path = $relevantpath
   }

}

# Clear the wierd indexing files so they don't get uploaded in the build
Get-ChildItem -Include *.DS_Store -Recurse | Remove-Item

# Get a list of all the icons in the current folder, then iterate through 
# them generating a tiddler for each
$icons = Get-ChildItem -Recurse -Include *.png
$jsonicons = @()
foreach ($icon in $icons)
{
    Write-Host $icon.FullName
    $jsonicons += [IconTiddler]::new($icon.FullName.Replace('\','/'))
}




# Write 
$jsonicons | ConvertTo-Json | Set-Content "tiddlers.json"


