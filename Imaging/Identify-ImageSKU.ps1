Connect-AzAccount 

$locName="canadacentral"
Get-AzVMImagePublisher -Location $locName | Select PublisherName


$pubName="MicrosoftWindowsDesktop"
Get-AzVMImageOffer -Location $locName -PublisherName $pubName | Select Offer

$offerName="Windows-10"#"office-365"#
Get-AzVMImageSku -Location $locName -PublisherName $pubName -Offer $offerName | Select Skus

win11-21h2-avd-m365
win10-21h2-avd-g2
win10-21h2-ent-g2 

win10-22h2-ent-g2 #Single Session SKU
win10-22h2-avd-g2 #Multisession SKU

$skuName="win10-21h2-ent-g2"#"win10-21h2-avd-g2"#"win11-21h2-avd-m365"
Get-AzVMImage -Location $locName -PublisherName $pubName -Offer $offerName -Sku $skuName | Select Version



#Get-AzVMSize -Location 'canadacentral' | where {$_.name -ilike "Standard_D2s_v3"}