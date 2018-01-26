#
# speechread.ps1
#
Add-Type -AssemblyName System.speech
$speak = New-Object System.Speech.Synthesis.SpeechSynthesizer
$speak.Speak('You can even jazz it up a bit by modifying the speed of speech by modifying the rate property of the object. Here a good resource to see the different properties/methods of this object – link (scroll towards the bottom)....')