COLORGOOD=`xgetres *.foreground`
COLORDEG=`xgetres  *.color11`
COLORBAD=`xgetres  *.color9`
COLORSEP=`xgetres  *.color7`

I3STATUSFILE="/home/baroud/.config/i3status/config"

eval sed -i 's/.*color_good.*/color_good=\"$COLORGOOD\"/' $I3STATUSFILE
eval sed -i 's/.*color_degraded.*/color_degraded=\"$COLORDEG\"/' $I3STATUSFILE
eval sed -i 's/.*color_bad.*/color_bad=\"$COLORBAD\"/' $I3STATUSFILE
eval sed -i 's/.*color_separator.*/color_separator=\"$COLORSEP\"/' $I3STATUSFILE
