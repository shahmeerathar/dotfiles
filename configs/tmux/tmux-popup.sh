current_session="$(tmux display-message -p -F '#{session_name}')"
popup_session="popup-${current_session}"

if [[ "$current_session" == popup-* ]]; then
    tmux detach-client
else
    # Create popup session if it doesn't exist
    if ! tmux has-session -t "$popup_session" 2>/dev/null; then
        tmux new-session -d -s "$popup_session"
        tmux set-option -s -t "$popup_session" key-table popup
        tmux set-option -s -t "$popup_session" status off
        tmux set-option -s -t "$popup_session" prefix None
    fi

    tmux popup -E "tmux attach -t '$popup_session'"
fi
