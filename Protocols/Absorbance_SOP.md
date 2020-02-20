# Protocol for measuring absorbance of samples using the SpectraMax iD3 Spectrophotometer and SoftMax Pro 7 (SMP7) software

**Contents**  
* [**Setting up the Plate Read in SMP7**](#Setting_up_plate_read)  
* [**Preparing the well plate**](#Preparing_well_plate)  
* [**Exporting Data and Protocols**](#Exporting_data)  


<a name=Setting_up_plate_read></a> **Setting up the plate read in SMP7**  

1. Open the SoftMax Pro 7 program from the desktop.
1. If the program does not automatically connect to the plate reader (depicted by an icon of the plate reader in the upper left corner of the program with a green check if connected or a circle with a line if not connected), then click on the plate reader icon for a list of available plate readers.  Select the reader and click OK.
1. If you intend to read your plate at a particular temperature, click Temperature and turn "Set" on and type in the temperature in Celcius.
1. Select the "Acquisition Settings" icon (two orange gears).
    1. Make sure the appropriate "Read Mode" and "Read Type" are selected.
        1. Read Mode: ABS (Absorbance)
        1. Read Type: Choose between Endpoint (most common and quickest), Kinetic, Well Scan, and Spectrum
    1. To select the plate type, scroll down the list of plates and select the "96 well plate Falcon clear (SilbigerLab)"
    1. In Wavelengths, use the dropdown menu to select how many wavelengths you intend to use, and type each wavelength into the boxes provided.
    1. Unless comparing your samples in the well plate directly to samples in cuvettes, do not activate "Pathcheck"
    1. If you want to shake the plate prior to your first read, check the box and set the number of seconds to shake.  From the dropdown menu, select the shake mode.
    1. If you are planning to read a full plate, or if you are planning to read a rectangular portion of the plate, select Row of Column from the dropdown menu.  If you are planning to read a more randomized sequence of wells, select Well from the dropdown.  The latter option may slow down read time.
    1. Press OK to save these settings.
1. Select the "Template Editor" icon (well plate).
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
    1. If you reran your plate without creating more plates in your experiment (as labeled on the lefthand sidebar), data from your previous run would be overwritten once you ran the plate again.  Alternatively, you can save your data as you go, but in case of mistakes, it is not advisable to overwrite data before completing your set of plate reads.
1. Once your plate is ready, following the [below protocol](#Preparing_well_plate), you can either click "Read" (green play button) or set a Work Flow to set the series of events during your read.
1. Work Flow
    1. On the lefthand sidebar, click the Work Flow header (as opposed to the Document header we've been working under so far)
    1. The left sidebar now gives options for events to occur for the plate read.  Click and drag any of the items along the line of the open field to the right.
    1. Items can be placed anywhere along the line, before or after other events, and can be moved once placed, deleted, or modified.
    1. Once your workflow is set, click "Run" in the upper menu.  You can Pause or Stop the flow at any point, but if you Resume from Paused, the step you were previously on will be skipped and the Flow will resume at the next step. 
    1. Example: Reading a plate of unknowns for pH using m-cresol dye:
        1. "Set Temp (25c)" - "Open Reader" - "Read Plate1" - "Open Reader" - "Shake Plate (30sec)" - "Read Plate2" - "Open Reader"  
        1. The instrument will open the reader for the first time one the temperature is at your set point, in this case 25 degrees Celcius.
        1. Once you've placed your plate in the holder,  you must return to the Document tab and then click "Open/Close" near the top of the program screen.
        1. The first plate will be read and saved in Plate1, then the holder will open and eject again.  Remove the plate, pipette the m-cresol dye in the plate, then place back in the holder and as in the previous step close the holder.
        1. The plate will shake for 30 seconds, then the plate will be read and saved in Plate2, then the holder will open and eject.
1. If you are running a standard for your plate, run your standard **before you prepare and run the rest of your plate** to make sure the instrument is reading correctly and/or that your standard is correct.
    1. Follow all the same previous steps, but in your configuration and plate mapping, only select the wells used for your your standard.
    1. Save and check your standard values before proceeding with your unknown samples.

<a name=Preparing_well_plate></a> **Preparing the well plate**  

1. When handling well plates, be careful to not touch the bottom of the plate with bare hands/gloves or place the plate on any surface that may scratch it.  For absorbance readings, light is projected through the bottom of the plate and any disturbed surface will likely affect the reading.  Place on kim wipes when set down, and hold by the sides when carrying/handling.
1. Each well has a maximum volume of 340uL, but it is advisable to not greatly exceed 300uL, especially if shaking before your read.
1. Once finished with the plate, use DI water to rinse out the wells, and dispose of both the initial contents and the rinse solution as needed per the contents' waste procedures.
    1. If using any solutions with Mercuric Chloride (HgCL2) use the large beaker labeled "HgCl2" to dump the contents and into which to rinse with DI.  Pour these contents from the beaker into a proper waste container.
1. Let the plate dry upside down on kim wipes and/or use only kim wipes to wipe away any remaining DI water, again being careful to not disturb the bottom surface of the plate.

<a name=Exporting_data></a> **Exporting Data and Protocols**  

1. Exporting your data
    1. From the Home screen, select Export  in the Template Tools ection of the upper menu.  This file exports the well ID's you provided in your plate map prior to your read.  Change "Save as Type" to .xls
        1. Save your plates using the following as a guideline: name_date_Template.xls
    1. To export your read values, click on the "File" tab which is depicted by an encirculed well plate icon in the upper lefthand corner of the program screen to reveal a dropdown menu.
    1. Select Export, then click export to XML XLS TXT.
    1. In the export options window, select each plate you want to export; select to either export just the raw data, just the reduced data, or both (if you set "blanks" in your well plate template earlier, it is suggested to export either the raw data or both raw and reduced, rather than just reduced).  In Output Format, select Plate (.txt or .xls).  Change "Save as Type" to .xls
    1. Save your plates using the following as a guideline: name_date_Plate.xls
        1. Files are exported as .xls files, so once saved, you will need to open the file and save a .csv to access in R.
1. Saving your protocol and data file
    1. If you intend to use the same well plate configuration and possibly same plate ID's, you can save your plate settings as a Protocol.
    1. Save your protocol (plate configuration and map settings) in the following folder location on the lab computer: C drive > Users > Public > Public Documents > pH_Spec_Protocols > (Your Folder)
    1. Save as a protocol file .spr using the following as a guideline: name_date_Template.spr
    1. To save your read data as a data file, follow the same process, but save as a data file .sda
        1. You can open a data file in SoftMax Pro to work with your data later in the program and subsequently export later on using the above steps.
