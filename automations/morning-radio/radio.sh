#!/usr/bin/env bash
# Озвучка утреннего выпуска: radio.txt -> mp3 (голос «Ирина, улучшенная»)
# Использование: ./radio.sh radio.txt "Утренний_выпуск_17.10.mp3"
set -euo pipefail
IN="${1:-radio.txt}"
OUT="${2:-radio.mp3}"

pip install -q --break-system-packages piper-tts
if [ ! -f ru-irinia-medium.onnx ]; then
  curl -sSL -o voice.tgz https://github.com/rhasspy/piper/releases/download/v0.0.2/voice-ru-irinia-medium.tar.gz
  tar xzf voice.tgz
fi

python3 -m piper -m ru-irinia-medium.onnx \
  --length-scale 1.12 --sentence-silence 0.35 --noise-scale 0.5 --noise-w 0.6 \
  -f radio.wav < "$IN"

ffmpeg -loglevel error -y -i radio.wav -af "silenceremove=1:0:-50dB" -b:a 64k "$OUT"
echo "Готово: $OUT"
