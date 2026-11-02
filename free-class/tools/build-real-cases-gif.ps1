$ErrorActionPreference = 'Stop'

$freeClassRoot = Split-Path -Parent $PSScriptRoot
$assetsRoot = Join-Path $freeClassRoot 'assets'
$tempRoot = Join-Path ([System.IO.Path]::GetTempPath()) 'aihomepage-free-class-real-cases-v2'
$frameRoot = Join-Path $tempRoot 'frames'
$fontBold = 'C\:/Windows/Fonts/malgunbd.ttf'
$fontRegular = 'C\:/Windows/Fonts/malgun.ttf'

New-Item -ItemType Directory -Force -Path $frameRoot | Out-Null

$cases = @(
  @{ Image='geosang-marketing.webp'; Name='거상마케팅센터'; Category='마케팅 · 비즈니스'; Description='마케팅 서비스 소개와 상담 연결' },
  @{ Image='kimtaehoon-office.webp'; Name='김태훈 행정사'; Category='전문 서비스 · 행정사'; Description='행정 서비스와 상담 정보를 소개하는 전문가 홈페이지' },
  @{ Image='dongdong-sweetmade.webp'; Name='동동 스위트메이드'; Category='식음료 · 카페'; Description='디저트 상품과 브랜드 비주얼 소개' },
  @{ Image='hongcheon-yeolmokeo.webp'; Name='홍천 열목어마을'; Category='숙박·공간 · 마을·체험'; Description='마을 소개와 숙박·체험·워크숍 정보를 보여주는 홈페이지' },
  @{ Image='hongcheon-peach.webp'; Name='홍천 복숭아'; Category='농수산 · 상품'; Description='농산물의 특징과 구매 정보 소개' },
  @{ Image='sydneypick.webp'; Name='시드니픽'; Category='여행 · 콘텐츠'; Description='여행 정보와 콘텐츠 탐색' }
)

for ($index = 0; $index -lt $cases.Count; $index++) {
  $case = $cases[$index]
  $inputImage = Join-Path $assetsRoot (Join-Path 'cases' $case.Image)
  $framePath = Join-Path $frameRoot ('case-{0:D2}.png' -f ($index + 1))
  $filter = "[1:v]scale=780:468:force_original_aspect_ratio=decrease,pad=780:468:(ow-iw)/2:(oh-ih)/2:color=white[shot];" +
    "[0:v]drawbox=x=40:y=214:w=780:h=480:color=white:t=fill," +
    "drawbox=x=40:y=214:w=780:h=480:color=0xDCE4EF:t=2," +
    "drawtext=fontfile='$fontBold':text='REAL CASES':fontcolor=0x2F6FEB:fontsize=17:x=(w-text_w)/2:y=52," +
    "drawtext=fontfile='$fontBold':text='다양한 업종의 실제 홈페이지 제작사례':fontcolor=0x10182E:fontsize=31:x=(w-text_w)/2:y=86[bg];" +
    "[bg][shot]overlay=40:220," +
    "drawtext=fontfile='$fontBold':text='$($case.Name)':fontcolor=0x10182E:fontsize=34:x=(w-text_w)/2:y=730," +
    "drawtext=fontfile='$fontRegular':text='$($case.Category)':fontcolor=0x2F6FEB:fontsize=20:x=(w-text_w)/2:y=780," +
    "drawtext=fontfile='$fontRegular':text='$($case.Description)':fontcolor=0x536077:fontsize=19:x=(w-text_w)/2:y=822"

  & ffmpeg -loglevel error -y -f lavfi -i 'color=c=0xF3F6FB:s=860x912:d=1' -i $inputImage -filter_complex $filter -frames:v 1 -update 1 $framePath
  if ($LASTEXITCODE -ne 0) { throw "Failed to render $($case.Name)" }
}

$posterPath = Join-Path $assetsRoot 'posters\02-real-cases-v2.png'
Copy-Item -LiteralPath (Join-Path $frameRoot 'case-01.png') -Destination $posterPath -Force

$concatPath = Join-Path $tempRoot 'slides.txt'
$concatLines = foreach ($index in 1..$cases.Count) {
  "file '$((Join-Path $frameRoot ('case-{0:D2}.png' -f $index)).Replace("'", "''"))'"
  'duration 1.5'
}
$concatLines += "file '$((Join-Path $frameRoot ('case-{0:D2}.png' -f $cases.Count)).Replace("'", "''"))'"
[System.IO.File]::WriteAllLines($concatPath, $concatLines, [System.Text.UTF8Encoding]::new($false))

$gifPath = Join-Path $assetsRoot 'animations\02-real-cases-v2.gif'
$gifFilter = 'fps=10,split[s0][s1];[s0]palettegen=max_colors=128:stats_mode=diff[p];[s1][p]paletteuse=dither=bayer:bayer_scale=3:diff_mode=rectangle'
& ffmpeg -loglevel error -y -f concat -safe 0 -i $concatPath -vf $gifFilter -loop 0 $gifPath
if ($LASTEXITCODE -ne 0) { throw 'Failed to build the real-cases GIF' }

Write-Output "Built: $gifPath"
Write-Output "Poster: $posterPath"
