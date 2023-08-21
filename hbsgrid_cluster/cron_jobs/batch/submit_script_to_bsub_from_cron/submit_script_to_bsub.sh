#!/usr/bin/env bash
# submit_script_to_bsub.sh
#
# Runs specified script by submitting to bsub with given queue.
# Emails user at start of job
# Uses "long" queue by default
# Logs request, and also standard output and error
# 
# Harry Levinson, 6/14/23
# --------------------------
#
# Usage:
# ./submit_script_to_bsub.sh <script> <email_address> <queue_name> 
#
# 1. Copy this file to "submit_script_to_bsub.sh" in $HOME/cron/submit_script_to_bsub.sh
# 2. Decide which queue you need
# 3. Run:
#    $HOME/cron/submit_script_to_bsub.sh /path/to/your/script.sh <email> <queue_name>
#
# Example:
# You can run it this way interactively
# ./submit_script_to_bsub.sh /export/home/itg/hlevinson/cron/sample_02.sh hlevinson@hbs.edu short
#
# Or if installed in home directory, from cron (e.g. at 1:15pm ET)
# 15 13 * * *	$HOME/cron/submit_script_to_bsub.sh $HOME/cron/sample_02.sh example@hbs.edu long
# 
#
# Not yet implemented:
#   cpu count as input
#   -We 02                # Runtime in [HH:]MM
#   -R "rusage[mem=1000]" # Memory reservation for the job

SCRIPT_PATH="${1}"
EMAIL="${2}"
QUEUE="${3}"

# Create ISO 8601 timestamp
TS=$(date +'%Y-%m-%dT%H:%M:%SZ')

LOG_FILE="$HOME/cron/logs/${USER}_cron_log.txt"
OUT_FILE="$HOME/cron/logs/${USER}.out"
ERR_FILE="$HOME/cron/logs/${USER}.err"

# TODO scan user script for safety
# TODO deal with auth token handling

if [[ ! -f "$SCRIPT_PATH" ]]; then
	echo "Script not found:  $SCRIPT_PATH" >> "${ERR_FILE}"
	exit 0
fi

if [[ -z "${QUEUE}" ]]; then
	QUEUE="long"
fi


# Set up environment when using cron
LSF_BASE=/usr/local/LSF10/10.1/linux3.10-glibc2.17-x86_64
export LSF_SERVERDIR=$LSF_BASE/etc
export LSF_LIBDIR=$LSF_BASE/lib
export LSF_BINDIR=$LSF_BASE/bin
export PATH=$PATH:${LSF_SERVERDIR}:${LSF_BINDIR}
export LSF_ENVDIR=/usr/local/LSF10/conf

DIR="$(dirname "${LOG_FILE}")"
if [[ ! -d $DIR ]]; then
	mkdir -p $DIR
fi

# -B = email at start of job
# -N = job report sent by email

REQUEST="${LSF_BINDIR}/bsub -B -u ${EMAIL} -n 1 -q ${QUEUE} -o ${OUT_FILE} -e ${ERR_FILE} ${SCRIPT_PATH} "
REQUEST="$REQUEST  > ${OUT_FILE} 2> ${ERR_FILE}"

# Log the request with a timestamp at the front
echo "${TS} ${EMAIL} ${REQUEST}" >> "${LOG_FILE}"

# Run the request
eval "${REQUEST}"
