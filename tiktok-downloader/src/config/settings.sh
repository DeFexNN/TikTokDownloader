#!/bin/bash

# Default download directory
DEFAULT_DOWNLOAD_DIR="/workspaces/TikTokDownloader/tiktok-downloader/downloads"

# API keys or tokens (if required)
API_KEY="your_api_key_here"
API_SECRET="your_api_secret_here"

# Telegram bot token
TELEGRAM_TOKEN="8101900575:AAFCC1UxZAyN946qcoeEvZhXM7VuE_UhHNU"

# Function to print current settings
print_settings() {
    echo "Download Directory: $DEFAULT_DOWNLOAD_DIR"
    echo "API Key: $API_KEY"
    echo "API Secret: $API_SECRET"
}