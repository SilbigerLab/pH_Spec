# Protocol for measuring absorbance of samples using the SpectraMax iD3 Spectrophotometer and SoftMax Pro 7 (SMP7) software

**Contents**  
* [**Setting up the Plate Read in SMP7**](#Setting_up_plate_read)  
* [**Preparing the well plate**](#Preparing_well_plate)  


<a name=Setting_up_plate_read></a> **Setting up the plate read in SMP7**  

1. Open the SoftMax Pro 7 program from the desktop.
1. If the program does not automatically connect to the plate reader (depicted by an icon of the plate reader in the upper left corner of the program with a green check if connected or a circle with a line if not connected), then click on the plate reader icon for a list of available plate readers.  Select the reader and click OK.
1. Select the "configure your acquisition settings" icon (two orange gears).
    1. Make sure the appropriate "Read Mode" and "Read Type" are selected.
        1. Read Mode: ABS (Absorbance)
        1. Read Type: Choose between Endpoint (most common and quickest), Kinetic, Well Scan, and Spectrum
    1. In Wavelengths, use the dropdown menu to select how many wavelengths you intend to use, and type each wavelength into the boxes provided.
    1. Unless comparing your samples in the well plate directly to samples in cuvettes, do not activate "Pathcheck"
    1. If you are planning to read a full plate, or if you are planning to read a rectangular portion of the plate, select Row of Column from the dropdown menu.  If you are planning to read a more randomized sequence of wells, select Well from the dropdown.  The latter option may slow down read time.
    1. Press OK to save these settings.
1. Select the "configure your plate layout" icon (well plate).
    1. Now you will define your plate map.  This is important for generating a standard curve and unknown sample values based off the standard curve, and/or where you will identify your plate blanks.
    1. Click and drag your mouse over the wells you want to assign as your blanks, standards, or unknown samples.  If you selected Well in the configuration settings above, you can hold down Ctrl as you select your wells.
    1. Once you've highlighted a set of your wells, either click Blank if these are you blank wells, or look at the right-hand menu, and select either Standards or Unknown.
    1. Standards
        1. If you select multiple columns and rows for standards, select "Series" to define a concentration series for multiple standards, or if you want to assign one concentration for all selected wells, enter the concentration of those standard solutions, and click "Assign".
        1. In "Series" you can set your standard layout, define the replicate pattern, and provide a concentration series with a consistent step.  The drop-down menu for "step by" allows you to +,-,*, or / by a consistent factor
        1. Selecting "Top to Bottom" will tell the software to recognize the order of your standards from top to bottom then left to right.  "Bottom to Top" will order your standards from bottom to top then left to right.  "Left to Right" and "Right to Left" will follow the indicated pattern, then top to bottom.
        1. Pattern of Replicates indicates how many replicate wells are in sequence along the rows and columns.  Ex. x=3, y=1 indicates that three wells along one row are replicates. **Note: if your chosen number of wells is not evenly divisible by either the x- or y-direction well number, the program will truncate the replicate identification at the end of the row or column.
    1. Unknown
        1. It is advisable you select at least three wells as replicates for each unknown sample.
        1. For each selected set of replicates you can provide an ID in the field below the plate map, then select Assign.  It is advisable to provide an ID for your wells so you can assign these to your data later when processing.
1. Once your plate map is completed, select OK to save your plate.  If you close this window without selecting OK, your changes will not be saved.
1. If you itend to run the same plate through the reader more than once (ie once without m-cresol dye, and then once more with dye), then add as many plates as needed on the lefthand sidebar.
    1. Shortcut: duplicate the plate you already created to keep the configuration settings of that plate. You do not need to relabel subsequent plates in the progrma if their labels would exactly match those from Plate1.
    1. If you reran your plate without creating more plates in your experiment (as labeled on the lefthand sidebar), data from your previous run would be overwritten once you ran the plate again.  Alternatively, you can save your data as you go, but in case of mistakes, it is advisable to not overwrite data.


<a name=Preparing_well_plate></a> **Preparing the well plate**  
