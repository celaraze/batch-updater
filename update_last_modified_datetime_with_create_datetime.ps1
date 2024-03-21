# 获取视频文件夹路径
$folderPath = "C:\Users\your_name\mp4"

# 获取文件夹中的所有文件
$files = Get-ChildItem -Path $folderPath

# 遍历文件夹中的每一个文件
foreach ($file in $files) {
    # 使用exiftool获取文件的拍摄日期
    $dateTaken = & .\exiftool.exe -s -s -s -CreateDate $file.FullName

    # 如果拍摄日期不为空，则修改文件的修改日期
    if ($dateTaken) {
        # 将拍摄日期转换为DateTime对象
        $dateTaken = [DateTime]::ParseExact($dateTaken, "yyyy:MM:dd HH:mm:ss", $null)

        # 将UTC时间转换为本地时间
        $dateTaken = $dateTaken.ToLocalTime()

        # 修改文件的修改日期
        [System.IO.File]::SetLastWriteTime($file.FullName, $dateTaken)
    }
}