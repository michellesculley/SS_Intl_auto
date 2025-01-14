#V3.30.08.03-safe;_2017_09_29;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_11.6
#C  generic forecast file
# for all year entries except rebuilder; enter either: actual year, -999 for styr, 0 for endyr, neg number for rel. endyr
1 # Benchmarks: 0=skip; 1=calc F_spr,F_btgt,F_msy
2 # MSY: 1= set to F(SPR); 2=calc F(MSY); 3=set to F(Btgt); 4=set to F(endyr)
0.3 # SPR target (e.g. 0.40)
0.191 # Biomass target (e.g. 0.40)
#_Bmark_years: beg_bio, end_bio, beg_selex, end_selex, beg_relF, end_relF, beg_recr_dist, end_recr_dist, beg_SRparm, end_SRparm (enter actual year, or values of 0 or -integer to be rel. endyr)
 2021 2021 2021 2021 2021 2021 1975 2021 1975 2021
1 #Bmark_relF_Basis: 1 = use year range; 2 = set relF same as forecast below
#
0 # Forecast: 0=none; 1=F(SPR); 2=F(MSY) 3=F(Btgt); 4=Ave F (uses first-last relF yrs); 5=input annual F scalar
0 # N forecast years
0 # F scalar (only used for Do_Forecast==5)
#_Fcast_years:  beg_selex, end_selex, beg_relF, end_relF, beg_recruits, end_recruits  (enter actual year, or values of 0 or -integer to be rel. endyr)
 2016 2016 2016 2016 1975 2016
0 # Forecast selectivity (0=fcast selex is mean from year range; 1=fcast selectivity from annual time-vary parms)
2 # Control rule method (1=catch=f(SSB) west coast; 2=F=f(SSB) )
0.4 # Control rule Biomass level for constant F (as frac of Bzero, e.g. 0.40); (Must be > the no F level below)
0.01 # Control rule Biomass level for no F (as frac of Bzero, e.g. 0.10)
1 # Control rule target as fraction of Flimit (e.g. 0.75)
3 #_N forecast loops (1=OFL only; 2=ABC; 3=get F from forecast ABC catch with allocations applied)
3 #_First forecast loop with stochastic recruitment
0 #_Forecast loop control #3 (reserved for future bells&whistles)
0 #_Forecast loop control #4 (reserved for future bells&whistles)
0 #_Forecast loop control #5 (reserved for future bells&whistles)
2017  #FirstYear for caps and allocations (should be after years with fixed inputs)
0 # stddev of log(realized catch/target catch) in forecast (set value>0.0 to cause active impl_error)
0 # Do West Coast gfish rebuilder output (0/1)
2016 # Rebuilder:  first year catch could have been set to zero (Ydecl)(-1 to set to 1999)
2016 # Rebuilder:  year for current age structure (Yinit) (-1 to set to endyear+1)
1 # fleet relative F:  1=use first-last alloc year; 2=read seas, fleet, alloc list below
# Note that fleet allocation is used directly as average F if Do_Forecast=4
2 # basis for fcast catch tuning and for fcast catch caps and allocation  (2=deadbio; 3=retainbio; 5=deadnum; 6=retainnum)
# Conditional input if relative F choice = 2
# enter list of:  season,  fleet, relF; if used, terminate with season=-9999
# 1 2 0.150028
# 1 4 0.00489292
# 1 6 0.0065735
# 1 8 0.0108228
# 1 10 0.0419864
# 1 11 0.000125847
# 1 12 0.0353121
# 1 14 0.00478647
# 1 15 0.00395801
# 1 16 0.0015967
# 1 17 0.0213816
# 1 18 0.00147953
# 2 2 0.0587361
# 2 4 0.0133512
# 2 6 0.00661946
# 2 8 0.010909
# 2 10 0.0424534
# 2 11 0.000126849
# 2 12 0.101718
# 2 14 0.0154622
# 2 15 0.00400204
# 2 16 0.00161446
# 2 17 0.0216195
# 2 18 0.000831111
# 3 2 0.0538285
# 3 4 0.00149609
# 3 6 0.00663995
# 3 8 0.0108213
# 3 10 0.0426758
# 3 11 0.000125829
# 3 12 0.0204883
# 3 14 0.00196871
# 3 15 0.004023
# 3 16 0.00162292
# 3 17 0.0217327
# 3 18 0.000259065
# 4 2 0.160965
# 4 4 0.00121651
# 4 6 0.00668205
# 4 8 0.010888
# 4 10 0.0429859
# 4 11 0.000126605
# 4 12 0.022913
# 4 15 0.00405223
# 4 16 0.00163471
# 4 17 0.0218906
# 4 18 0.000576208
# enter list of: fleet number, max annual catch for fleets with a max; terminate with fleet=-9999
-9999 -1
# enter list of area ID and max annual catch; terminate with area=-9999
-9999 -1
# enter list of fleet number and allocation group assignment, if any; terminate with fleet=-9999
-9999 -1
#_if N allocation groups >0, list year, allocation fraction for each group
# list sequentially because read values fill to end of N forecast
# terminate with -9999 in year field
# no allocation groups
2 # basis for input Fcast catch: -1=read basis with each obs; 2=dead catch; 3=retained catch; 99=input Hrate(F)
#enter list of Fcast catches; terminate with line having year=-9999
#_Yr Seas Fleet Catch(or_F)
-9999 1 1 0
#
999 # verify end of input
