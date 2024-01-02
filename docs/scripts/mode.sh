#!/usr/bin/env bash
def=$(cat << 'EOF'
{
  "name": "default"
}
EOF
)
mon=$(cat << 'EOF'
{
  "name": "mon"
}
EOF
)
re=$(cat << 'EOF'
{
  "name": "resize"
}
EOF
)

while true; do
    mode="$(swaymsg -t get_binding_state)"
    case "$mode" in
        $def)
            echo def
            ;;
        $mon)
            echo mon
            ;;
        $re)
            echo re
            ;;
    esac
    sleep 1

#    if [[ "$mode" == "$def" ]]
#    then
#        echo "def"
#    fi
#    if [[ "$mode" == "" ]]
#    then
#        echo "mon"
#    fi

done
