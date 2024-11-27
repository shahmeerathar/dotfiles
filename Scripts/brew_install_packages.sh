BREW_FORMULAE="$HOME/.brew_formulae"
if [ ! -f "$BREW_FORMULAE" ]; then
    echo "'$BREW_FORMULAE' not found."
    exit 1
fi

echo "'$BREW_FORMULAE' found."
xargs brew install < "$BREW_FORMULAE"
