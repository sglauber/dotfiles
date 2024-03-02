#!/bin/bash

# Function to check if a command exists
has() {
  command -v "$1" >/dev/null 2>&1 || return 1
}

# Function to log messages in red color
error() {
  RED="\033[31m"          # Red color code
  reset_color="\033[0m"   # Reset to normal color

  # Use positional parameters ($@) for all arguments
  echo -e "${RED}[$(date +'%Y-%m-%dT%H:%M:%S')]: ${@} ${reset_color}" >&2
}

# Function to log messages in green color
log() {
  GREEN="\033[32m"        # Green color code
  reset_color="\033[0m"   # Reset to normal color

  echo -e "${GREEN}$@${reset_color}" >&2
}

warn() {
  YELLOW="\033[33m"         # Yellow color code
  reset_color="\033[0m"     # Reset to normal color

  local message=$1
  echo -e "${YELLOW}WARNING: $@${reset_color}" 
}

_handle_files(){
  local filename="$1"
  
  log "unzipping $filename..."
  warn '*.zip file will be removed after extraction'
  unzip "$filename.zip" -x '*Oblique*' -d ${filename} && rm -vr "${filename}.zip"
}

# Function to download fonts
download_font() {
  local filename="$1"
  local download_error_code=0

  log "Downloading $filename"
  wget -q --show-progress "https://github.com/${nf_source}/releases/download/${latest_release}/$filename.zip"

  # Capture the exit code of wget
  download_error_code=$?

  # Check for errors based on the captured code
  if [ "$download_error_code" -ne 0 ]; then
    download_errors+=($filename)

    error "Failed to download $filename (exit code: $download_error_code)"
    return 1
  fi

  # Call _handle_files only if download is successful
  _handle_files "$filename"
}

main() {
	# Fonts to be downloaded
	readonly fonts=('FiraCode' 'Hack' 'Iosevka' 'Meslo' 'Mononoki' 'SourceCodePro' 'VictorMono' 'Terminus' 'JetBrainsMono')

	# Since there might be forks of this project 
	# we define user/repo to easily map these
	nf_source='ryanoasis/nerd-fonts'
	
	# Check for wget
	! has wget && error "Please install wget" && exit 1

	# Check for unzip
	! has unzip && error "Please install unzip" && exit 1

	# Check for jq
	if ! has jq; then
		warn "jq not found, using v2.3.3"
		readonly latest_release='v2.3.3'
	else
		warn "Fetching latest release..."
		readonly latest_release=$(wget -qO- https://api.github.com/repos/${nf_source}/releases | jq -r '.[0].tag_name')
		log "Using ${latest_release}"
	fi

	# Create fonts directory if needed
	mkdir -p ~/.local/share/fonts
	cd ~/.local/share/fonts

	# Download fonts
	download_errors=()
	for filename in "${fonts[@]}"; do
		download_font "$filename" 
	done
	
	# Handle errors and rebuild font cache
	if [[ ${#download_errors[@]} -gt 0 ]]; then
		error_message="Failed to download the following fonts: ${download_errors[@]}"
		error "$error_message"
		warn "Font-cache won't be rebuilt please check the errors"
	else
		log "Rebuilding font cache with fc-cache..."
		fc-cache -f && log "Done!"
	fi

  	exit 0
}

main
