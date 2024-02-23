#V3.30
#C file created using the SS_writectl function in the R package r4ss
#C file write time: 2024-02-22 13:29:50.634153
#
0 # 0 means do not read wtatage.ss; 1 means read and usewtatage.ss and also read and use growth parameters
1 #_N_Growth_Patterns
1 #_N_platoons_Within_GrowthPattern
4 # recr_dist_method for parameters
1 # not yet implemented; Future usage:Spawner-Recruitment; 1=global; 2=by area
1 # number of recruitment settlement assignments 
0 # unused option
# for each settlement assignment:
#_GPattern	month	area	age
1	7	1	0	#_recr_dist_pattern1
#
#_Cond 0 # N_movement_definitions goes here if N_areas > 1
#_Cond 1.0 # first age that moves (real age at begin of season, not integer) also cond on do_migration>0
#_Cond 1 1 1 2 4 10 # example move definition for seas=1, morph=1, source=1 dest=2, age1=4, age2=10
#
2 #_Nblock_Patterns
1 1 #_blocks_per_pattern
#_begin and end years of blocks
2004 2009
1994 1997
#
# controls for all timevary parameters 
1 #_env/block/dev_adjust_method for all time-vary parms (1=warn relative to base parm bounds; 3=no bound check)
#
# AUTOGEN
0 0 0 0 1 # autogen: 1st element for biology, 2nd for SR, 3rd for Q, 4th reserved, 5th for selex
# where: 0 = autogen all time-varying parms; 1 = read each time-varying parm line; 2 = read then autogen if parm min==-12345
#
# setup for M, growth, maturity, fecundity, recruitment distibution, movement
#
3 #_natM_type:_0=1Parm; 1=N_breakpoints;_2=Lorenzen;_3=agespecific;_4=agespec_withseasinterpolate;_5=Maunder_M;_6=Age-range_Lorenzen
#_ #_Age_natmort_by sex x growthpattern
#_Age_0	Age_1	Age_2	Age_3	Age_4	Age_5	Age_6	Age_7	Age_8	Age_9	Age_10	Age_11	Age_12	Age_13	Age_14	Age_15
0.42	0.37	0.32	0.27	0.22	0.22	0.22	0.22	0.22	0.22	0.22	0.22	0.22	0.22	0.22	0.22	#_natM1
0.42	0.37	0.32	0.27	0.22	0.22	0.22	0.22	0.22	0.22	0.22	0.22	0.22	0.22	0.22	0.22	#_natM2
1 # GrowthModel: 1=vonBert with L1&L2; 2=Richards with L1&L2; 3=age_specific_K_incr; 4=age_specific_K_decr;5=age_specific_K_each; 6=NA; 7=NA; 8=growth cessation
0.5 #_Age(post-settlement)_for_L1;linear growth below this
15 #_Growth_Age_for_L2 (999 to use as Linf)
-999 #_exponential decay for growth above maxage (value should approx initial Z; -999 replicates 3.24; -998 to not allow growth above maxage)
0 #_placeholder for future growth feature
#
0 #_SD_add_to_LAA (set to 0.1 for SS2 V1.x compatibility)
0 #_CV_Growth_Pattern:  0 CV=f(LAA); 1 CV=F(A); 2 SD=F(LAA); 3 SD=F(A); 4 logSD=F(A)
1 #_maturity_option:  1=length logistic; 2=age logistic; 3=read age-maturity matrix by growth_pattern; 4=read age-fecundity; 5=disabled; 6=read length-maturity
2 #_First_Mature_Age
1 #_fecundity option:(1)eggs=Wt*(a+b*Wt);(2)eggs=a*L^b;(3)eggs=a*Wt^b; (4)eggs=a+b*L; (5)eggs=a+b*W
0 #_hermaphroditism option:  0=none; 1=female-to-male age-specific fxn; -1=male-to-female age-specific fxn
1 #_parameter_offset_approach (1=none, 2= M, G, CV_G as offset from female-GP1, 3=like SS2 V1.x)
#
#_growth_parms
#_LO	HI	INIT	PRIOR	PR_SD	PR_type	PHASE	env_var&link	dev_link	dev_minyr	dev_maxyr	dev_PH	Block	Block_Fxn
   50	     200	   80.1	   97.7	 99	0	 -4	0	0	0	0	0	0	0	#_L_at_Amin_Fem_GP_1       
  100	     300	  226.3	  226.3	 99	0	 -2	0	0	0	0	0	0	0	#_L_at_Amax_Fem_GP_1       
 0.05	     0.3	  0.246	   0.25	 99	0	 -4	0	0	0	0	0	0	0	#_VonBert_K_Fem_GP_1       
 0.01	     0.5	    0.1	    0.1	 99	0	 -3	0	0	0	0	0	0	0	#_CV_young_Fem_GP_1        
 0.01	     0.5	    0.1	   0.15	 99	0	 -3	0	0	0	0	0	0	0	#_CV_old_Fem_GP_1          
    0	       3	1.3e-05	1.3e-05	 99	0	 -3	0	0	0	0	0	0	0	#_Wtlen_1_Fem_GP_1         
    0	       4	   3.07	   3.07	 99	0	 -3	0	0	0	0	0	0	0	#_Wtlen_2_Fem_GP_1         
    1	     200	 143.68	 143.68	 99	0	 -3	0	0	0	0	0	0	0	#_Mat50%_Fem_GP_2          
   -3	       3	-0.1034	-0.1034	 99	0	 -3	0	0	0	0	0	0	0	#_Mat_slope_Fem_GP_1       
    0	       3	      1	      1	 99	0	 -3	0	0	0	0	0	0	0	#_Eggs/kg_inter_Fem_GP_1   
    0	       3	      0	      0	 99	0	 -3	0	0	0	0	0	0	0	#_Eggs/kg_slope_wt_Fem_GP_1
   50	     200	   83.4	     99	 99	0	 -4	0	0	0	0	0	0	0	#_L_at_Amin_Mal_GP_1       
  100	     250	  206.4	  206.4	 99	0	 -2	0	0	0	0	0	0	0	#_L_at_Amax_Mal_GP_1       
 0.05	     0.3	  0.271	  0.271	 99	0	 -4	0	0	0	0	0	0	0	#_VonBert_K_Mal_GP_1       
 0.01	     0.5	    0.1	    0.1	 99	0	 -3	0	0	0	0	0	0	0	#_CV_young_Mal_GP_1        
 0.01	     0.5	    0.1	   0.15	 99	0	 -3	0	0	0	0	0	0	0	#_CV_old_Mal_GP_1          
    0	       3	1.3e-05	1.3e-05	 99	0	 -3	0	0	0	0	0	0	0	#_Wtlen_1_Mal_GP_1         
    0	       4	   3.07	   3.07	 99	0	 -3	0	0	0	0	0	0	0	#_Wtlen_2_Mal_GP_1         
  0.1	      10	      1	      1	  1	0	 -1	0	0	0	0	0	0	0	#_CohortGrowDev            
1e-06	0.999999	    0.5	    0.5	0.5	0	-99	0	0	0	0	0	0	0	#_FracFemale_GP_1          
#_no timevary MG parameters
#
#_seasonal_effects_on_biology_parms
0 0 0 0 0 0 0 0 0 0 #_femwtlen1,femwtlen2,mat1,mat2,fec1,fec2,Malewtlen1,malewtlen2,L1,K
#_ LO HI INIT PRIOR PR_SD PR_type PHASE
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no seasonal MG parameters
#
3 #_Spawner-Recruitment; 2=Ricker; 3=std_B-H; 4=SCAA;5=Hockey; 6=B-H_flattop; 7=survival_3Parm;8=Shepard_3Parm
1 # 0/1 to use steepness in initial equ recruitment calculation
1 # future feature: 0/1 to make realized sigmaR a function of SR curvature
#_LO	HI	INIT	PRIOR	PR_SD	PR_type	PHASE	env-var	use_dev	dev_mnyr	dev_mxyr	dev_PH	Block	Blk_Fxn # parm_name
  3	50	6.84174	9.3	99	0	 1	0	0	0	0	0	0	0	#_SR_LN(R0)  
0.2	 1	    0.9	0.9	99	0	-4	0	0	0	0	0	0	0	#_SR_BH_steep
  0	 2	   0.42	0.6	99	0	-3	0	0	0	0	0	0	0	#_SR_sigmaR  
 -5	 5	      0	  0	99	0	-1	0	0	0	0	0	0	0	#_SR_regime  
  0	 0	      0	  0	99	0	-1	0	0	0	0	0	0	0	#_SR_autocorr
#_no timevary SR parameters
1 #do_recdev:  0=none; 1=devvector (R=F(SSB)+dev); 2=deviations (R=F(SSB)+dev); 3=deviations (R=R0*dev; dev2=R-f(SSB)); 4=like 3 with sum(dev2) adding penalty
1985 # first year of main recr_devs; early devs can preceed this era
2021 # last year of main recr_devs; forecast devs start in following year
3 #_recdev phase
1 # (0/1) to read 13 advanced options
1965 #_recdev_early_start (0=none; neg value makes relative to recdev_start)
4 #_recdev_early_phase
0 #_forecast_recruitment phase (incl. late recr) (0 value resets to maxphase+1)
1 #_lambda for Fcast_recr_like occurring before endyr+1
1967.78 #_last_yr_nobias_adj_in_MPD; begin of ramp
1995.25 #_first_yr_fullbias_adj_in_MPD; begin of plateau
2020.9 #_last_yr_fullbias_adj_in_MPD
2021.73 #_end_yr_for_ramp_in_MPD (can be in forecast to shape ramp, but SS sets bias_adj to 0.0 for fcast yrs)
0.9366 #_max_bias_adj_in_MPD (-1 to override ramp and set biasadj=1.0 for all estimated recdevs)
0 #_period of cycles in recruitment (N parms read below)
-5 #min rec_dev
5 #max rec_dev
0 #_read_recdevs
#_end of advanced SR options
#
#_placeholder for full parameter lines for recruitment cycles
# read specified recr devs
#_Yr Input_value
#
#Fishing Mortality info
0.5 # F ballpark
-1960 # F ballpark year (neg value to disable)
3 # F_Method:  1=Pope; 2=instan. F; 3=hybrid (hybrid is recommended)
6 # max F or harvest rate, depends on F_Method
5 # N iterations for tuning F in hybrid method (recommend 3 to 7)
#
#_initial_F_parms
#_LO	HI	INIT	PRIOR	PR_SD	PR_type	PHASE
0	3	0.985	1	99	0	2	#_1
#
#_Q_setup for fleets with cpue or survey data
#_fleet	link	link_info	extra_se	biasadj	float  #  fleetname
   20	1	0	0	0	1	#_1         
   21	1	0	0	0	1	#_2         
   22	1	0	0	0	1	#_3         
   23	1	0	0	0	1	#_4         
   24	1	0	0	0	1	#_5         
   25	1	0	0	0	1	#_6         
   26	1	0	0	0	1	#_7         
   27	1	0	0	0	1	#_8         
-9999	0	0	0	0	0	#_terminator
#_Q_parms(if_any);Qunits_are_ln(q)
#_LO	HI	INIT	PRIOR	PR_SD	PR_type	PHASE	env-var	use_dev	dev_mnyr	dev_mxyr	dev_PH	Block	Blk_Fxn  #  parm_name
-15	0	-7.81075	-1	99	0	-1	0	0	0	0	0	0	0	#_LnQ_base_1
-15	0	-7.76702	-1	99	0	-1	0	0	0	0	0	0	0	#_LnQ_base_2
-15	0	-7.77464	-1	99	0	-1	0	0	0	0	0	0	0	#_LnQ_base_3
-15	0	-7.98878	-1	99	0	-1	0	0	0	0	0	0	0	#_LnQ_base_4
-15	0	 -6.2852	-1	99	0	-1	0	0	0	0	0	0	0	#_LnQ_base_5
-15	0	-8.79193	-1	99	0	-1	0	0	0	0	0	0	0	#_LnQ_base_6
-15	0	 -4.7185	-1	99	0	-1	0	0	0	0	0	0	0	#_LnQ_base_7
-15	0	-4.33733	-1	99	0	-1	0	0	0	0	0	0	0	#_LnQ_base_8
#_no timevary Q parameters
#
#_size_selex_patterns
#_Pattern	Discard	Male	Special
24	0	0	0	#_1 1  
 1	0	0	0	#_2 2  
24	0	0	0	#_3 3  
 1	0	0	0	#_4 4  
15	0	0	4	#_5 5  
24	0	0	0	#_6 6  
24	0	0	0	#_7 7  
24	0	0	0	#_8 8  
15	0	0	8	#_9 9  
15	0	0	6	#_10 10
15	0	0	6	#_11 11
15	0	0	1	#_12 12
15	0	0	2	#_13 13
15	0	0	1	#_14 14
15	0	0	2	#_15 15
15	0	0	2	#_16 16
15	0	0	3	#_17 17
15	0	0	3	#_18 18
15	0	0	2	#_19 19
15	0	0	6	#_20 20
15	0	0	1	#_21 21
15	0	0	3	#_22 22
15	0	0	3	#_23 23
15	0	0	2	#_24 24
 0	0	0	0	#_25 25
15	0	0	8	#_26 26
15	0	0	3	#_27 27
#
#_age_selex_patterns
#_Pattern	Discard	Male	Special
0	0	0	0	#_1 1  
0	0	0	0	#_2 2  
0	0	0	0	#_3 3  
0	0	0	0	#_4 4  
0	0	0	0	#_5 5  
0	0	0	0	#_6 6  
0	0	0	0	#_7 7  
0	0	0	0	#_8 8  
0	0	0	0	#_9 9  
0	0	0	0	#_10 10
0	0	0	0	#_11 11
0	0	0	0	#_12 12
0	0	0	0	#_13 13
0	0	0	0	#_14 14
0	0	0	0	#_15 15
0	0	0	0	#_16 16
0	0	0	0	#_17 17
0	0	0	0	#_18 18
0	0	0	0	#_19 19
0	0	0	0	#_20 20
0	0	0	0	#_21 21
0	0	0	0	#_22 22
0	0	0	0	#_23 23
0	0	0	0	#_24 24
0	0	0	0	#_25 25
0	0	0	0	#_26 26
0	0	0	0	#_27 27
#
#_SizeSelex
#_LO	HI	INIT	PRIOR	PR_SD	PR_type	PHASE	env-var	use_dev	dev_mnyr	dev_mxyr	dev_PH	Block	Blk_Fxn  #  parm_name
  53	257	 157.406	  90	0.05	0	 2	0	0	0	0	0	2	2	#_1 
 -10	  3	-9.68831	 0.1	0.05	0	-4	0	0	0	0	0	2	2	#_2 
  -4	 12	 7.49366	   6	0.05	0	 3	0	0	0	0	0	2	2	#_3 
  -2	 20	  8.2735	 0.1	0.05	0	 3	0	0	0	0	0	2	2	#_4 
-999	999	    -999	-999	  99	0	-2	0	0	0	0	0	0	0	#_5 
-999	999	    -999	-999	  99	0	-2	0	0	0	0	0	0	0	#_6 
  10	150	 146.639	  70	0.01	0	 3	0	0	0	0	0	1	2	#_7 
0.01	150	 28.9371	  15	0.01	0	 3	0	0	0	0	0	1	2	#_8 
  53	250	 168.907	  90	0.05	0	 2	0	0	0	0	0	0	0	#_9 
 -10	  3	 -9.5107	 0.1	0.05	0	-4	0	0	0	0	0	0	0	#_10
  -4	 12	 7.92504	   6	0.05	0	 3	0	0	0	0	0	0	0	#_11
  -6	 10	 8.20937	 0.1	0.05	0	 3	0	0	0	0	0	0	0	#_12
-999	999	    -999	-999	  99	0	-2	0	0	0	0	0	0	0	#_13
-999	999	    -999	-999	  99	0	-2	0	0	0	0	0	0	0	#_14
  10	150	 148.336	  70	0.01	0	 3	0	0	0	0	0	0	0	#_15
0.01	150	 91.3916	  15	0.01	0	 3	0	0	0	0	0	0	0	#_16
  53	257	 140.586	  90	0.05	0	 2	0	0	0	0	0	0	0	#_17
 -10	  3	-8.46536	 0.1	0.05	0	-4	0	0	0	0	0	0	0	#_18
  -4	 12	 7.28621	   6	0.05	0	 3	0	0	0	0	0	0	0	#_19
  -2	 10	 9.17424	 0.1	0.05	0	 3	0	0	0	0	0	0	0	#_20
-999	999	    -999	-999	  99	0	-2	0	0	0	0	0	0	0	#_21
-999	999	    -999	-999	  99	0	-2	0	0	0	0	0	0	0	#_22
  50	257	 237.032	  90	0.05	0	 2	0	0	0	0	0	0	0	#_23
 -10	  3	 1.84357	 0.1	0.05	0	 3	0	0	0	0	0	0	0	#_24
  -4	 12	 8.42919	   6	0.05	0	 3	0	0	0	0	0	0	0	#_25
  -2	 15	  4.0106	 0.1	0.05	0	 3	0	0	0	0	0	0	0	#_26
-999	999	    -999	-999	  99	0	-2	0	0	0	0	0	0	0	#_27
-999	999	    -999	-999	  99	0	-2	0	0	0	0	0	0	0	#_28
  53	250	 158.219	  90	0.05	0	 2	0	0	0	0	0	0	0	#_29
 -10	  3	-7.68772	 0.1	0.05	0	 3	0	0	0	0	0	0	0	#_30
  -4	 12	 7.65485	   6	0.05	0	 3	0	0	0	0	0	0	0	#_31
  -6	 10	 7.97471	 0.1	0.05	0	 3	0	0	0	0	0	0	0	#_32
-999	999	    -999	-999	  99	0	-2	0	0	0	0	0	0	0	#_33
-999	999	    -999	-999	  99	0	-2	0	0	0	0	0	0	0	#_34
#_AgeSelex
#_No age_selex_parm
# timevary selex parameters 
#_LO	HI	INIT	PRIOR	PR_SD	PR_type	PHASE
  53	257	 134.994	 90	0.05	0	 2	#_1
 -10	  3	-9.33759	0.1	0.05	0	-4	#_2
  -4	 12	  6.5657	  6	0.05	0	 3	#_3
  -2	 20	 17.4491	0.1	0.05	0	 3	#_4
  10	150	 142.076	 70	0.01	0	 3	#_5
0.01	150	  27.619	 15	0.01	0	 3	#_6
# info on dev vectors created for selex parms are reported with other devs after tag parameter section
#
0 #  use 2D_AR1 selectivity(0/1):  experimental feature
#_no 2D_AR1 selex offset used
# Tag loss and Tag reporting parameters go next
0 # TG_custom:  0=no read; 1=read if tags exist
#_Cond -6 6 1 1 2 0.01 -4 0 0 0 0 0 0 0  #_placeholder if no parameters
#
# Input variance adjustments factors: 
#_factor	fleet	Value
1    	24	0.11	#_1         
-9999	0 	   0	#_terminator
#
3 #_maxlambdaphase
1 #_sd_offset; must be 1 if any growthCV, sigmaR, or survey extraSD is an estimated parameter
# read 14 changes to default Lambdas (default value is 1.0)
#_likecomp	fleet	phase	value	sizefreq
    1	25	1	  1	1	#_1         
    4	 1	1	0.5	1	#_2         
    4	 2	1	0.5	1	#_3         
    4	 3	1	0.5	1	#_4         
    4	 4	1	0.5	1	#_5         
    4	 5	1	  0	0	#_6         
    4	 6	1	0.5	1	#_7         
    4	 7	1	0.5	1	#_8         
    4	 8	1	0.5	1	#_9         
    4	 9	1	0.5	1	#_10        
    9	 6	1	  0	0	#_11        
   10	 1	1	  1	1	#_12        
    1	24	1	  0	0	#_13        
    1	27	1	  0	0	#_14        
-9999	 0	0	  0	0	#_terminator
#
0 # 0/1 read specs for more stddev reporting
#
999
