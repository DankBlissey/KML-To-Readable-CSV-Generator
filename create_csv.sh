#!/bin/bash
filename=$1

content=$(cat $filename | grep '<tr><td>' | sed 's#<tr><td>##' | sed 's#</td></tr>##' | sed 's#</table>##' | sed 's#<hr>##' | sed 's#<B>##' | sed 's#</B>##' | sed 's#]]>##' |  awk 'NF')
echo "$content"

