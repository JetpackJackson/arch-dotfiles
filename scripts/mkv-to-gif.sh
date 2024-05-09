#!/usr/bin/env bash
ffmpeg -y -i "$1" -filter_complex "fps=15,split[v1][v2]; [v1]palettegen=stats_mode=full [palette]; [v2][palette]paletteuse=dither=sierra2_4a" -vsync 0 "${1%.*}.gif"
#for i in *.mkv; do ffmpeg -y -i "$1" -filter_complex "fps=15,split[v1][v2]; [v1]palettegen=stats_mode=full [palette]; [v2][palette]paletteuse=dither=sierra2_4a" -vsync 0 "${i%.*}.gif"; done
