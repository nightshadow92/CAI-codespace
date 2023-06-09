﻿
#chmod +x prepare-env.sh
#./prepare-env.sh



$text = ((Get-Content text.txt) -split "\n" | Where-Object { -not [string]::IsNullOrEmpty($_) -and -not [string]::IsNullOrWhiteSpace($_) })[2]

$models = (tts --list_models | where {$_ -match "\/en\/"} | where {$_ -match "tts_models"}) -replace "^.*?\d{1,2}: " -replace " \[already downloaded\]"
$vocoder = (tts --list_models | where {$_ -match "\/en\/"} | where {$_ -match "vocoder"}) -replace "^.*?\d{1,2}: " -replace " \[already downloaded\]"

$models | foreach {
$mod = $_
$file = ("$($mod).wav") -replace "\/","-"
write-host "tts --model_name $mod --text $text --out_path $file"
tts --model_name $mod --text $text --out_path $file

}


#$models | foreach {
#$mod = $_
#$vocoder | foreach {
#$voc = $_
#$file = ("$($mod)--$($voc).wav") -replace "\/","-"
#tts --model_name $mod  --vocoder_name $voc --text $text --out_path $file
#}
#}

#tts --model_name "tts_models/en/ljspeech/tacotron2-DDC" --vocoder_name "vocoder_models/en/ljspeech/hifigan_v2"  --text $text --out_path "a.wav"

exit