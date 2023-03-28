$text = ((Get-Content text.txt) -split "\n" | Where-Object { -not [string]::IsNullOrEmpty($_) -and -not [string]::IsNullOrWhiteSpace($_) })[2]

$models = (tts --list_models | where {$_ -match "\/en\/"} | where {$_ -match "tts_models"}) -replace "\d{1,2}: "
$vocoder = (tts --list_models | where {$_ -match "\/en\/"} | where {$_ -match "vocoder"}) -replace "\d{1,2}: "

$models | foreach {
$mod = $_
tts --model_name $mod --text $text --out_path "$($mod).wav"

}


$models | foreach {
$mod = $_
$vocoder | foreach {
$voc = $_
tts --model_name $mod  --vocoder_name $voc --text $text --out_path "$($mod)-$($voc).wav"
}
}

#tts --model_name "tts_models/en/ljspeech/tacotron2-DDC" --vocoder_name "vocoder_models/en/ljspeech/hifigan_v2"  --text $text --out_path "a.wav"