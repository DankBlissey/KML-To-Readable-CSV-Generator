#!/bin/bash
filename=$1

content=$(cat $filename | grep '<tr><td>' | sed 's#<tr><td>##' | sed 's#</td></tr>##' | sed 's#</table>##' | sed 's#<hr>##' | sed 's#<B>##' | sed 's#</B>##' | sed 's#]]>##' | sed 's#Storm Location:##'  | sed 's#Min Sea Level Pressure:##'  | sed 's#Maxium Intensity:##'  | sed 's/\;.*//'  | awk 'NF')
StormLocationData=$(cat $filename | grep '<tr><td>' | sed 's#<tr><td>##' | sed 's#</td></tr>##' | sed 's#</table>##' | sed 's#<hr>##' | sed 's#<B>##' | sed 's#</B>##' | sed 's#]]>##' | grep 'Storm Location:' -A 1 --no-group-separator  | sed 's#Storm Location:##'  | awk 'NF')
echo "$content"



