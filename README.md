# mtDNA_assembler

This a working repository for development of a Python wrapper script to automate assembly of mtDNA genomes from off target reads in hybridization capture experiments. Currently, it also includes a shell script for the same purpose.

### Contents

**Script:** mtDNA_assembler.sh  
**Description:**  This script should search for mtDNA reads, create a seed file, and start a PRICE assembly of mtDNA genomes
**Requires:** [blatq](https://github.com/calacademy-research/BLATq); [excerptByIDs](https://github.com/calacademy-research/excerptByIDs)(Go programming language must be installed to run); [Price](http://derisilab.ucsf.edu/software/price/); [SPAdes](http://bioinf.spbau.ru/spades)
**Authorship:** Originally Jack Dumbacher; modified and annotated by Ethan Linck  

#### Usage
To begin, you'll need...  
* A reference mtDNA genome of your organism or a close relative (here `t_sanctus.fasta`)...
* Forward (`EL_hyRAD_001A_S29_1`), reverse (`EL_hyRAD_001A_S29_2`), and unpaired (`EL_hyRAD_001A_S29_u`) reads from a single sample...
* All required programs installed and working
* An edited version of mtDNA_assembler.sh with correct sample IDs and paths for your own system, and correct parameters for the PRICE assembler (see documentation [here](http://derisilab.ucsf.edu/software/price/)). 
  
Then, simply execute the script:  
   
```{sh}
$ bash mtDNA_assembler.sh
```
  
The script will proceed through four steps:
  
1. blatq will search for reads that align with your reference mtDNA genome and create a list of matching `.fastq` IDs;
2. excerptByIDs will take this list, extract matching sequences, and collate them into seeds;
3. SPAdes will run an initial assembly on these seeds to increase downstream efficiency;
4. The PRICE assembler will iteratively map reads to the edge of seeds and then contigs, merging identical sequences.
  
Ultimately, this should output a `.fasta` for each cycle, with the terminal cycle representing the most complete assembly (e.g., `EL_hyRAD_001A_mtDNA.cycle30.fa`).  
  
**Script:** mtDNA_assembler.py   
**Description:** A work in progress...