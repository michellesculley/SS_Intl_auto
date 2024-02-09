### Set up the SS model to run
### Notes about the template input files: you need separate control 
### and data files for single sex models and two-sex models. Otherwise 
### the starter and forecast files can be the same.


## 1. Input needed information
suppressMessages(suppressWarnings(library(r4ss)))
library(ss3diags, quietly=T, warn.conflicts = F)
library(readxl)
library(quarto)
library(googlesheets4)
library(tidyr)
library(dplyr)
library(tibble)
library(stringr)
## base working directory where all files are stored

base.dir<-"C://users//michelle.sculley//documents//SS_Intl_auto"


fleetnames<-c("F01_JPN_WCNPO_OSDWCOLL_late_Area1",
              "F02_TWN_WCNPO_DWLL_late",
              "F03_US_WCNPO_LL_shallow_late",
              "F04_IATTC",
              "F05_JPN_EPO_OSDWLL",
              "F06_JPN_WCNPO_OSDWLL_early_Area1",
              "F07_JPN_WCNPO_CODF",
              "F08_US_WCNPO_LL_shallow_early",
              "F09_US_WCNPO_LL_deep",
              "F10_JPN_WCNPO_OSDF",
              "F11_PN_WCNPO_Other_early",
              "F12_JPN_WCNPO_Other_late",
              "F13_TWN_WCNPO_DWLL_early",
              "F14_TWN_WCNPO_Other",
              "F15_US_WCNPO_GN", 
              "F16_US_WCNPO_Other",
              "F17_JPN_WCNPO_OSDWLL_early_Area2",
              "F18_JPN_WCNPO_OSDWLL_late_Area2",
              "F19_WCPFC",
              "S01_JPN_WCNPO_OSDWLL_early_Area2",
              "S02_JPN_WCNPO_OSDWLL_late_Area2",
              "S03_JPN_WCNPO_OSDWLL_early_Area1",
              "S04_JPN_WCNPO_OSDWCOLL_late_Area1",
              "S05_TWN_WCNPO_DWLL_late",
              "S06_US_WCNPO_LL_deep",
              "S07_US_WCNPO_LL_shallow_early",
              "S08_US_WCNPO_LL_shallow_late")




model.info<-list(
  "base.dir"=base.dir,
  "startyear"=1975,
  "endyear"=2021,
  "nyr"=5,  ## indicates how many years you want to average the dynamic B0 over if applicable
  "nboot"= 100, ## number of bootstrap files to create
  "seed"=123, ##set seed value
  "data.file.name"="test1.dat",
  "ctl.file.name"="test1.ctl",
  "templatefiles"=list("data"="data.dat",
                       "control"="control.ctl"),
  "template_dir" = file.path(base.dir, "Template_files"), 
  "out_dir" = file.path(base.dir, "Base"),
  "N_foreyrs"=10,
  "init_values" = 0, #read from par = 1, read from ctl file = 0
  "F_age_range"=c(1,10),
  "F_report_basis" = 0, #0=raw_annual_F; 1=F/Fspr; 2=F/Fmsy; 3=F/Fbtgt; where F means annual_F; values >=11 invoke N multiyr (up to 9!) with 10's digit; >100 invokes log(ratio)
  "Min_age_biomass"=1,
  "Nfleets"=27,
  "Nsurvey"=8,
  "Nsexes" = 2,
  "Species"="SWO",
  "fleets"=fleetnames,
  "catch.file"="InputCatch_Base.csv",
  "length.file"="InputLength_Base.csv",
  "CPUE.file"="InputCPUE_Base.csv",
  "scenario"="base",
  "binwidth"=5,
  "bin.min"=10,
  "bin.max"=260,
  "fleetinfo.special"=data.frame("fleet"=25,"unit"=33), #fleet number, special survey type (otherthan  1 - catch or 3 - CPUE/Survey )
  "catch.num"=c(1,3,5,6,8,9,17,18,20,21,22,23,24,25,26,27),  ##fleets in which catch is in numbers,
  "nseas"=4,
  "spawn_month"=5,
  "lbin_method"=2,
  "lambdas"=TRUE)


## Run models
source(file.path(base.dir,"Rscripts","SS Runs","01_Build_All_SS.R"))
Build_All_SS(model.info=model.info,
             M_option = "Base",
             GROWTH_option = "Base",
             LW_option = "Base",
             MAT_option = "Base",
             SR_option = "Base",
             EST_option = "Base",
             initF = TRUE,
             includeCPUE = TRUE,
             superyear = FALSE,
             superyear_blocks = NULL,
             N_samp = 40,
             init_values = 0, 
             parmtrace = 0,
             last_est_phs = 10,
             benchmarks = 1,
             MSY = 2,
             SPR.target = 0.4,
             Btarget = 0.4,
             Bmark_years = c(0,0,0,0,0,0,-999,0,-999,0),
             Bmark_relF_Basis = 1,
             Forecast = 2,
             Fcast_years = c(0,0,0,0,0,0),
             Fixed_forecatch=1,
             ControlRule = 0,
             write_files = FALSE,
             runmodels = FALSE,
             ext_args = "-nohess",
             do_retro = FALSE,
             retro_years = 0:-5,
             do_profile = FALSE,
             profile = "SR_LN(R0)",
             profile.vec = c(2, 0.1),
             do_jitter = FALSE,
             Njitter = 200,
             jitterFraction = 0.1,
             printreport = TRUE,
             r4ssplots = FALSE,
             readGoogle = TRUE
)
