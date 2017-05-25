#!/usr/bin/bash
channelList="ytchans.txt"
dbPath="youtubedb.csv"
errordump="yt_errors.txt"
# video ID delimiters
vidDelL="youtube\.com\/watch\?v\="
vidDelR="$"

# for every channel
while read chURL; do
echo "read $chURL"
  # get URLs
  # extract video IDs into an array
  ids=( $( lynx -dump -listonly "$chURL/videos" \
           | grep -oP '(?<=youtube\.com\/watch\?v\=).*' ) )
  # for every video
  for k in ${!ids[@]}; do
    id=${ids[$k]}
    # if not in database, download metadata
    #echo -e "checking $id in $dbPath"
    grep -qs -e "$id" -- "$dbPath" || ( \
      youtube-dl -i --id --skip-download --write-description --write-thumbnail --write-info-json -- "$id" && ( \
        # create database entry
        upload_date=$( grep -m1 -Po -e '(?<=\"upload_date\":\ \").*?(?=\",)' -- $id.info.json )
        title=$( grep -m1 -Po -e '(?<=\"fulltitle\":\ \").*?(?=\",)' -- $id.info.json )
        echo -e "$id;$upload_date;\"$title\"" >> "$dbPath" \
      ) || echo -e "$id" >> "$errordump" \
    )
  done
done < "$channelList"

# sort list
sort -t';' -r -- $dbPath > "$dbPath.temp"
mv "$dbPath.temp" "$dbPath"

# generate page & open
bash './ytsub.sh' && xdg-open './ytsub.html'