# GC×GC DataWorks Software Manual

## Overview
This software package contains three MATLAB programs for processing Agilent GC×GC raw data:

1. Raw_chromatogram.m
Function: Reads raw GC data files and generates original chromatograms
Raw_chromatogram('path_to_raw_data.D')
2. RawDatato2DGC.m
Function: Converts raw data into 2D GC chromatograms
RawDatato2DGC('input.D', 'output_folder')
3. auto2DGCQuant.m
Function: Performs automated quantitative analysis
auto2DGCQuant('sample.D', 'GC_Parameters.csv')
Requirements
Agilent .D raw data files
Required dependencies (listed in code comments)
Configuration File (GC_Parameters.csv)
ParameterType	Compound type	InternalStandard/TargetCompound
Name	Target compound name	e.g., Benzene
RT1D	1st dimension retention time	Data points
RT2D	2nd dimension retention time	Data points
Slope	Calibration curve slope	User-defined
Intercept	Calibration curve intercept	User-defined
Notes:

Obtain RT1D/RT2D values from RawDatato2DGC outputs
Maintain at least one InternalStandard entry
Modify TargetCompound entries as needed
Output Files
auto2DGCQuant generates these files in the source directory:
2D_Chromatogram
2D_Chromatogram(PeakID-non-R.T.correction)
2D_Chromatogram(R.T.correction)
2D_Chromatogram(PeakID-R.T.correction)
FullData
Report
Quantitative Method Setup:
Step 1: Qualitative Analysis
Run RawDatato2DGC on standard samples
Identify retention times for:
Internal Standard
Target Compounds
Step 2: Parameter Configuration
Update GC_Parameters.csv:
Insert obtained RT1D/RT2D values
Configure compound list
Step 3: Calibration
Process standards with auto2DGCQuant
From FullData results:
Extract peak areas
Calculate calibration coefficients
Update Slope/Intercept values in GC_Parameters.csv
Routine Analysis"
auto2DGCQuant('sample.D')
Find results in:
FullData: Complete quantitative data
Report: Summary results
Important Notes
Adjust parameters marked with % MODIFY in code headers according to:
Instrument specifications
Chromatographic conditions
Maintain consistent file encoding (UTF-8 recommended)
Backup parameter files before modification
