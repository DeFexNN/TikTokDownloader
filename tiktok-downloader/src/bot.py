import os
import subprocess
from telegram import Update
from telegram.ext import Application, CommandHandler, MessageHandler, filters, CallbackContext

# Load configuration settings
DEFAULT_DOWNLOAD_DIR = "/workspaces/TikTokDownloader/tiktok-downloader/downloads"
TELEGRAM_TOKEN = "8101900575:AAFCC1UxZAyN946qcoeEvZhXM7VuE_UhHNU"

def start(update: Update, context: CallbackContext) -> None:
    update.message.reply_text('Send me a TikTok URL and I will download the video for you.')

def download_tiktok(update: Update, context: CallbackContext) -> None:
    url = update.message.text
    if validate_url(url):
        filename = download_video(url)
        if filename:
            update.message.reply_video(video=open(filename, 'rb'))
        else:
            update.message.reply_text('Failed to download the video.')
    else:
        update.message.reply_text('Invalid TikTok URL.')

def validate_url(url: str) -> bool:
    return url.startswith("https://www.tiktok.com/")

def download_video(url: str) -> str:
    output_dir = DEFAULT_DOWNLOAD_DIR
    count = len([name for name in os.listdir(output_dir) if name.endswith('.mp4')])
    filename = os.path.join(output_dir, f"{count + 1}.mp4")
    
    result = subprocess.run(['yt-dlp', '-o', filename, url], capture_output=True, text=True)
    if result.returncode == 0:
        return filename
    else:
        print(result.stderr)
        return None

def main() -> None:
    application = Application.builder().token(TELEGRAM_TOKEN).build()

    application.add_handler(CommandHandler("start", start))
    application.add_handler(MessageHandler(filters.TEXT & ~filters.COMMAND, download_tiktok))

    application.run_polling()

if __name__ == '__main__':
    main()
