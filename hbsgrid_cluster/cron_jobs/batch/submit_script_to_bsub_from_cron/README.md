# Submit Script to bsub via cron

## Overview

This approach will let you control all settings in BASH related to running your request with bsub.

This is set up to be called from a regular user's cron, as long as they are on the grid with access to bsub and other lsf commands.


## Files

* submit_script_to_bsub.sh
* sample_02.sh

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

Replace `your_email_here@hbs.edu` with your own HBS email address

```
cd $HOME/cron
./submit_script_to_bsub.sh  sample_02.sh  your_email_here@hbs.edu  long
```

You should see at least one email from LSF.


## Sample crontab

Put your own email address in the command below

Run every 10 minutes:

```
*/10 * * * *   $HOME/cron/submit_script_to_bsub.sh $HOME/cron/sample_02.sh your_email_here@hbs.edu long
```

## How to run the example with cron

* Copy the cron item from example above
* Put your email address in the cron command
* Set the cron time temporarily, to run about a minute from now
* Wait for the cron to run
* You should get at least one email from LSF
* You should see some log files:

```
LOG_FILE="$HOME/cron/logs/${USER}_cron_log.txt"
OUT_FILE="$HOME/cron/logs/${USER}.out"
ERR_FILE="$HOME/cron/logs/${USER}.err"
```
