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
   [string]$tags = '$:/tags/Image Icons.AWSExplorerWiki.FriendlyIcons'


   # Constructor
   FriendlyIconTiddler ([string]$Title, [string]$PointsTo)
   {
        $this.title = $Title + ' Icon'
        $this.text = '{{' + $PointsTo + '}}'
   }

}

#region Base Icons

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

#endregion 

# Generate a series of friendly icons based on my personal preference
$jsonicons += [FriendlyIconTiddler]::new("Person", "Icons.AWSExplorerWiki/Icons/AWS/Light-BG/_General AWS/AWS-General_User_light-bg.png")
$jsonicons += [FriendlyIconTiddler]::new("Group", "Icons.AWSExplorerWiki/Icons/AWS/Light-BG/_General AWS/AWS-General_Users_light-bg.png")
$jsonicons += [FriendlyIconTiddler]::new("EC2 Instance", "Icons.AWSExplorerWiki/Icons/AWS/Light-BG/Compute/_EC2 Instance Types/Amazon-EC2_Instance_light-bg.png")
$jsonicons += [FriendlyIconTiddler]::new("Elastic IP", "Icons.AWSExplorerWiki/Icons/AWS/Light-BG/Compute/Amazon-EC2_Elastic-IP-Address_light-bg.png")
$jsonicons += [FriendlyIconTiddler]::new("Lambda Function", "Icons.AWSExplorerWiki/Icons/AWS/Light-BG/Compute/AWS-Lambda_Lambda-Function_light-bg.png")
$jsonicons += [FriendlyIconTiddler]::new("DynamoDB Table", "Icons.AWSExplorerWiki/Icons/AWS/Light-BG/Database/Amazon-DynamoDB_Table_light-bg.png")
$jsonicons += [FriendlyIconTiddler]::new("IOT Certificate", "Icons.AWSExplorerWiki/Icons/AWS/Light-BG/Internet of Things/IoT_Certificate-Manager_light-bg.png")
$jsonicons += [FriendlyIconTiddler]::new("Hosted Zone", "Icons.AWSExplorerWiki/Icons/AWS/Light-BG/Networking & Content Delivery/Amazon-Route-53_Hosted-Zone_light-bg.png")
$jsonicons += [FriendlyIconTiddler]::new("Route Table", "Icons.AWSExplorerWiki/Icons/AWS/Light-BG/Networking & Content Delivery/Amazon-Route-53_Route-Table_light-bg.png")
$jsonicons += [FriendlyIconTiddler]::new("Internet Gateway", "Icons.AWSExplorerWiki/Icons/AWS/Light-BG/Networking & Content Delivery/Amazon-VPC_Internet-Gateway_light-bg.png")
$jsonicons += [FriendlyIconTiddler]::new("NAT Gateway", "Icons.AWSExplorerWiki/Icons/AWS/Light-BG/Networking & Content Delivery/Amazon-VPC_NAT-Gateway_light-bg.png:")
$jsonicons += [FriendlyIconTiddler]::new("Certificate Manager Certificate", "Icons.AWSExplorerWiki/Icons/AWS/Light-BG/Security, Identity, and Compliance/AWS-Certificate-Manager_Certificate-Manager_light-bg.png")
$jsonicons += [FriendlyIconTiddler]::new("Access Key", "Icons.AWSExplorerWiki/Icons/AWS/Light-BG/Security, Identity, and Compliance/AWS-Identity-and-Access-Management-IAM_Add-on_light-bg.png")
$jsonicons += [FriendlyIconTiddler]::new("IAM Policy", "Icons.AWSExplorerWiki/Icons/AWS/Light-BG/Security, Identity, and Compliance/AWS-Identity-and-Access-Management-IAM_Permissions_light-bg.png")
$jsonicons += [FriendlyIconTiddler]::new("IAM Role", "Icons.AWSExplorerWiki/Icons/AWS/Light-BG/Security, Identity, and Compliance/AWS-Identity-and-Access-Management-IAM_Role_light-bg.png")
$jsonicons += [FriendlyIconTiddler]::new("S3 Bucket", "Icons.AWSExplorerWiki/Icons/AWS/Light-BG/Storage/Amazon-Simple-Storage-Service-S3_Bucket_light-bg.png")
$jsonicons += [FriendlyIconTiddler]::new("S3 Object", "Icons.AWSExplorerWiki/Icons/AWS/Light-BG/Storage/Amazon-Simple-Storage-Service-S3_Object_light-bg.png")
$jsonicons += [FriendlyIconTiddler]::new("CloudFront Distribution", "Icons.AWSExplorerWiki/Icons/AWS/Dark-BG/Networking & Content Delivery/Amazon-CloudFront_Download-Distribution_dark-bg.png")
$jsonicons += [FriendlyIconTiddler]::new("CloudFormation Stack", "Icons.AWSExplorerWiki/Icons/AWS/Light-BG/Management & Governance/AWS-CloudFormation_Stack_light-bg.png")


# Write 
$jsonicons | ConvertTo-Json | Set-Content "tiddlers.json"


