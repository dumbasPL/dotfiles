export PATH="$HOME/.local/bin:$PATH"

export npm_config_prefix="$HOME/.local"

if [ -d "$HOME/esp" ]; then
    alias get_idf='. $HOME/esp/esp-idf/export.sh'
fi

if [ -d "$HOME/.deno" ]; then
    . "$HOME/.deno/env"
fi