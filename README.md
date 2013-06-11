# Scripts for extracting Statistical values from scientific articles 

These scripts use regular expressions to search for and extract a few
key statistics from the raw text of journal articles. Code here is 
provided to accompany the paper titled __Rising complexity and falling 
explanatory power in ecology__, by Etienne Low-Décarie1, Corey Chivers, 
and Monica Granados.

## Usage:

- To use these scripts, you will first need to have all the  articles of
interest as plain text files. If starting with PDF documents, you can 
use [pdftotext](http://linux.die.net/man/1/pdftotext), or some other 
utility.

- Place all `.txt` file in one folder.

- To run, use:

````
$ ./extract_p_F_corr.sh /path/to/folder/with/txt/files
````

- Output files will be placed one folder above the `.txt` files folder.

