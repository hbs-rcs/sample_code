#!/usr/bin/env bash
# sample_job_01.sh
# Harry Levinson, 6/14/2023

# Use bsub commands only in this file, except for end

# Log file paths are relative to current directory, 
# where this script is, or absolute path, no variables
# %J will be batch job ID

#BSUB -o cron/logs/job_%J.out
#BSUB -e cron/logs/job_%J.err

# User job control settings ###########

# If not an HBS email address, change line below
#BSUB -u $LSB_JOB_EXECUSER@hbs.edu

#BSUB -N			# enable email notifications when the job finishes
#BSUB -q long			# queue
#BSUB -n 2			# number of cores

#BSUB -We 02			# Maximum runtime in [HH:]MM
#BSUB -R "rusage[mem=1000]" 	# Memory reservation for the job, min MB for job to run
#BSUB -M 2000			# Upper memory limit, max MB; job cancelled if exceeded

# User program area ###############
# Set up logs directory
cd ~
pwd
mkdir -p ~/cron/logs > /dev/null 2>&1

# Uncomment to see what environment variables are there while bsub job runs
#env | grep LSB

# User program to run
$HOME/cron/sample_01.sh

