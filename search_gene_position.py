#!/usr/bin/python
import io
import os
import sys
import requests
import traceback
import pandas as pd
#import docx
#from docx import Document
bed_file = pd.read_csv('total_empty.bed', delimiter = "\t")
gene_name = input('Please enter a gene what you are interested in:')
print(gene_name)
os.system("echo "+gene_name+" > gene_name")
real_gene_name = "\t"+gene_name+"."
print(real_gene_name)
def search_string_in_file(file_name, string_to_search):
    line_number = 0
    list_of_results = []
    with open(file_name, 'r') as read_obj:
        for line in read_obj:
            line_number += 1
            if string_to_search in line:
                list_of_results.append((line_number, line.rstrip()))
    return list_of_results
matched_lines = search_string_in_file('total_empty.bed',real_gene_name)
print('Total Matched lines:', len(matched_lines))
print('matched_line : ',matched_lines)
os.system("rm test.bed")
for elem in matched_lines:
    print('Line Number', elem[0], ':: Line = ', elem[1])
    os.system("echo "+str(elem[1])+" | sed 's/ /\t/g' >> test.bed")
    last_line = len(matched_lines)
    os.system("echo "+str(last_line)+" > last_line")
os.system("Rscript test.r")

~                                             
