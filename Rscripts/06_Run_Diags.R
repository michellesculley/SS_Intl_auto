#' Function to run retrospective analysis, likelihood profiling, and jitter. 
#' 
#' @param root_dir root directory 
#' @param species species to run analyses for
#' @param file_dir name of subdirectory running tests in
#' @param do_retro TRUE run retrospective, FALSE doesn't
#' @param retro_years vector of years to peel back start with 0 and go to negative number of years
#' @param do_profile TRUE to run likelihood profile
#' @param profile string of the parameter to change (can be vector of strings if changing multiple)
#' @param profile.vec vector of 2 containing the spread of the profile range and the units of change over that spread (i.e., a vector of c(2,0.1) would indicate you would like a range of +/- 1 and a step of 0.1 for a total of 20 profiles)
#' @param do_jitter TRUE to run jitter analysis
#' @param Njitter number of jitters to run
#' @param jitterFraction increment of change for each jitter run
#' @param run_parallel TRUE to run diagnostics in parallel for jitter, profiles, and retrospectives
#' @param exe default is "ss", the name of the executable you want to use (do not include .exe in the name)





Run_Diags <- function(model.info,
                      root_dir = NA,
                     file_dir = "base",
                      do_retro = TRUE,
                      retro_years = 0:-5,
                      do_profile = TRUE,
                      profile_name = "SR_LN(R0)",
                      profile.vec = c(2, 0.1),
                      do_jitter = TRUE,
                      Njitter = 100,
                      jitterFraction = 0.1,
                     run_parallel=TRUE,
                     exe= "ss"
                      ){
  require(ggplot2)
  require(reshape2)
  require(parallelly)
  require(future)
    if(do_retro == TRUE){
      message("Running retrospectives")
## this function uses a parallel retrospective function in development for R4ss. The code has been tested and pushed to the main branch of r4ss but hasn't been integrated yet. For now, a local version of the code is used. When the parallel process form retrospectives, jitter, and profiling are in the updated r4ss package, I will update this to use that function instead.
    if(run_parallel){
    source(file.path(root_dir,"Rscripts","parallel_retro.R"))
      source(file.path(root_dir,"Rscripts","parallel_SS_parlines.R"))
    ncores <- parallelly::availableCores() - 1
    future::plan(future::multisession, workers = ncores)
    retro(
    dir = file.path(root_dir,file_dir),
    oldsubdir="",
    newsubdir = "Retrospectives",
    years = retro_years,
    exe=exe
    )
    future::plan(future::sequential)
     }
    else {
      r4ss::retro(dir=file.path(root_dir, file_dir), 
                  oldsubdir="", newsubdir="Retrospectives", years=retro_years, exe = exe)
    }
    
          # Read output
          retroModels <- SSgetoutput(dirvec=file.path(root_dir,file_dir,"Retrospectives", paste("retro",retro_years,sep="")), verbose=FALSE)
          
          # save as Rdata file for ss3diags
          #save(retroModels,file=file.path(dirname.Retrospective,paste0("Retro_",Run,".rdata")))
          
        retroSummary<-SSsummarize(retroModels)  
        MohnsRho<-SShcbias(retroSummary)
        message("Retrospectives Complete")  
        } 
    
    

  
    if(do_profile == TRUE){
      ## Create directory and copy inputs
      dir.profile <- file.path(root_dir, file_dir, paste0(profile_name, "_profile"))
      
      r4ss::copy_SS_inputs(dir.old = file.path(root_dir, file_dir),
                     dir.new = dir.profile,
                     create.dir = TRUE,
                     overwrite = TRUE,
                     recursive = TRUE,
                     use_ss_new = TRUE,
                     copy_exe = TRUE,
                     copy_par = FALSE,
                     dir.exe = file.path(root_dir, file_dir),
                     verbose = TRUE)
      
      # Make changes to starter file
      starter <- r4ss::SS_readstarter(file.path(dir.profile, "starter.ss"))
      starter[["ctlfile"]] <- "control_modified.ss"
      # make sure the prior likelihood is calculated
      # for non-estimated quantities
      starter[["prior_like"]] <- 1
      r4ss::SS_writestarter(starter, dir = dir.profile, overwrite = TRUE)
      
      # make your new control file
      file.copy(file.path(dir.profile,model.info$ctl.file.name),
                file.path(dir.profile, "control_modified.ss"))
                
      
      # vector of values to profile over
      MLEmodel <- SS_output(file.path(root_dir,file_dir), verbose = FALSE, printstats = FALSE)
      profile.MLE<-MLEmodel$parameters %>%
        filter(Label==profile_name) %>%
        pull(Value)
     # Nprofile <- profile.vec[1]
      profile.min<-profile.MLE-(profile.vec[1]/2)*(profile.vec[2])
      profile.max<-profile.MLE+(profile.vec[1]/2)*(profile.vec[2])
      if (run_parallel == TRUE){
        source(file.path(root_dir,"Rscripts","parallel_profile.R"))
        source(file.path(root_dir,"Rscripts","parallel_SS_parlines.R"))
        ncores <- parallelly::availableCores() - 1
        future::plan(future::multisession, workers = ncores)
        prof.table <- profile(
          dir = dir.profile,
          exe = exe,
          oldctlfile = model.info$ctl.file.name,
          newctlfile = "control_modified.ss",
          string = profile_name, 
          profilevec = seq(profile.min,profile.max,profile.vec[2])
        )
        future::plan(future::sequential)
      } else {
      ## Do Profiling
      profile <- profile(
        dir = dir.profile, 
        exe = exe,
        oldctlfile = model.info$ctl.file.name,
        newctlfile = "control_modified.ss",
        string = profile_name,
        profilevec = seq(profile.min,profile.max,profile.vec[2])
      )
      }
        profilemodels<-SSgetoutput(dir=file.path(dir.profile),keyvec=1:(profile.vec[1]+1), verbose=FALSE)
        profilemodels[["MLE"]] <- MLEmodel
        profilesummary <- SSsummarize(profilemodels)
    }
  
 
   if(do_jitter == TRUE){
     
     dir.jitter <- file.path(root_dir, file_dir, "jitter")
     r4ss::copy_SS_inputs(dir.old = file.path(root_dir, file_dir),
                          dir.new = dir.jitter,
                          create.dir = TRUE,
                          overwrite = TRUE,
                          recursive = TRUE,
                          use_ss_new = TRUE,
                          copy_exe = TRUE,
                          copy_par = TRUE,
                          dir.exe = file.path(root_dir, file_dir),
                          verbose = TRUE)
     
     if (run_parallel==TRUE) {
       source(file.path(root_dir,"Rscripts","parallel_jitter.R"))
       source(file.path(root_dir,"Rscripts","parallel_SS_parlines.R"))
       ncores <- parallelly::availableCores() - 1
       future::plan(future::multisession, workers = ncores)
       jit.likes <- jitter(
                   dir = dir.jitter, 
                   Njitter = Njitter,
                   jitter_fraction = jitterFraction, 
                   init_value_src = 1,
                   exe=exe
                   )
        future::plan(future::sequential)
     } else {
     # Step 7. Run jitter using this function (default is nohess)
     jit.likes <- r4ss::jitter(dir=dir.jitter, 
                                     exe = exe,
                               Njitter=Njitter, 
                               jitter_fraction = jitterFraction, 
                               init_values_src = 1)
     
     }
     jittermodels <- SSgetoutput(dirvec = dir.jitter, keyvec = 1:numjitter, getcovar = FALSE)
     jittersummary <- SSsummarize(jittermodels)
     }
}


