$dstfldrprfx = "Photos_"
$srcimgprfx = "IMG_"
$mydir = Split-Path $MyInvocation.MyCommand.Path
#
$allpics = get-childitem "$srcimgprfx*.cr2"
foreach ($pic in $allpics){
  $picnme = $pic.name
  $picdate=  Get-ChildItem $pic.name |   Select-Object -ExpandProperty CreationTime |   Get-Date -f "yyyy-MM-dd"
  
  $dstfldr = "$dstfldrprfx$picdate"
  $nwnme  = $picdate +"_"+ $picnme
  if (test-path $dstfldr) {
	  rename-item $picnme $nwnme
	  move-item $nwnme -destination $dstfldr
  } else {
	  New-Item  -Name $dstfldr -ItemType "directory"
	  rename-item $picnme $nwnme
	  move-item $nwnme -destination $dstfldr
  }
}