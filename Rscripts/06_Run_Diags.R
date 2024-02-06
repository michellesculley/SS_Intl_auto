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




Run_Diags <- function(root_dir = NA,
                     file_dir = "base",
                      do_retro = TRUE,
                      retro_years = 0:-5,
                      do_profile = TRUE,
                      profile = "SR_LN(R0)",
                      profile.vec = c(2, 0.1),
                      do_jitter = TRUE,
                      Njitter = 100,
                      jitterFraction = 0.1
                      ){
  require(ggplot2)
  require(reshape2)
  if(do_retro == TRUE){
    source(file.path(root_dir,"Rscripts","r4ss_retros.R"))
    dirname.base = file.path(root_dir, file_dir)
    #  file.path(current.dir,"Diagnostics","Retros")
    
    # Names of DAT and CONTROL files
    DAT = model.info$data.file.name
    CTL =  model.info$ctl.file.name
    
    # # Step 2. Identify the directory where a completed model run is located
    dirname.completed.model.run <- dirname.base
    # dirname.completed.model.run
    # 
    # # Step 3. Create a subdirectory for the Retrospectives
    dirname.Retrospective <- file.path(root_dir,file_dir,"Retros")
    dir.create(file.path(root_dir,file_dir,"Retros"), showWarnings = TRUE)
    setwd(dirname.Retrospective)
    # 
    #
   # # Step 4.
      #----------------- copy model run files ----------------------------------------
      file.copy(paste(dirname.completed.model.run,       "starter.ss_new", sep="/"),
                paste(dirname.Retrospective, "starter.ss", sep="/"))
      file.copy(paste(dirname.completed.model.run,       "control.ss_new", sep="/"),
                paste(dirname.Retrospective, CTL, sep="/"))
      file.copy(paste(dirname.completed.model.run,       "data_echo.ss_new", sep="/"),
                paste(dirname.Retrospective, DAT, sep="/"))	
      file.copy(paste(dirname.completed.model.run,       "forecast.ss", sep="/"),
                paste(dirname.Retrospective, "forecast.ss", sep="/"))
      file.copy(paste(dirname.completed.model.run,       "SS.exe", sep="/"),
                paste(dirname.Retrospective, "ss.exe", sep="/"))
      file.copy(paste(dirname.completed.model.run,       "ss.par", sep="/"),
                paste(dirname.Retrospective, "ss.par", sep="/"))
      #  file.copy(paste(dirname.completed.model.run,       "wtatage.ss", sep="/"),
      #            paste(dirname.Retrospective, "wtatage.ss", sep="/"))
      # 
      # #------------Make Changes to the Starter.ss file (DC Example) ------------------------------- 
      starter <- readLines(paste(dirname.Retrospective, "/starter.ss", sep=""))
      # # 
      # # # 1) Starter File changes to speed up model runs
      # # # Run Display Detail
      # [8] "2 # run display detail (0,1,2)" 
      linen <- grep("# run display detail", starter)
      starter[linen] <- paste0( 1 , " # run display detail (0,1,2)" )
      write(starter, paste(dirname.Retrospective, "starter.ss", sep="/"))
      # # 
      # #------------ r4SS retrospective calculations------------------------------- 
      # 
      # # Step 5. Run the retrospective analyses with r4SS function "retro"
      # # Here Switched off Hessian extras "-nohess" (much faster)
      # 
      retro(dir=dirname.Retrospective, oldsubdir="", newsubdir="", years=retro_years,exe="ss",extras = "-nohess")
     
          # Step 6. Read "SS_doRetro" output
          retroModels <- SSgetoutput(dirvec=file.path(dirname.Retrospective, paste("retro",retro_years,sep="")), verbose=FALSE)
          
          # Step 7. save as Rdata file for ss3diags
          #save(retroModels,file=file.path(dirname.Retrospective,paste0("Retro_",Run,".rdata")))
          
          
          ## plot your results
          retroSummary <- SSsummarize(retroModels, verbose=FALSE)
          endyrvec <- retroSummary$endyrs + retro_years
          
          
          SummaryBio<-retroSummary$SpawnBio
          names(SummaryBio)<-c(paste0("retro",retro_years),"Label","Yr")
          SummaryBio<-reshape2::melt(SummaryBio,id.vars=c("Label","Yr"))
          SummaryBio<-subset(SummaryBio,Yr>=model.info$startyear)
          RemoveVector<-c(which(SummaryBio$variable=="retro-1"&SummaryBio$Yr==model.info$endyear),which(SummaryBio$variable=="retro-2"&SummaryBio$Yr>=model.info$endyear-1),which(SummaryBio$variable=="retro-3"&SummaryBio$Yr>=model.info$endyear-2),which(SummaryBio$variable=="retro-4"&SummaryBio$Yr>=model.info$endyear-3),which(SummaryBio$variable=="retro-5"&SummaryBio$Yr>=model.info$endyear-4))
          SummaryBio<-SummaryBio[-RemoveVector,]
          
          Retro_Bio<-ggplot() +
            geom_line(aes(x=Yr,y=value,color=variable),data=SummaryBio, linewidth=1) +
            theme(panel.border = element_rect(color="black",fill=NA,linewidth=1),
                  panel.background = element_blank(), strip.background = element_blank(),
                  legend.position = "none") +
            scale_color_manual(values = c("black","red","orange","yellow","green","blue","black")) + xlab("Year") + ylab("Spawning Biomass (mt)") +
            geom_line(aes(x=Yr,y=value),data=subset(SummaryBio,variable=="retro0"),color="black", linewidth=1.25)
          
     
          
          ### Other figures using SPR not F
          SPR<-retroSummary$SPRratio
          names(SPR)<-c(paste0("retro",retro_years),"Label","Yr")
          SPR<-reshape2::melt(SPR,id.vars=c("Label","Yr"))
          SPR<-subset(SPR,Yr>=model.info$startyear)
          RemoveVector<-c(which(SPR$variable=="retro-1"&SPR$Yr==model.info$endyear),which(SPR$variable=="retro-2"&SPR$Yr>=model.info$endyear-1),which(SPR$variable=="retro-3"&SPR$Yr>=model.info$endyear-2),which(SPR$variable=="retro-4"&SPR$Yr>=model.info$endyear-3),which(SPR$variable=="retro-5"&SPR$Yr>=model.info$endyear-4))
          SPR<-SPR[-RemoveVector,]
          
          Retro_SPR<-ggplot() +
            geom_line(aes(x=Yr,y=value,color=variable),data=SPR, linewidth=1) +
            theme(panel.border = element_rect(color="black",fill=NA,linewidth=1),
                  panel.background = element_blank(), strip.background = element_blank(),
                  legend.position = "none") +
            scale_color_manual(values = c("black","red", "orange","yellow","green","blue","black")) + xlab("Year") + ylab("1-SPR") +
            geom_line(aes(x=Yr,y=value),data=subset(SPR,variable=="retro0"),color="black", linewidth=1.25) +
            scale_y_continuous(limits = c(0,1))
          # grid.arrange(a,b,ncol=2)
          MohnsRho<-SShcbias(retroSummary)
          
        } 
    }
    

  
  # if(do_profile == TRUE){
  #   ## Create directory and copy inputs
  #   dir.profile <- file.path(root_dir, "SS3 models", species, file_dir, paste0(profile, "_profile"))
  #   r4ss::copy_SS_inputs(dir.old = file.path(root_dir, "SS3 models", species, file_dir),
  #                  dir.new = dir.profile,
  #                  create.dir = TRUE,
  #                  overwrite = TRUE,
  #                  recursive = TRUE,
  #                  use_ss_new = TRUE,
  #                  copy_exe = TRUE,
  #                  copy_par = FALSE,
  #                  dir.exe = file.path(root_dir, "SS3 models", species, file_dir),
  #                  verbose = TRUE)
  #   
  #   # Make changes to starter file
  #   starter <- r4ss::SS_readstarter(file.path(dir.profile, "starter.ss"))
  #   starter[["ctlfile"]] <- "control_modified.ss"
  #   # make sure the prior likelihood is calculated
  #   # for non-estimated quantities
  #   starter[["prior_like"]] <- 1
  #   r4ss::SS_writestarter(starter, dir = dir.profile, overwrite = TRUE)
  #   
  #   # vector of values to profile over
  #   
  #   #Nprofile <- length(profile.vec)
  #   
  #   ## Do Profiling
  #   profile <- r4ss::profile(
  #     dir = dir.profile, 
  #     exe = "ss_opt_win",
  #     oldctlfile = "control.ss",
  #     newctlfile = "control_modified.ss",
  #     string = profile,
  #     profilevec = profile.vec
  #   )
  #   
  # }
  # 
  # if(do_jitter == TRUE){
  #   
  #   dir.jitter <- file.path(root_dir, "SS3 models", species, file_dir, "jitter")
  #   r4ss::copy_SS_inputs(dir.old = file.path(root_dir, "SS3 models", species, file_dir),
  #                        dir.new = dir.jitter,
  #                        create.dir = TRUE,
  #                        overwrite = TRUE,
  #                        recursive = TRUE,
  #                        use_ss_new = TRUE,
  #                        copy_exe = TRUE,
  #                        copy_par = TRUE,
  #                        dir.exe = file.path(root_dir, "SS3 models", species, file_dir),
  #                        verbose = TRUE)
  #   
  #   
  #   # Step 7. Run jitter using this function (deafult is nohess)
  #   jit.likes <- r4ss::jitter(dir=dir.jitter, 
  #                                   exe = "ss_opt_win.exe",
  #                             Njitter=Njitter, 
  #                             jitter_fraction = jitterFraction, 
  #                             init_values_src = 1)
  #   
  # }
}





