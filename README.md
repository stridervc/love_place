Uses Love2D to draw Reddit's /r/place 

Using
=====
You'll need the data of /r/place.
It can be found at https://www.reddit.com/r/redditdata/comments/6640ru/place_datasets_april_fools_2017/
Download the full dataset. Currently this is sorted by color, not timestamp though.
To sort the data on Linux, first remove the first line from the data, this is just a header.
Then run: cat tile_placements.csv | sort --field-separator=',' --key=1 > sorted.csv

Once this is done, run love . in the current directory.

There is currently very little error checking. If sorted.csv doesn't exist, the program will not work.

It will take a long time to run. You can tweak the for loop in love.update to make it quicker. The more lines that are read from the data file during each update, the quicker the display will change.

