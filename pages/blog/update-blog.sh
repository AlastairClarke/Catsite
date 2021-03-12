

#!/bin/bash
# update-blog.sh
# PURPOSE: File takes two inputs: name of *.html file being updated and the *.md file being added. The md content becomes a new section with a href added to the top.
# TODO: add tags
# Remember to update the year in Add href date of post

FILE=$1 # file names
ADD=$2 # test.md

# First bit
DATE=`date +"%Y%m%d"`
BCK="./backups/"$DATE"-"$FILE
cp $FILE $BCK # Backup previous post
awk '/DOCTYPE/{a=1};a;/<hr>/{exit}' $FILE > top.html # look for first hr
awk '/<hr>/,/<\/html>/' $FILE > bottom.html # look for most recent post
ID=$DATE"-post"
LINE1="<article id="\"$ID\"">"
LINE2="</article>"
echo $LINE1 >> top.html

# MD bit
pandoc $ADD -o middle.html
sed -i 's:</p>:</p><br>:g' middle.html
cat middle.html >> top.html
echo $LINE2 >> top.html

# Last bit
cat bottom.html >> top.html
cat top.html > $FILE
rm top.html bottom.html middle.html

# Add href date of post
HREF=`awk '/#2021/' $FILE`
NICEDATE=`date +"%dth %B"`
NEW=$HREF" | <a href="\""#"$ID\"">"$NICEDATE"</a>"
sed -i "s:$HREF:$NEW:g" $FILE

# git add
# git commit -m
# git push -u origin master
