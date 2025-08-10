$menu =
@"
1.線上漢化(從網路下載資源)
2.離線漢化(從本地讀取資源)
3.線上還原(從網路下載資源)
4.離線還原(從本地讀取資源)
5.更新檢查
"@
Write-Host "辨識遊戲路徑中,請稍後..."
$tailPath = "FINAL FANTASY XIV - A Realm Reborn\game\sqpack\ffxiv"
$drives = Get-PSDrive -PSProvider FileSystem | Where-Object { $_.Free -gt 0 }
foreach ($drive in $drives) 
{
try
{
$squareEnixDirs = Get-ChildItem -Path $drive.Root -Directory -Filter "SquareEnix" -Recurse -ErrorAction SilentlyContinue
foreach ($dir in $squareEnixDirs)
{
$ffxivPath = Join-Path $dir.FullName "FINAL FANTASY XIV - A Realm Reborn"
if (-not (Test-Path $ffxivPath -PathType Container)) 
{
continue
}
$targetPath = Join-Path $dir.FullName $tailPath
}
}
catch{}
}
$env:Path += ";C:\Program Files\7-Zip"
$RepoOwner = "GpointChen"
$RepoName = "FFXIVChnTextPatch-GP"
$LatestRelease = Invoke-RestMethod "https://api.github.com/repos/$RepoOwner/$RepoName/releases/latest"
$Version = $LatestRelease.tag_name
$FileName_Translate = $LatestRelease.assets[1].name
$FileName_Restore = $LatestRelease.assets[0].name
$url_Translate = "https://github.com/$RepoOwner/$RepoName/releases/download/$Version/$FileName_Translate"
$url_Restore = "https://github.com/$RepoOwner/$RepoName/releases/download/$Version/$FileName_Restore"
$Test_Path_Translate = "$PSScriptRoot\$FileName_Translate"
$Test_Path_Restore = "$PSScriptRoot\$FileName_Restore"
$2 = Get-Content -Path "$PSScriptRoot\Version.txt"
do
{
cls
Write-Host "$menu"
$userchoose = Read-Host "請輸入選項"
switch($userchoose)
{
1
{
 Write-Host "正在下載漢化檔案，若速度緩慢請嘗試重新下載" -ForegroundColor Yellow
 curl.exe -L -O $url_Translate "$PSScriptRoot"
  if (Test-Path $Test_Path_Translate)
  {
  Write-Host "下載完成，正在解壓縮..."
  7z x "$PSScriptRoot\$FileName_Translate" -o"$PSScriptRoot\Local File\Translate" -y
  Write-Host "安裝漢化資源..."
  Get-ChildItem "$PSScriptRoot\Local File\Translate" | copy -Destination "$targetPath" -Recurse -Force
  Remove-Item -Path "$PSScriptRoot\$FileName_Translate" -Recurse -Force
  Write-Host "漢化完成!" -ForegroundColor Green
  Set-Content -Path "$PSScriptRoot\Version.txt" -Value "$Version"
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
$files_Translate = Get-ChildItem -Path "$PSScriptRoot\Local File\Translate" -ErrorAction SilentlyContinue
if($files_Translate.Count -eq 0)
{
Write-Host "漢化資源不存在，請點選項1線上漢化" -ForegroundColor Yellow
timeout /t -1
}
else
{
Get-ChildItem -Path "$PSScriptRoot\Local File\Translate" | copy -Destination "$targetPath" -Recurse -Force
Write-Host "漢化完成!" -ForegroundColor Green
timeout /t -1
}
}
3
{
Write-Host "正在下載還原檔案，若速度緩慢請嘗試重新下載" -ForegroundColor Yellow
 curl.exe -L -O $Url_Restore "$PSScriptRoot"
  if (Test-Path $Test_Path_Restore)
  {
  Write-Host "下載完成，正在解壓縮..."
  7z x "$PSScriptRoot\$FileName_Restore" -o"$PSScriptRoot\Local File\Restore" -y
  Write-Host "安裝還原資源..."
  Get-ChildItem "$PSScriptRoot\Local File\Restore" | copy -Destination "$targetPath" -Recurse -Force
  Remove-Item -Path "$PSScriptRoot\$FileName_Restore" -Recurse -Force
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
$files_Restore = Get-ChildItem "$PSScriptRoot\Local File\Restore" -ErrorAction SilentlyContinue
if($files_Restore.Count -eq 0)
{
Write-Host "還原資源不存在，請點選項3線上還原" -ForegroundColor Yellow
timeout /t -1
}
else
{
Get-ChildItem "$PSScriptRoot\Local File\Restore" | copy -Destination "$targetPath" -Recurse -Force
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