#!/usr/bin/bash
htmlPath='ytsub.html'
dbPath='youtubedb.csv.datesort'
urlTemp='https://www.youtube.com/embed/'
#urlTemp='https://www.youtube.com/watch?v='
echo -e "<html>\n<meta charset="utf-8"/>\n<head>\n<title>YouTube UnSubscriptions</title>\n</head>\n<body>\n<table>" > "$htmlPath"

#--sort by date

while read video; do
  id=$( echo "$video" | cut -d';' -s -f1 )
  date=$( echo "$video" | cut -d';' -s -f2 )
  title=$( echo "$video" | cut -d';' -s -f3 )
  link="<a href=\"$urlTemp$id\">"
  echo -e "\t<tr>\n\t\t<td>$link<img src=\"$id.jpg\" width=160 height=90></a></td>\n\t\t<td><h3>$link$title</a></h3><p>$date</p></td>\n\t</tr>" >> "$htmlPath"
done < "$dbPath"

echo -e "</table>\n</body>\n</html>" >> "$htmlPath"

# more "$htmlPath"