# Generate thumbnail.png using .NET System.Drawing
Add-Type -AssemblyName System.Drawing

$outPath = "D:\Teaching\2026_1\bizbig\BizModelC\bizmodel-bots-2026\thumbnail.png"

$bmp = New-Object System.Drawing.Bitmap 1200, 630
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = 'AntiAlias'
$g.TextRenderingHint = 'AntiAlias'

# Background gradient
$bgBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
    (New-Object System.Drawing.Point 0, 0),
    (New-Object System.Drawing.Point 1200, 630),
    [System.Drawing.Color]::FromArgb(26, 54, 93),
    [System.Drawing.Color]::FromArgb(45, 90, 135)
)
$g.FillRectangle($bgBrush, 0, 0, 1200, 630)

# Gold accent bars
$goldColor = [System.Drawing.Color]::FromArgb(212, 165, 116)
$goldBrush = New-Object System.Drawing.SolidBrush $goldColor
$g.FillRectangle($goldBrush, 0, 0, 1200, 8)
$g.FillRectangle($goldBrush, 0, 622, 1200, 8)

# Fonts
$subFont = New-Object System.Drawing.Font 'Malgun Gothic', 18, ([System.Drawing.FontStyle]::Regular)
$titleFont = New-Object System.Drawing.Font 'Malgun Gothic', 48, ([System.Drawing.FontStyle]::Bold)
$descFont = New-Object System.Drawing.Font 'Malgun Gothic', 16, ([System.Drawing.FontStyle]::Regular)
$tagFont = New-Object System.Drawing.Font 'Malgun Gothic', 15, ([System.Drawing.FontStyle]::Italic)
$botFont = New-Object System.Drawing.Font 'Malgun Gothic', 16, ([System.Drawing.FontStyle]::Bold)

# Center formatting
$sf = New-Object System.Drawing.StringFormat
$sf.Alignment = 'Center'
$sf.LineAlignment = 'Center'

$whiteBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::White)
$grayBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(204, 204, 204))
$navyBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(26, 54, 93))

# Subtitle
$g.DrawString('2026 BIZ MODEL BOT', $subFont, $goldBrush,
    (New-Object System.Drawing.RectangleF 0, 75, 1200, 30), $sf)

# Main title
$g.DrawString('16개의 AI 친구 봇', $titleFont, $whiteBrush,
    (New-Object System.Drawing.RectangleF 0, 140, 1200, 80), $sf)

# Divider
$pen = New-Object System.Drawing.Pen $goldColor, 2
$g.DrawLine($pen, 500, 235, 700, 235)

# Description
$g.DrawString('데이터경영학과 & 경영학전공', $descFont, $grayBrush,
    (New-Object System.Drawing.RectangleF 0, 255, 1200, 30), $sf)

# Row 1 bots (white circles)
$bots1 = @('식구', '택씨', '분개해', '잠깐만', '장보고', '그릭', '나달', '포커')
for ($i = 0; $i -lt 8; $i++) {
    $cx = 195 + ($i * 100)
    $cy = 380
    $g.FillEllipse($whiteBrush, ($cx - 44), ($cy - 44), 88, 88)
    $g.DrawString($bots1[$i], $botFont, $navyBrush,
        (New-Object System.Drawing.RectangleF ($cx - 44), ($cy - 44), 88, 88), $sf)
}

# Row 2 bots (gold circles)
$bots2 = @('지키미', '숨돌이', '곳간이', '출조각', '새로미', '상도', '토닥이', '하루')
for ($i = 0; $i -lt 8; $i++) {
    $cx = 245 + ($i * 100)
    $cy = 485
    $g.FillEllipse($goldBrush, ($cx - 44), ($cy - 44), 88, 88)
    $g.DrawString($bots2[$i], $botFont, $whiteBrush,
        (New-Object System.Drawing.RectangleF ($cx - 44), ($cy - 44), 88, 88), $sf)
}

# Tagline
$g.DrawString('"AI 도구가 아니라, 옆자리에 있어주는 AI 친구"', $tagFont, $goldBrush,
    (New-Object System.Drawing.RectangleF 0, 580, 1200, 30), $sf)

# Save
$bmp.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose()
$bmp.Dispose()

$size = (Get-Item $outPath).Length
Write-Output "OK: $outPath ($size bytes)"
