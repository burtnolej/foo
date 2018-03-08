from __future__ import unicode_literals
import youtube_dl
import sys


ydl_opts = {
    'format': 'bestaudio/best',
    'postprocessors': [{
        'key': 'FFmpegExtractAudio',
        'preferredcodec': 'mp3',
        'preferredquality': '256',
    }],
}

if __name__ == "__main__":
    
    if len(sys.argv) == 1:
        print "provide URL to convert as an argument"
        exit()
    
    with youtube_dl.YoutubeDL(ydl_opts) as ydl:
        ydl.download([sys.argv[1]])