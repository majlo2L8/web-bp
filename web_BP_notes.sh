#############################################################################################################################################
######### BACK END
#############################################################################################################################################

################################################################################
# Create table
CREATE TABLE `releases` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `batch_id` INT,                       # check for last batch_id, increment by 1 and assign to new cliend_id entyr
  `user_id` INT REFERENCES users(id),
  `artist` TEXT,
  `release` TEXT,
  `date` TEXT,
  `label` TEXT,
  `tracks` TEXT,
  `URL` TEXT,
  FOREIGN KEY (user_id) REFERENCES users(id)
);
INSERT INTO `releases` VALUES
  (id,batch_id,user_id,'Current Value','Signal Jam','2018-10-19','Blackout Music NL','Counter Mechanics, Signal Jam','https://www.beatport.com/release/signal-jam/2392725'),
  (id,batch_id,user_id,'Break','Another Way','2018-10-26','Symetry Recordings','Alpha, Conversations feat. MC Fats and Cleveland Watkiss','https://www.beatport.com/release/another-way-album-sampler-2/2407188'),
  (id,${actual_batch_id},${USER_ID},"$i","${RELEASE}","${RDATE}","${LABEL}","${TRACK}","https://www.beatport.com/release/${BPURL}")


################################################################################
# insert into table
INSERT INTO `releases` VALUES
  (1,'Brookes Brothers','Good To Me','Technique Summer 2017','Technique Recordings',2017),
  (2,'Fliwo','Run Away','Technique Summer 2017','Technique Recordings',2017),
  (3,'Muffler','Snowflakes','Technique Summer 2017','Technique Recordings',2017),
  (4,'Tantrum Desire','Gravitate','Technique Summer 2017','Technique Recordings',2017),
  (5,'Salaryman','Roller Forever','Technique Summer 2017','Technique Recordings',2017),
  (6,'Kronology','Star In A Jar','Technique Summer 2017','Technique Recordings',2017),
  (7,'Tapolsky & VovKING','88','Technique Summer 2017','Technique Recordings',2017),
  (8,'T-Base','Through The Night','Technique Summer 2017','Technique Recordings',2017),
  (9,'L-Plus','Going Away','Technique Summer 2017','Technique Recordings',2017);


################################################################################
# READ entry from DB
SELECT
    rr.artist AS Artist,
    rr.release AS Release,
    rr.date AS Date,
    rr.label AS Label,
    rr.tracks AS Tracks,
    rr.URL AS URL
FROM
    reg1.releses rr
WHERE
    rr.user_id = ${USER_ID}
    AND
    rr.batch_id = ${actual_batch_id}
ORDER BY rr.artist ASC;


################################################################################
# ONELINEER
SELECT rr.artist AS Artist, rr.release AS Release, rr.date AS Date, rr.label AS Label, rr.tracks AS Tracks, rr.URL AS URL FROM reg1.releses rr WHERE rr.user_id = "${USER_ID}" AND rr.batch_id = "${actual_batch_id}" ORDER BY rr.artist ASC;


################################################################################
# EXAMPLE OUTPUT
Releases
entry_id | batch_id | user_id | artist | EP | date | label | tracks | URL |


| id | b_id | u_id | artist           | EP          | date       | label               | tracks                                                    | URL
+----+------+------+------------------+-------------+------------+---------------------+-----------------------------------------------------------+----------------
| 1  | 1    | 9    | Current Value    | Signal Jam  | 2018-10-19 | Blackout Music NL   | Counter Mechanics, Signal Jam                             | https://www.beatport.com/release/signal-jam/2392725
| 2  | 1    | 9    | Break            | Another Way | 2018-10-26 | Symmetry Recordings | Alpha, Conversations feat. MC Fats and Cleveland Watkiss  | https://www.beatport.com/release/another-way-album-sampler-2/2407188
| 3  | 1    | 9    | Tantrum Desire   | n\a         | 2018-10-22 | Viper Recordings    | Bloodline Feat. Raphaella (Tantrum Desire Remix)          | https://www.beatport.com/release/bloodline-feat-raphaella-tantrum-desire-remix/2407701
| 4  | 1    | 9    | Brookes Brothers | New Wave    | 2018-10-18 | Breakbeat Kaos      | New Wave feat. Georgia Allen, Tear You Down               | https://www.beatport.com/release/new-wave/2387024
| 5  | 2    | 9    | Memtrix          | Oxidate     | 2018-10-15 | Technique Rec       | track1, track2, memtrixtrack3                             | https://www.beatport.com/release/new-wave/2387024
| 6  | 2    | 9    | Murdock          | test1       | 2018-10-16 | Viper Recordings    | track1, track2, memtrixtrack3                             | https://www.beatport.com/release/new-wave/2387024
| 7  | 2    | 9    | Octo Pi          | octotest2   | 2018-10-17 | rando Recordings    | track1, track2, memtrixtrack3                             | https://www.beatport.com/release/new-wave/2387024
| 8  | 2    | 9    | Logistics        | Logtest1    | 2018-10-18 | RAM Recordings      | track1, track2, memtrixtrack3                             | https://www.beatport.com/release/new-wave/2387024




#############################################################################################################################################
######### FRONT END
#############################################################################################################################################

################################################################################
echo -e "${TRACK}" | sed 's/^/\&emsp;/g'
echo -e "${RELEASE}" | sed 's/^/\&emsp;/g'
echo -e "${RDATE}" | sed 's/^/\&emsp;/g'
echo -e "${LABEL}" | sed 's/^/\&emsp;/g'
################################################################################
echo -e "Artist:&emsp;$i" | sed 's/amp;//g' >> ${LOG}
echo -e "EP:&emsp;&emsp;${RELEASE}" >> ${LOG}
echo -e "Date:&emsp;${RDATE}" >> ${LOG}
echo -e "Label:&emsp;${LABEL}" >> ${LOG}
echo -n "Tracks:&emsp;" >> ${LOG}; echo "${TRACK}" | sed -e 's/^/\t/' >> ${LOG}
################################################################################
echo -e "Artist:&emsp;$i" >> ${LOG}
echo -e "EP:&emsp;&emsp;${RELEASE}" >> ${LOG}
echo -e "Date:&emsp;${RDATE}" >> ${LOG}
echo -e "Label:&emsp;${LABEL}" >> ${LOG}
echo "=============================================" >> ${LOG}
################################################################################
https://stackoverflow.com/questions/38008406/node-js-mysql-display-table-on-html-site
https://www.w3schools.com/tags/tag_tr.asp
################################################################################

RES_COL=80
echo -en \\033[80G
echo -ne "Cyantific:"; echo -ne \\033[30G "[Viper Recordings]"; echo -e \\033[55G "[2018-07-06]"; echo -e \\033[10G "- Hardbody"; echo -e \\033[10G "- Sweet Love Affair (Remixes)"

################################################################################
echo "========================================================================="
echo -ne "Cyantific:"
echo -ne \\033[30G "[${LABEL}]"
echo -e \\033[55G "[${RDATE}]"
echo -e \\033[10G "- Hardbody"
echo -e \\033[10G "- Sweet Love Affair (Remixes)"

################################################################################
# Output
Cyantific: [Viper Recordings] [2018-07-06]
- Hardbody
- Sweet Love Affair (Remixes)
===============================================================================
Cyantific:                    [Viper Recordings]       [2018-07-06]
          - Hardbody
          - Sweet Love Affair (Remixes)


===============================================================================
Monty:                              [Critical Music]       [2018-07-06]
                                    [Vandal Limited]       [2018-07-13]
    - Losing My Soul
    - Ron Millonario

===============================================================================
Intraspekt:                         [Xex Audio]            [2018-07-09]
    - Neighbourhood Watch
    - Shinobi

===============================================================================
Prolix:                             [Bassrush Records]       [2018-07-11]
                                    [Blackout Music NL]      [2018-07-13]
    - Lightspeed

===============================================================================
