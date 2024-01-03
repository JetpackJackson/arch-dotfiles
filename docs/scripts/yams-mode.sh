#!/usr/bin/env bash

# sway mode script for yambar

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
            echo "mode|string|"
            echo ""
            ;;
        $mon)
            echo "mode|string|mon"
            echo ""
            ;;
        $re)
            echo "mode|string|resize"
            echo ""
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
