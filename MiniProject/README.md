# Mini-project
## Brief description
Code, data and output files for the CMEE Mini-project, covering model selection on the functional response dataset.
## Languages
<!---Include version of each language--->
* R version 3.6.3 (2020-02-29)
* GNU bash version 5.0.17(1)-release
## Dependencies
<!---   Any dependencies or special packages the user / marker should be aware of.
        What each package is used for.  --->
R : 
* AICcmodavg version 2.3-1: for calculating the corrected Akaike Information Criterion (AICc)
* broom version 0.7.3: for generating tables in .tex format from TukeyHSD output.
* cowplot version 1.1.0: for arranging ggplot elements into multi-panel plots.
* dplyr version 1.0.2: for better data frame manipulation.
* ggplot2 version 3.3.2: for making 'pretty' plots.
* minpack.lm version 1.2-1: for calculating non-linear least squares (nlsLM()).
* xtable version 1.8-4: Export 'pretty' tables as LaTeX script to copy into Write_up.tex.
## Installation
Assuming the above dependencies and versions are installed, no further installations should be required. Scripts may be dependent on the output of other script files. See below for the necessary order to run scripts.
## Project structure and Usage
The project is run in its entirety by running run_MiniProject.sh. The script requires running from within the /Code directory.
### Code
run_MiniProject.sh: Bash script running all necessary scripts in order, finally generating the completed write-up as a pdf.

Ordered workflow:
* Extract_values.R: Fit each of the candidate models to each subset of the data. Extract coefficients of model fits (necessary for Plot_models.R) and save to ../Data/. Evaluate the fits of each model and generate a figure displaying the percentage wins and percentage overall wins of each model.
* Plot_models.R: Generate plots for each subset of the data (ID), plotting each of the candidate models. Save these plots to ../Plots/Mechanistic or ../Plots/Phenomenological. Generate a 'pretty' plot for a specially selected ID and save to ../Results/. 
* Akaike_weights.R: Calculate Akaike Weights for each ID, then plotting the mean Akaike Weights for each of the mechanistic models and save the figure to ../Results/.
* Habitat_comparisons.R: Compare AICc values of each of the mechanistic models between habitats.
* Write_up.tex: LaTeX script containing the entire write-up, including figures generated from Extract_values.R, Plot_models.R and Akaike_weights.R.
* Supplementary_figure.tex: Supplementary figures to the write-up.
* CompileLaTex.sh: Compile LaTeX script into pdf and save to ../Results/.

Accessory scripts:
* Biblio.bib: BibTeX script containing the list of references for Write_up.tex.
* my_functions.R: All necessary functions required for Extract_values.R, Plot_models.R and Akaike_weights.R.
* Write_up_safe.pdf: Compiled pdf of the final project write-up just in case the code doesn't run.

Write-up pdfs:
* Supplementary_figures_safe.pf: Compiled pdf of the final supplementary figures just in case the code doesn't run.
* Write_up_safe.pdf: Compiled pdf of the final project write-up just in case the code doesn't run.
### Data
* CRat.csv: Consumption rate and resource density data for a variety of unique combinations of consumer and resource taxa (IDs). Also includes a variety of data describing the taxa and the interaction between consumer and resource taxa. The two columns of interest are N_TraitValue (consumption rate) amd ResDensity (resource density).

Additional data files are saved here as the code is run e.g. csv files containing model coefficients. 
### Plots
The plots of model fits to subsetted data (IDs) are saved here after running Plot_models.R. 

Sub-directories:
* Mechanistic: where plots of mechanistic model fits to each ID are saved.
* Phenomenological: where plots of phenomenological models fits to each ID are saved.

Also contains:
* Temporary figures that are used to generate multi-panel plots.
### Results
All results generated from running the code, including all figures needed for the final write-up, are saved here after running the respective code.
## Author name and contact
Ioan Evans  
email: ie917@ic.ac.uk