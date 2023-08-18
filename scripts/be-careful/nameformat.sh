#/bin/bash
for f in *\ *; do mv "$f" "${f// /_}"; done
for f in *.srt; do mv "$f" "$(echo "$f" | sed s/S2F/s2e/)"; done
for file in Shadow_and_Bone_*.srt ; do mv "$file" "${file#linux_}" ; done

