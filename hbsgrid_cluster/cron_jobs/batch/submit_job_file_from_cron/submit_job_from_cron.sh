#!/usr/bin/env bash
# submit_job_from_cron.sh
# Harry Levinson, 6/14/2023
 
SCRIPT_PATH="${1}"

# Set up environment when using cron
LSF_BASE=/usr/local/LSF10/10.1/linux3.10-glibc2.17-x86_64
export LSF_SERVERDIR=$LSF_BASE/etc
export LSF_LIBDIR=$LSF_BASE/lib
export LSF_BINDIR=$LSF_BASE/bin
export PATH=$PATH:${LSF_SERVERDIR}:${LSF_BINDIR}
export LSF_ENVDIR=/usr/local/LSF10/conf

${LSF_BINDIR}/bsub < ${SCRIPT_PATH}
