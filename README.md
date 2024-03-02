This is a developmental repository to automate International stock assessments in SS3 from writing the input files through writing the stock assessment report and exeuctive summary. The code is currently being tested on a run of the 2023 NP swordfish assessment noting that the stock blows up and is not a true representation of the final assessment. Note that this should run reasonably well with similar models but is currently configured for 2-sex models. To use for a 1-sex model a different template must be used (in progress).

To run: clone the repository to your local workspace, open the file Run_SS_Model.R, change your base directory to the current folder path, and then run the rest of the script. 

At this time the following actions work: writing the input files, running the model, writing some summary plot files (i.e. the R4ss html output), and running the retrospectives, jitter, and profile in parallel. 
The run jitter function is currently acting strangely - some jitters might run, some might crash.
The print_report functions works except for the Profile plots - more work is necessary to get those functioning.

Please contact Michelle Sculley (michelle.sculley@noaa.gov) if you have any questions or submit an issue.

## Github Disclaimer

This repository is a scientific product and is not official communication of the National Oceanic and Atmospheric Administration, or the United States Department of Commerce. All NOAA GitHub project code is provided on an ‘as is’ basis and the user assumes responsibility for its use. Any claims against the Department of Commerce or Department of Commerce bureaus stemming from the use of this GitHub project will be governed by all applicable Federal law. Any reference to specific commercial products, processes, or services by service mark, trademark, manufacturer, or otherwise, does not constitute or imply their endorsement, recommendation or favoring by the Department of Commerce. The Department of Commerce seal and logo, or the seal and logo of a DOC bureau, shall not be used in any manner to imply endorsement of any commercial product or activity by DOC or the United States Government.
