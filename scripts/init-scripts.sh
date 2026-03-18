#!/bin/bash

# Define paths
NVIM_DIR="$HOME/.config/nvim"
SCRIPTS_DIR="$NVIM_DIR/scripts"
LOCAL_BIN="$HOME/.local/bin"

echo "🚀 Initializing custom Neovim & Opencode scripts..."

# Ensure ~/.local/bin exists
if [ ! -d "$LOCAL_BIN" ]; then
	echo "Creating $LOCAL_BIN directory..."
	mkdir -p "$LOCAL_BIN"
fi

# Function to safely install/update a script via symlink
install_script() {
	local script_name=$1
	local source_path="$SCRIPTS_DIR/$script_name"
	local dest_path="$LOCAL_BIN/$script_name"

	if [ -f "$source_path" ]; then
		echo "Linking $script_name -> $LOCAL_BIN"
		# Make sure the source is executable
		chmod +x "$source_path"
		# Force create a symbolic link (updates it if it already exists)
		ln -sf "$source_path" "$dest_path"
	else
		echo "⚠️  Warning: $source_path does not exist!"
	fi
}

# Install all specific scripts here
install_script "opencode-permissions"
install_script "opencode-show-active-permissions"

# Link global opencode.json config
echo "Linking opencode.json -> ~/.config/opencode/opencode.json"
mkdir -p "$HOME/.config/opencode"
ln -sf "$NVIM_DIR/opencode.json" "$HOME/.config/opencode/opencode.json"

# Set up zsh completion
ZSHRC="$HOME/.zshrc"
COMPLETION_SOURCE="source $SCRIPTS_DIR/completions.zsh"

if [ -f "$ZSHRC" ]; then
	if ! grep -q "$COMPLETION_SOURCE" "$ZSHRC"; then
		echo "Adding zsh completion for opencode-profile to .zshrc..."
		echo "" >>"$ZSHRC"
		echo "# Opencode Profile Completions" >>"$ZSHRC"
		echo "$COMPLETION_SOURCE" >>"$ZSHRC"
	else
		echo "zsh completion is already installed in .zshrc"
	fi
fi

# (If you add more scripts to ~/.config/nvim/scripts later,
#  you can just add another install_script line here!)

echo ""
echo "✅ Initialization complete!"
echo "   Your scripts are now available globally in $LOCAL_BIN"
echo "   (Make sure $LOCAL_BIN is in your PATH)"
