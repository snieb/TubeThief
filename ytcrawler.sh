#!/usr/bin/bash
channelList="ytchans.txt"
dbPath="youtubedb.csv"
subExp="subscription_manager"
errordump="yt_errors.txt"
# video ID delimiters
vidDelL="youtube\.com\/watch\?v\="
vidDelR="$"

# for every channewget pipe bashl
#while read chURL; do
  chURL='https://www.youtube.com/feeds/videos.xml?channel_id=UCrMePiHCWG4Vwqv3t7W9EFg'
  echo "READING: $chURL"
  # get URLs
  # extract video IDs into an array
  
  entries=( $( wget -qO - -- "$chURL" \ # get feed
               | tr -d '\n' \ # remove newlines
               | grep -Po -e '<entry>.*?</entry>'
              ) )
#done < "$channelList"

# sort list
#sort -t';' -r -- $dbPath > "$dbPath.temp"
#mv "$dbPath.temp" "$dbPath"

# generate page & open
#bash './ytsub.sh' && xdg-open './ytsub.html'