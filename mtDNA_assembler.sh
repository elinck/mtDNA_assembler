#!/bin/sh

#### mtDNA_assembler.sh: a shell script for automating assembly of mtDNA genomes from off-target reads in hybridization capture experiments
# Authorship: J. Dumbacher; modified by E. Linck
# Description: this script should search for mtDNA reads, create a seed file, and start a PRICE assembly of mtDNA genomes
# Requirements: blatq (https://github.com/calacademy-research/BLATq); (https://github.com/calacademy-research/excerptByIDs; requires Go language installed);
#				Price (http://derisilab.ucsf.edu/software/price/); SPAdes (http://bioinf.spbau.ru/spades)
# Useage: 1. Edit paths for forward, reverse, and unpaired read IDs for one sample throughout script
#         	 (Here, they're EL_hyRAD_001A_S29_1; EL_hyRAD_001A_S29_2; EL_hyRAD_001A_S29_u)
#		  2. Edit paths for blatq, excerptByIDs, PriceTI, and SPAdes if not in $PATH
# 		  3. $ bash mtDNA_assembler.sh


# 1. Use blatq to search for reads of mtDNA: 

echo "$@"_starting blatq search to pull seeds for PRICE

blatq -t=dna /home/elinck/syma_mitogenomes/t_sanctus_ref.fasta /home/elinck/syma_mitogenomes/data/EL_hyRAD_001A_S29_1_final.fq /home/elinck/syma_mitogenomes/blast/EL_hyRAD_001A_S29_1_matches.m8 -out=blast8

blatq -t=dna /home/elinck/syma_mitogenomes/t_sanctus_ref.fasta /home/elinck/syma_mitogenomes/data/EL_hyRAD_001A_S29_2_final.fq /home/elinck/syma_mitogenomes/blast/EL_hyRAD_001A_S29_2_matches.m8 -out=blast8

blatq -t=dna /home/elinck/syma_mitogenomes/t_sanctus_ref.fasta /home/elinck/syma_mitogenomes/data/EL_hyRAD_001A_S29_u_final.fq /home/elinck/syma_mitogenomes/blast/EL_hyRAD_001A_S29_u_matches.m8 -out=blast8

echo "$@" Blatq done

# 2. Excerpt reads by ID:

echo "$@"Now starting to excerpt reads with blatq hits by ID

/data/jdumbacher/bin/excerptByIDs /home/elinck/syma_mitogenomes/blast/EL_hyRAD_001A_S29_1_matches.m8 /home/elinck/syma_mitogenomes/data/EL_hyRAD_001A_S29_1_final.fq > /home/elinck/syma_mitogenomes/blast/EL_hyRAD_001A_S29_1_final_matches.fq

/data/jdumbacher/bin/excerptByIDs /home/elinck/syma_mitogenomes/blast/EL_hyRAD_001A_S29_2_matches.m8 /home/elinck/syma_mitogenomes/data/EL_hyRAD_001A_S29_2_final.fq > /home/elinck/syma_mitogenomes/blast/EL_hyRAD_001A_S29_2_final_matches.fq

/data/jdumbacher/bin/excerptByIDs /home/elinck/syma_mitogenomes/blast/EL_hyRAD_001A_S29_u_matches.m8 /home/elinck/syma_mitogenomes/data/EL_hyRAD_001A_S29_u_final.fq > /home/elinck/syma_mitogenomes/blast/EL_hyRAD_001A_S29_u_final_matches.fq

echo "$@"done Excerpting reads...

cat  /home/elinck/syma_mitogenomes/blast/EL_hyRAD_001A_S29_1_final_matches.fq /home/elinck/syma_mitogenomes/blast/EL_hyRAD_001A_S29_2_final_matches.m8 /home/elinck/syma_mitogenomes/blast/EL_hyRAD_001A_S29_u_final_matches.m8 > /home/elinck/syma_mitogenomes/assemblies/EBL001A_SEEDS.fastq

echo "$@"Number of seeds in seed file, /home/elinck/syma_mitogenomes/assemblies/EBL001A_SEEDS.fastq

grep -c "@" /home/elinck/syma_mitogenomes/assemblies/EBL001A_SEEDS.fastq

# 3. For larger read sets, assemble initial reads using spades:

echo "$@"Now starting SPAdes assembly...

python /data/jdumbacher/SPAdes-3.9.0-Linux/bin/spades.py --careful -s /home/elinck/syma_mitogenomes/assemblies/EBL001A_SEEDS.fastq -o /home/elinck/syma_mitogenomes/assemblies/EBL001A_SEEDS_assembled

# 4. Assemble mtDNA using PRICE

echo "$@"Now starting PRICE assembly...

PriceTI -fp /home/elinck/syma_mitogenomes/data/EL_hyRAD_001A_S29_1_final.fq /home/elinck/syma_mitogenomes/data/EL_hyRAD_001A_S29_2_final.fq 235 -icf /home/elinck/syma_mitogenomes/assemblies/EBL001A_SEEDS.fastq 1 1 5  -mol 30 -mpi 90 -MPI 85 -nc 30 -a 8 -target 85 1 1 1 -o /home/elinck/syma_mitogenomes/assemblies/EL_hyRAD_001A_mtDNA.fa -o /home/elinck/syma_mitogenomes/assemblies/EL_hyRAD_001A_mtDNA.priceq -maxHp 25 -logf /home/elinck/syma_mitogenomes/assemblies/EL_hyRAD_001A_mtDNA.log
