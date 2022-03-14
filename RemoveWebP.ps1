$Applist = "Microsoft.WebpImageExtension"

ForEach ($App in $Applist) {

 $PackageFullName = (Get-AppxPackage $App).PackageFullName
 $ProPackageFullName = (Get-AppxProvisionedPackage -online | Where {$_.Displayname -eq $App}).PackageName
 $PackageFullNameAU = (Get-AppxPackage -AllUsers $App).PackageFullName
 write-host $PackageFullName
 Write-Host $ProPackageFullName

 if ($PackageFullName) {
     Write-Host "Removing Package: $App for your user"
     Remove-AppxPackage -Package $PackageFullName
 }

 else {
    Write-Host "Unable to find package: $App as Installed Package"
 }

 if ($ProPackageFullName) {

     Write-Host "Removing Provisioned Package: $ProPackageFullName"
     Remove-AppxProvisionedPackage -online -PackageName $ProPackageFullName
     Write-Host "Removing Provisioned Package: $ProPackageFullName for All Users"
     Remove-AppxProvisionedPackage -Online -PackageName $ProPackageFullName -AllUsers
 }

 else {
    Write-Host "Unable to find package: $App as a Provisioned Package"
 }

  if ($PackageFullNameAU) {
     Write-Host "Removing Package: $App for All Users"
     Remove-AppxPackage -AllUsers -Package $PackageFullNameAU
 }

 else {
    Write-Host "Unable to find package: $App as Installed Package for All Users"
 }

  if ($PackageFullName) {
     Write-Host "Removing Package: $App for your user, again"
     Remove-AppxPackage -Package $PackageFullName
 }

 }