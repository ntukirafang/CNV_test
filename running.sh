#!/bin/bash
#Usage : Before run this code, you need to adjust your bam file and bai file to 1._control.bam/_control.bai 2._test.bam/_test.bai
#bash running.sh (after that enter gene which you are interested in)
read -p "Folder_name :" Folder_name
echo $Folder_name
mkdir /mnt/CNV_test/CNV_test/$Folder_name
python search_gene_position.py
cp ' compare.csv' /mnt/CNV_test/CNV_test/$Folder_name/compare.csv
cp ' resulttable.csv' /mnt/CNV_test/CNV_test/$Folder_name/resultable.csv
