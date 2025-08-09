$menu =
@"
1.線上漢化(從網路下載資源)
2.離線漢化(從本地讀取資源)
3.線上還原(從網路下載資源)
4.離線還原(從本地讀取資源)
5.更新檢查
"@
do
{
cls
Write-Host "$menu"
$RepoOwner = "GpointChen"
$RepoName = "FFXIVChnTextPatch-GP"
$LatestRelease = Invoke-RestMethod "https://api.github.com/repos/$RepoOwner/$RepoName/releases/latest"
$Version = $LatestRelease.tag_name
$FileName_Translate = $LatestRelease.assets[1].name
$FileName_Restore = $LatestRelease.assets[0].name
$url_Translate = "https://github.com/$RepoOwner/$RepoName/releases/download/$Version/$FileName_Translate"
$url_Restore = "https://github.com/$RepoOwner/$RepoName/releases/download/$Version/$FileName_Restore"
$Test_Path_Translate = "$env:USERPROFILE\Desktop\FF14 Translate\$FileName_Translate"
$Test_Path_Restore = "$env:USERPROFILE\Desktop\FF14 Translate\$FileName_Restore"
$2 = Get-Content -Path "$env:USERPROFILE\Desktop\FF14 Translate\Version.txt"
$userchoose = Read-Host "請輸入選項"
switch($userchoose)
{
1
{
 Write-Host "正在下載更新" 
 curl.exe -L -O $url_Translate "$env:USERPROFILE\Desktop\FF14 Translate"
  if (Test-Path $Test_Path_Translate)
  {
  Write-Host "下載完成，正在解壓縮..."
  7z x "$env:USERPROFILE\Desktop\FF14 Translate\$FileName_Translate" -o"D:\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\sqpack\Translate File" -y
  Write-Host "安裝漢化資源..."
  Get-ChildItem "D:\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\sqpack\Translate File" | copy -Destination "D:\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\sqpack\ffxiv" -Recurse -Force
  Remove-Item -Path "$env:USERPROFILE\Desktop\FF14 Translate\$FileName_Translate" -Recurse -Force
  Write-Host "漢化完成!" -ForegroundColor Green
  Set-Content -Path "$env:USERPROFILE\Desktop\FF14 Translate\Version.txt" -Value "$Version"
  timeout /t -1
  }
  else
  {
  Write-Host "下載失敗" -ForegroundColor Red
  timeout /t -1
  }
 }
2
{
$files_Translate = Get-ChildItem -Path "D:\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\sqpack\Translate File"
if($files_Translate.Count -eq 0)
{
Write-Host "漢化資源不存在，請點選項1線上漢化" -ForegroundColor Yellow
timeout /t -1
}
else
{
Get-ChildItem -Path "D:\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\sqpack\Translate File" | copy -Destination "D:\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\sqpack\ffxiv" -Recurse -Force
Write-Host "漢化完成!" -ForegroundColor Green
timeout /t -1
}
}
3
{
Write-Host "正在下載還原檔案"
 curl.exe -L -O $Url_Restore "$env:USERPROFILE\Desktop\FF14 Translate"
  if (Test-Path $Test_Path_Restore)
  {
  Write-Host "下載完成，正在解壓縮..."
  7z x "$env:USERPROFILE\Desktop\FF14 Translate\$FileName_Restore" -o"D:\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\sqpack\Restore File" -y
  Write-Host "安裝還原資源..."
  Get-ChildItem "D:\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\sqpack\Restore File" | copy -Destination "D:\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\sqpack\ffxiv" -Recurse -Force
  Remove-Item -Path "$env:USERPROFILE\Desktop\FF14 Translate\$FileName_Restore" -Recurse -Force
  Write-Host "還原完成!" -ForegroundColor Green
  timeout /t -1
  }
  else
  {
  Write-Host "下載失敗" -ForegroundColor Red
  timeout /t -1
  }
}
4
{
$files_Restore = Get-ChildItem "D:\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\sqpack\Restore File"
if($files_Restore.Count -eq 0)
{
Write-Host "還原資源不存在，請點選項3線上還原" -ForegroundColor Yellow
timeout /t -1
}
else
{
Get-ChildItem "D:\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\sqpack\Restore File" | copy -Destination "D:\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\sqpack\ffxiv" -Recurse -Force
Write-Host "還原完成!" -ForegroundColor Green
timeout /t -1
}
}
5
{
foreach($1 in $2)
{
if($1 -ne $Version)
 {
 Write-Host "有新漢化版本，請點選項1更新!" -ForegroundColor Green
 timeout /t -1
 }
 else
 {
 Write-Host "已是最新漢化版本!" -ForegroundColor Green
 timeout /t -1
 }
}
}
default
{
Write-Host "無效的選項，請輸入1、2或3" -ForegroundColor Yellow
timeout /t -1
}
}
}while($userchoose -ne 3.1415926)