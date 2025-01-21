#!/bin/bash

# Main script for downloading TikTok videos

# Load configuration settings
source ./config/settings.sh

# Function to download TikTok video
download_video() {
    local url="$1"
    local output_dir="$2"
    
    # Generate a sequential filename
    local count=$(ls "$output_dir" | grep -E '^[0-9]+\.mp4$' | wc -l)
    local filename=$((count + 1)).mp4
    
    # Command to download the video using yt-dlp with a sequential filename
    yt-dlp -o "$output_dir/$filename" "$url"
}

# Main execution
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <TikTok URL>"
    exit 1
fi

URL="$1"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT_DIR="${DEFAULT_DOWNLOAD_DIR:-$SCRIPT_DIR/downloads}"

# Validate the URL
source ./utils/validate.sh
if validate_url "$URL"; then
    download_video "$URL" "$OUTPUT_DIR"
else
    echo "Invalid TikTok URL."
    exit 1
fi