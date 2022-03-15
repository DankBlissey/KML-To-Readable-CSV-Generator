#!/bin/bash

#sets variables for the file arguments to read and write
filename=$1
outputname=$2

#takes file contents, greps only the relevant data area then trims all the extra metadata and kml formatting as well as the titles declaring what each value is. Then adds newlines at the end of knots so that each line of data is defined
content=$(cat $filename | grep '<tr><td>' | sed 's#<tr><td>##' | sed 's#</td></tr>##' | sed 's#</table>##' | sed 's#<hr>##' | sed 's#<B>##' | sed 's#</B>##' | sed 's#]]>##' | sed 's#Storm Location:##'  | sed 's#Min Sea Level Pressure:##'  | sed 's#Maxium Intensity:##'  | sed 's/\;.*//' | sed 's#.*(.*##' | awk 'NF' | xargs | sed 's#knots #knots\n#g')

#outputs to the file the first line of the collumn names
echo "Timestamp,Latitude,Longitude,MinSeaLevelPressure,MaxIntensity" > $outputname

#writes content to a text file so that the while loop functions as it needs a file to work with
echo "$content" > MidWayFile.txt

#while loop reads each line of content and writes it to the file, then pipes reformat the commas in the right places and removes the spaces at the end of the commas, finally output is written to the output file without overwriting the collumn names from before
input="MidwayFile.txt"
while IFS= read -r line
do
	echo "$line"
done < "$input" | awk '{$4=$4","}1' | awk '{$10=$10","}1' | awk '{$8=$8","}1' | sed 's#, #,#g' >> $outputname

