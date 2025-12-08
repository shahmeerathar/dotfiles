# Get all session names
sessions=$(tmux list-sessions -F '#{session_name}')

# Find popup sessions and check if parent exists
echo "$sessions" | grep '^popup-' | while read -r popup; do
    parent="${popup#popup-}"
    if ! echo "$sessions" | grep -qx "$parent"; then
        tmux kill-session -t "$popup" 2>/dev/null
    fi
done
