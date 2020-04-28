## Purpose: Demonstrate parallel computing in R on the compute grid.
## Authors: Ista Zahn
## Updated: April 20th 2020

library(future)

## The future framework is recommended because it is easy to use and allows you
## to mix and match front-ends and back-ends. See
## https://cran.r-project.org/web/packages/future/index.html for more.

## here is a function that draws a sample from the normal distribution and
## calculates the mean

rnmean <- function(x) mean(rnorm(100000, mean = x))
rnmean(1)

#######################
## future front-ends ##
#######################

## Suppose we want to call rnmean with inputs ranging from 1 to 1000. We
## can use sapply, but it is slow:

system.time(sapply(1:1000, rnmean))

## We can speed it up using future_sapply

library(future.apply) ## apply family front-end

plan(multiprocess) ## multiple processes on same machine

system.time(future_sapply(1:1000, rnmean))

## If we prefer to write loops instead of apply we can use the doFuture
## front-end. Note that this will use multiple processes on the same machine
## because plan(multiprocess) is still in effect.

library(doFuture); registerDoFuture() ## foreach-style front-end

system.time(foreach(x=1:1000) %dopar% {rnmean(x)})

## If using multiple cores on the grid is still too slow we can use multiple
## nodes on the compute grid. See https://grid.rcs.hbs.org/ for information.
## NOTE: this will only work on systems (like the HBS grid) with LSF available.

library(future.batchtools)

## Download template to your working directory:

download.file("https://raw.githubusercontent.com/mllg/batchtools/master/inst/templates/lsf-simple.tmpl",
              "lsf-simple.tmpl")

## Plan to use lsf (note that walltime is in seconds)
plan(batchtools_lsf,
     template = "lsf-simple.tmpl",
     resources = list(walltime = 120, memory = "500M", queue = "short"),
     workers = 10)

## Use same code as before, but now runs on LSF nodes instead of local CPU
## cores!
system.time(future_sapply(1:1000, rnmean))

