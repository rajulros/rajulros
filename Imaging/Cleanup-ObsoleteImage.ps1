#NOTE: This script can be used to cleanup obsolete image versions in your shared image gallery

##Get-Module -ListAvailable
#Install-Module -Name Az -AllowClobber
Install-Module -Name Az -Repository PSGallery -Force
Update-Module -Name Az -Force
Get-ExecutionPolicy -List
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Get-Module -Name AzureRM -ListAvailable
Import-Module Az
Connect-Azaccount -Subscription 93532d02-130f-4318-b508-9ac4fbf37f8d
$publisheddate = (Get-Date).AddMonths(-3)


#region shared image gallery details
$imagegallery = Get-AzGallery -ResourcegroupName rg-aztf-machine-images-dev -GalleryName galaztfmachineimagesdev
$imagegallerydefinitioninfo = Get-AzGalleryImageDefinition -GalleryName $imagegallery.Name -ResourceGroupName $imagegallery.ResourceGroupName -Name windows21H2-multisession 
$imagegalleryinfo = Get-AzGalleryImageVersion -GalleryName $imagegallery.Name -ResourceGroupName $imagegallery.ResourceGroupName -GalleryImageDefinitionName $imagegallerydefinitioninfo.Name
 
#endregion
 
#region delete image versions
 
foreach ($imageversion in $imagegalleryinfo)
{
    If($imageversion.PublishingProfile.publisheddate -lt $publisheddate){

    Write-Host "Removing $($imageversion.name) from $($imagegallerydefinitioninfo.Name)" -ForegroundColor Red
    Remove-AzGalleryImageVersion -GalleryName $imagegallery.Name -GalleryImageDefinitionName $imagegallerydefinitioninfo.Name -Name $imageversion.Name -ResourceGroupName $imageversion.ResourceGroupName -force -AsJob
    }
 
}
#endregion