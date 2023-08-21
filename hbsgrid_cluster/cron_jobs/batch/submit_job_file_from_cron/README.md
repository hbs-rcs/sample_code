# Submit bsub Job File via cron

## Overview

This approach will let you create an LSF job file, where you use `#BSUB` directives to set up your request.

This is intended to be called from a regular user's cron, as long as they are on the grid with access to bsub and other lsf commands.


## Files

* submit_job_from_cron.sh
* sample_job_01.sh
* sample_01.sh 
* lsb_env_vars_example.txt

`submit_job_from_cron.sh` is the main program called from `cron`. This is a re-usable launcher that should *not* need modifications per user or per project.

`sample_job_01.sh` is a `bsub` job file, which sets up the job parameters with `#BSUB` directives and a small number of BASH commands at the end

`sample_01.sh` is the program to do the actual work that needs to be done, and is invoked at the bottom of `sample_job_01.sh`


## Limitations

This approach means that you have a more limited set of environment variables available when your job is submitted via `bsub`.

See `lsb_env_vars_example.txt` for a dump of LSB environment variables from a test job -- this will give you an idea of what you may reference from `#BSUB` directives.


## How to install files

* Check out this repo
* On a client machine on the RCS Grid, create a directory if necessary:

```
  mkdir ~/cron
```

* Copy files listed at the top of this README from this repo's directory to `~/cron`
* Make executable:  

```
cd ~/cron
chmod +x *sh
```

## Run example without cron

Your HBS email address will be used automatically, to receive email from LSF

```
cd ~
./cron/submit_job_from_cron.sh  ./cron/sample_job_01.sh
cd cron
ls -al logs
```

You should see at an email from LSF, containing details of your job. The end of the email should confirm where your output and error logs will be.

The output of your program (e.g. `sample_01.sh`) will be in the output file within `logs`, e.g.

`logs/job_1234567.out`



## Sample crontab

Run once a day at 1:15pm:

```
15 13 * * *   $HOME/cron/submit_job_from_cron.sh  $HOME/cron/sample_job_01.sh
```

## How to run the example with cron

* Copy the cron item from example above
* Set the cron time temporarily, to run about a minute from now
* Wait for the cron to run
* You should get at least one email from LSF
* You should see some log files:

```
# If your job id (from LSF email) was 1234567

cd ~/cron
ls -al logs/job_1234567.*
```
