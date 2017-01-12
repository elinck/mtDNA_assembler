#!/usr/bin/python

# this is not currently functional, and serving as an exercise to teach myself python

# import required libraries
import numpy
import string
import stdlib
import subprocess

# set up arguments
def get_args():
	"""Get arguments from CLI"""
	parser = argparse.ArgumentParser(
		description="""Assembly mtDNA genomes using Price"""
	)
	parser.add_argument(
		"--dir"
		required=True,
		default=None,
		help="""The directory where raw reads for each sample is stored"""
	)
	parser.add_argument(
		"--ref"
		required=True,
		default=None,
		help="""A .fasta file of a closely-related mtDNA genome"""
	)
	return parser.parse_args()

# define function to run blatq
def run_blatq(ref, reads, output):

# define function to run extractbyIds
def run_extractbyIDs():

# define function to run PRICE assembler
def run_price_assembler():  
		
# define main function
def main():

	

		