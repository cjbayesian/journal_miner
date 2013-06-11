# Scripts for extracting statistical values from scientific journal articles 

These scripts use regular expressions to search for and extract a few
key statistics from the raw text of journal articles. Code here is 
provided to accompany the paper titled __Rising complexity and falling 
explanatory power in ecology__, by Etienne Low-Décarie, Corey Chivers, 
and Monica Granados.

## Requirements:

The script files are writen in BASH, so a \*nix like environment is 
assumed. They should run on OSX, however they have only been tested
on Ubuntu 12.04.

## Usage:

1. To use these scripts, you will first need to have all the  articles of
interest as plain text files. If starting with PDF documents, you can 
use [pdftotext](http://linux.die.net/man/1/pdftotext), or some other 
utility.

2. Place all `.txt` file in one folder.

3. To run, use:

````
$ ./extract_p.sh /path/to/folder/with/txt/files
````

Output files will be placed one folder above the `.txt` files folder. Outputs
are csv files containing a list of all extracted values, one per line with the 
associated file name from which each was extracted.


