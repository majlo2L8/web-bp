#!/bin/bash
###############################################################################
# Script name           :  beatport.sh
# Description           :  Search lattest releases based on User preferences
# Args                  :  USER ID
# Author                :  Mario Rybar
# E-mail                :  majlo.rybar@gmail.com
# Created               :  11.11.2017
###############################################################################
# Release LOG
# Version:  6.00
# Updated:  28.10.2018
# Notes:    Added releases URL
#           - Line 63: fi replaced by else
#           - URL logging done
#           - Read data from MySQL
###############################################################################
#set -x

  #VARIABLES
  TRACKLOG="/home/bradrs/logs/TRACK1.log"
  RELEASELOG="/home/bradrs/logs/RELEASE1.log"
  LOG="/tmp/bp_match_$(date +"%m%d%Y"%H%M%S).log"
  USER_ID=$1
  # OUT OF Preferences LOOP
  # get lattest batch id and increment by 1
  batch_id=$(sudo mysql -sNe "SELECT DISTINCT(batch_id) FROM reg1.releases ORDER BY batch_id DESC LIMIT 1;")
  actual_batch_id=$(( batch_id + 1))

###############################################################################
#generate prefferences
create_preferences_array() {

  echo -e '#!/bin/bash\n\n##variable\ndeclare -a MYFIELD=(' > /tmp/preferences.sh
  MYSQLPSSWD="parkour2"
  mysql -u"admin" -p"${MYSQLPSSWD}" -sN -e "SELECT artist FROM reg1.pref WHERE user_id = ${USER_ID};" | sed -e 's/^/"/g' | sed -e 's/$/"/g' >> /tmp/preferences.sh
  echo -e ');' >> /tmp/preferences.sh
}

###############################################################################
#Main function
fav_track() {

  # start LOOP cycle
  for i in "${MYFIELD[@]}"
    do
      cat ${TRACKLOG} | grep -i ">$i<" &>1
      if [[ "$?" == 0 ]]; then
        WC=$(cat ${TRACKLOG} | grep -i -B 30 ">$i<" | grep -iPo '(?<=data-ec-name\=\").*(?=\")' | sed -e "s/&#39;/'/g" | sort | uniq | wc -l)
        if [[ `echo "${WC}"` != 0 ]]; then
          TRACK=$(cat ${TRACKLOG} | grep -i -B 30 ">$i<" | grep -iPo '(?<=data-ec-name\=\").*(?=\")' | sed -e "s/&#39;/'/g" | sort | uniq)
          LABEL=$(cat ${TRACKLOG} | grep -i -B 30 ">$i<" | grep -iPo '(?<=data-ec-brand\=\").*(?=\")' | sort | uniq)
          RELEASE=$(cat ${RELEASELOG} | grep -i -B 30 ">$i<" | grep -iPo '(?<=data-ec-name\=\").*(?=\")' | sed -e "s/&#39;/'/g" | sort | uniq)
          RDATE=$(cat ${RELEASELOG} | grep -i -A 10 "$i<" | grep -iPo '(?<=release-released\"\>).*(?=\<)' | sort | uniq)
          partURL=$(cat ${RELEASELOG} | grep -B 10 "$i<" | grep -iPo '(?<=\<a\shref\=\"\/release\/).*(?=\")' | sort | uniq | head -n 1)
          fullURL=$(echo -e "https://www.beatport.com/release/${partURL}")

          # write obtainded data into DB
          echo "INSERT INTO releases VALUES('${actual_batch_id}','${USER_ID}','$i','${RELEASE}','${RDATE}','${LABEL}','${TRACK}','${fullURL}');" | mysql -u"admin" -p"parkour2"

        fi
        ################################################################################################################
      else
        cat ${RELEASELOG} | grep -i ">$i<" &>1
        if [[ "$?" == 0 ]]; then
          LABEL=$(cat ${RELEASELOG} | grep -i -B 30 ">$i<" | grep -iPo '(?<=data-ec-brand\=\").*(?=\")' | sort | uniq)
          RELEASE=$(cat ${RELEASELOG} | grep -i -B 30 ">$i<" | grep -iPo '(?<=data-ec-name\=\").*(?=\")' | sed -e "s/&#39;/'/g" | sort | uniq)
          RDATE=$(cat ${RELEASELOG} | grep -i -A 10 ">$i<" | grep -iPo '(?<=release-released\"\>).*(?=\<)' | sort | uniq)
          partURL=$(cat ${RELEASELOG} | grep -B 10 "$i<" | grep -iPo '(?<=\<a\shref\=\"\/release\/).*(?=\")' | sort | uniq | head -n 1)
          fullURL=$(echo -e "https://www.beatport.com/release/${partURL}")

          # write obtainded data into DB
          echo "INSERT INTO releases VALUES('${actual_batch_id}','${USER_ID}','$i','${RELEASE}','${RDATE}','${LABEL}','${TRACK}','${fullURL}');" | mysql -u"admin" -p"parkour2"
        fi
      fi
  done
}

###############################################################################
#read log
read_log() {

  # GET lattest entries
  mysql -u"admin" -p"XXXXXXX" "SELECT rr.artist AS Artist, rr.release AS Release, rr.date AS Date, rr.label AS Label, rr.tracks AS Tracks, rr.URL AS URL FROM reg1.releses rr WHERE rr.user_id = ${USER_ID} AND rr.batch_id = ${actual_batch_id} ORDER BY rr.artist ASC;"

}

##############################################################################
### MAIN
##############################################################################
  create_preferences_array
  cd /tmp/      # Importing preferences
  . ./preferences.sh

  fav_track     # get_that_music
  read_log      # Wubba Lubba Dub Dub

  exit 0




