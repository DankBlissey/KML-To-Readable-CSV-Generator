#!/bin/bash
filename=$1
outputname=$2

content=$(cat $filename | grep '<tr><td>' | sed 's#<tr><td>##' | sed 's#</td></tr>##' | sed 's#</table>##' | sed 's#<hr>##' | sed 's#<B>##' | sed 's#</B>##' | sed 's#]]>##' | sed 's#Storm Location:##'  | sed 's#Min Sea Level Pressure:##'  | sed 's#Maxium Intensity:##'  | sed 's/\;.*//' | sed 's#.*(.*##' | awk 'NF' | xargs | sed 's#knots #knots\n#g')
echo "Timestamp,Latitude,Longitude,MinSeaLevelPressure,MaxIntensity" > $outputname
echo "$content" > MidWayFile.txt
input="MidwayFile.txt"
while IFS= read -r line
do
	echo "$line"
done < "$input" | awk '{$4=$4","}1' | awk '{$10=$10","}1' | awk '{$8=$8","}1' | sed 's#, #,#g' >> $outputname

