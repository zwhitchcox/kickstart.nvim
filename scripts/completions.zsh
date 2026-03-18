#compdef opencode-permissions

_opencode-permissions() {
  local -a profiles
  # Get all json files in the profiles directory and strip the .json extension
  if [ -d "$HOME/.config/nvim/scripts/opencode-permission-groups" ]; then
    for file in "$HOME/.config/nvim/scripts/opencode-permission-groups"/*.json; do
      if [ -f "$file" ]; then
        local basename="${file##*/}"
        profiles+=("${basename%.json}")
      fi
    done
  fi
  profiles+=("clear")

  _arguments '*:profile:($profiles)'
}

compdef _opencode-permissions opencode-permissions
