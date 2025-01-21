function validate_url() {
    local url="$1"
    if [[ "$url" =~ ^https?://(www\.)?tiktok\.com/.* ]]; then
        echo "Valid TikTok URL"
        return 0
    else
        echo "Invalid TikTok URL"
        return 1
    fi
}