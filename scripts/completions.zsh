#compdef opencode-profile

_opencode-profile() {
  local -a profiles
  # Get all json files in the profiles directory and strip the .json extension
  if [ -d "$HOME/.config/nvim/scripts/opencode-profiles" ]; then
    for file in "$HOME/.config/nvim/scripts/opencode-profiles"/*.json; do
      if [ -f "$file" ]; then
        local basename="${file##*/}"
        profiles+=("${basename%.json}")
      fi
    done
  fi
  profiles+=("clear")

  _describe 'command' profiles
}

compdef _opencode-profile opencode-profile
