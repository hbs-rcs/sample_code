# Batch Job Examples

## Overview

This directory contains several examples of how to use `bsub`, especially from `cron`


## Caution

* Authentication for a user's cron lasts for a limited time, currently based on whether a user was logged in recently on the host with the cron 
* Because BASH scripts can do anything that the user is able to do, be very careful with destructive commands (such as "rm")


## Links

[RCS Running a Program/Submitting a Job](https://www.hbs.edu/research-computing-services/resources/compute-cluster/running-jobs/running-a-program-submitting-a-job.aspx)

[Template for creating an LSF batch script](https://hpc.ncsu.edu/Documents/lsf_template.php)

[Environment variables set for job execution](https://www.ibm.com/docs/en/spectrum-lsf/10.1.0?topic=variables-environment-set-job-execution)

[LSF:Batch Job Files - TAMU HPRC](https://hprc.tamu.edu/wiki/LSF:Batch_Job_Files)

