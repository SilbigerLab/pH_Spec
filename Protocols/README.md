# Protocol for the Silbiger Lab SpectraMax iD3 Spectrophotometer

### written by Danielle Barnas
created: 9/26/2019  
edited: 9/2/2020

[Startup SOP](#Startup_SOP)  
[Plate Read Setup](#Plate_Read_Setup_SOP)  
[Preparing the Well Plate](#Prepare_Well_Plate_SOP)  
[Export Data](#Export_Data_SOP)  
[measuring pH using the m-cresol method](#pH_SOP)


<a name="Startup_SOP"></a>
## Startup SOP

**Contents**  
[**Logging In**](#Logging_In)  
[**Troubleshooting**](#Troubleshooting)  

<a name="Logging_In"></a> **Logging In**
1. Turn on the Spec by tapping the yellow power button (lower left corner of the screen platform) with your finger.  Initial startup will take a few minutes.
1. Select a User Profile to log in.  Either tap the Profile on the screen, or use an NFC pairing device set up for a particular Profile.
    1. Silbiger Lab: for general lab use; NFC Pairing magnet located on the right side of the instrument
    1. Admin: for any system changes are required: Admin Pin: 0000
1. Select a User Profile to log in
    1. Silbiger Lab
    1. Admin (Pin: 0000)
1. To create a new User Profile, log in with Admin, then select the Maintenance icon (wrench) on the bottom left toolbar, then select Users on the lefthand side.
    1. Select Create New User and type in the User name.
    1. Choose to set a pin or leave the option OFF.
    1. Choose to set an NFC Pairing or leave the option OFF.
    1. These settings can be changed at any time by returning to the Users page in the Admin account.

<a name="Troubleshooting"></a> **Troubleshooting**
1. For quick How-To videos, select the Maintenance icon (wrench) on the bottom left toolbar, then select Support.  Here you can watch videos on
    1. [Getting to konw youre new ID series reader](https://www.moleculardevices.com/en/assets/tutorials-videos/br/getting-to-know-your-new-spectramax-id3)
    1. [Personalizing your ID series reader](https://www.moleculardevices.com/en/assets/tutorials-videos/br/personalizing-your-spectramax-id3)
    1. [Starting a plate read](https://www.moleculardevices.com/en/assets/tutorials-videos/br/starting-plate-read-using-spectramax-id3-multi-mode)
    1. [Viewing results](https://www.moleculardevices.com/en/assets/tutorials-videos/br/viewing-results-on-spectramax-id3-multi-mode)
1. Lost connection between the instrument and the computer
    1. On the SpectraMax iD3 touchscreen, select the **Maintenance** icon (wrench), and go to **System Information**.
    1. Note the Assigned IP address.
    1. In the SoftMax Pro program, click the well plate icon in the upper lefthand corner to view the dropdown menu.
    1. Select **Options** on the bottom bar.
    1. Select **SpectraMax iDx Control** on the lefthand bar.
    1. In IP-Address 1, make sure the Assigned IP address shown on the instrument's screen is the same as one of the IP-Addresses shown on the iDx Control page.
    1. If unchecked, chek the box that "Enables control of SpectraMax iDx instruments"
1. Plate reader is connected but unresponsive through SoftMax Pro
    1. The lab computer is fairly slow, so be patient with it and try to not task overload.
    1. If the instrument is still unresponsive through the program after you've waited for possibly just slow task completion, try exiting the program and reopening.
    1. If the program will not let you exit because it says the instrument is running, go to the plate reader's touch screen and press "Disconnect".  Wait a moment (up to about a minute) on SoftMax Pro before attempting to reconnect to the instrument.



<a name=Plate_Read_Setup_SOP></a>
## Protocol for setting up a Plate Read using the SpectraMax iD3 Spectrophotometer SoftMax Pro 7 (SMP7) software

**Contents**  
* [**General Settings**](#General_settings) 
* [**Temperature Control**](#Temperature_control)
* [**Mapping your Plate**](#Plate_map)  
* [**Work Flow**](#Work_flow)  

<a name=General_settings></a> **General Settings**  

1. Open the SoftMax Pro 7 program from the desktop.
1. If the program does not automatically connect to the plate reader (depicted by an icon of the plate reader in the upper left corner of the program with a green check if connected or a circle with a line if not connected), then click on the plate reader icon for a list of available plate readers.  Select the reader and click OK.
1. If you intend to read your plate at a particular temperature, click Temperature and turn "Set" on and type in the temperature in Celcius.
1. Select the "Acquisition Settings" icon (two orange gears).
    1. Make sure the appropriate "Read Mode" and "Read Type" are selected.
        1. Read Mode: ex. ABS (Absorbance)
        1. Read Type: Choose between Endpoint (most common and quickest), Kinetic, Well Scan, and Spectrum
    1. To select the plate type, scroll down the list of plates and select the "96 well plate Falcon clear (SilbigerLab)"
    1. In Wavelengths, use the dropdown menu to select how many wavelengths you intend to use, and type each wavelength into the boxes provided.
    1. Unless comparing your samples in the well plate directly to samples in cuvettes, do not activate "Pathcheck"
    1. If you want to shake the plate prior to your first read, check the box and set the number of seconds to shake.  From the dropdown menu, select the shake mode.
    1. If you are planning to read a full plate, or if you are planning to read a rectangular portion of the plate, select Row of Column from the dropdown menu.  If you are planning to read a more randomized sequence of wells, select Well from the dropdown.  The latter option may slow down read time.
    1. Press OK to save these settings.

**Measuring pH using m-cresol**

1. Read Mode: ABS
2. Set wavelengths to 730nm, 578nm, 434nm
3. Deselect Pathcheck
4. Deselect Shake
5. Select Well read mode
6. Press OK to save these settings
7. From the Document page, right click Plate1 and duplicate until you have 4 plates under your Experiment
8. Rename the first two plates as Tris1 and Tris2, then the next two plates as Plate1 and Plate2
9. In both Tris1 and Tris2 General Settings, select the Read area as the first three wells in column 1. These will be your initiral tris triplicates
10. In both Plate1 and Plate2 General Settings, select the Read area as all the wells you need to run triplicates of your samples **excluding the first three wells in column1** because these wells will still contain tris during your plate reads, but we do not want to save the tris data in these plate reads.
11. For both the Tris and Plate reads, the first plate will be run without dye, and the second plate will be run with dye.  Two separate plates need to be assigned for each set of plate reads so that no data is overwritten by subseuquent reads.

<a name=Temperature_control></a> **Temperature Control**  
1. In SMP7 select "Temperature" from Instrument Commands in the main toolbar.
1. Turn Temperature Control "On" and type the desired temperature (ranges from 15C to 66C)
    1. Instrument needs time to stabilize at temperature, so plan to set the temperature well-enough in advance of when you'll do your plate read.
    1. 3 minutes to stabilize at 37C
    1. 40 minutes to stabilize at 66C
1. **Note:** The plate reader has no built-in cooling mechanism, so if you plan to use various temperatures for your reads, start with the lowest temperature and ramp up.
1. **Note:** Without any temperature settings, the plate reader may naturally increase its internal temperature to up to 2degC over ambient room temperature.  If you plan to run samples at 25degC, make sure the room is 23degC or cooler to ensure stable temperature for readings.
    1. Samples run for pH measurements must be kept at 25degC, both in a water bath before measurement, and during measurement in the spec, so set the spec temperature to 25degC.

<a name=Plate_map></a> **Mapping your Plate**  

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
        1. Use identical ID's for any replicate wells (for running stats in R later)
1. Once your plate map is completed, select OK to save your plate.  If you close this window without selecting OK, your changes will not be saved.
1. If you itend to run the same plate through the reader more than once (i.e., once without m-cresol dye, and then once more with dye), then add multiple plates as needed on the lefthand sidebar.
    1. Each plate will save each run's set of data (i.e., data from your sample without m-cresol dye, and data from your sample with m-cresol)
    1. Shortcut: duplicate the plate you already created to keep the configuration settings of that plate. You do not need to relabel subsequent plates in the progrma if their labels would exactly match those from Plate1.
    1. If you rerun your plate without creating more plates in your experiment (as labeled on the lefthand sidebar), data from your previous run will be overwritten.  Alternatively, you can save your data as you go, but in case of mistakes, it is not advisable to overwrite data before completing your set of plate reads.
1. Once your plate is ready, follow the protocol for [Preparing Your Well Plate](#Prepare_Well_Plate_SOP), and then either click "Read" (green play button) or set a [Work Flow](#Work_flow) to set the series of events during your read.

**Measuring pH using m-cresol**

1. Select the first three wells of column 1, and click Unknown
2. Label these wells as "Tris" (all the same name), and click Assign
3. Select each subsequent set of three wells (your sample triplicates), and assign each set of three wells an ID corresponding to the sample set.  Each well in a set of triplicates should have the same name.


<a name=Work_flow></a> **Work flow**  

1. On the lefthand sidebar, click the Work Flow header (as opposed to the Document header we've been working under so far)
1. The left sidebar now gives options for events to occur for the plate read.  Click and drag any of the items along the line of the open field to the right.
1. Items can be placed anywhere along the line, before or after other events, and can be either moved once placed, deleted, or modified.
1. Once your workflow is set, click "Run" in the upper menu.  You can Pause or Stop the flow at any point, but if you Resume from Paused, the step you were previously on will be skipped and the Flow will resume at the next step. 
1. Example: Reading a plate of unknowns for pH using m-cresol dye: see below
1. If you are running a standard for your plate (e.g. tris), run your standard **before you prepare and run the rest of your plate** to make sure the instrument is reading correctly and/or that your standard is correct.
    1. Follow all the same previous steps, but in your configuration and plate mapping, only select the wells used for your standard to be read.
    1. Save and check your standard values before proceeding with your unknown samples.

**Measuring pH using m-cresol**

1. "Set Temp (25c)" - "Open Reader" - "Read Plate1" - "Open Reader" - "Shake Plate (30sec)" - "Read Plate2" - "Open Reader"  
1. The instrument will open the reader for the first time one the temperature is at your set point, in this case 25 degrees Celcius.
1. Once you've placed your plate in the holder,  you must return to the Document tab and then click "Open/Close" near the top of the program screen.
1. The first plate will be read and saved in Plate1, then the holder will open and eject again.  Remove the plate, pipette the m-cresol dye in the plate, then place back in the holder and, as in the previous step, close the holder.
1. The plate will shake for 30 seconds, then the plate will be read and saved in Plate2, then the holder will open and eject.



<a name="Prepare_Well_Plate_SOP"></a>
## Protocol for preparing a well plate to use with the SpectraMax iD3 Spectrophotometer


**Contents**  
* [**Well plate housekeeping**](#well_plate_housekeeping) 
* [**Filling the well plate**](#filling_the_well_plage)
* [**Adding m-cresol**](#adding_m_cresol)
* [**Cleaning and storage**](#cleaning_and_storage)

<a name="well_plate_housekeeping"></a> **Well plate housekeeping**  

1. When handling well plates, be careful to not touch the bottom of the plate with bare hands/gloves or place the plate on any surface that may scratch it.  For absorbance readings, light is projected through the bottom of the plate and any disturbed surface will likely affect the reading.  Place on kim wipes when set down, and hold by the sides when carrying/handling.
1. Each well has a maximum volume of 340uL, but it is advisable to not greatly exceed 300uL, especially if shaking before your read.


<a name="filling_the_well_plate"></a> **Filling the well plate for pH measurements using m-cresol**

1. Refer to your plate template on the SMP7 software to make sure you pipette your samples into their designated wells.
1. Place your sample vials in a water bath at the desired temperature (e.g., 25degC)
1. Once your samples and the spec are at temperature, use a 1000uL pipette with a new tip per sample (use the same tip for each set of replicates) to pipette **300uL** of sample into each well of a clean well plate (no scratches or smudges on the bottom of the plate).
  1. Be quick so your sample does not shift from the desired temperature (if your ambient room temperature is not the same)
  1. If you are concerned about a steep temperature change of your samples during this pipetting stage:
    1. Refer to the [Plate Read Setup SOP](#Plate_Read_Setup_SOP) to change the read settings to "Well" (as opposed to Row or Column).
    1. By changing the read settings to Well, the spec with scan each well for all designated wavelengths before moving to the next well (compare to Row, which will scan all wells at one wavelength before scanning all wells at the next wavelength).
    1. When pipetting your sample into the wells, start from the last well that will be read (the most bottom right well) and work backwords, the last pipetted well being the first well to be read (the most upper left well).
    1. This will allow the spec to read samples closest to your set temperature first, while any wells that may have cooled down will have time to come back up to temperature inside the spec.
1. Immediately place your well plate into the Spec on the reader tray and run your samples.

<a name=adding_m_cresol></a> **Adding m-cresol**

1. Safety Precautions
  1. Always wear gloves when handling m-cresol and other potentially harmful substances.
  1. Keep chemicals sealed and properly stored in the fume hood when not in use.
  1. Always dispose of solid and liquid waste properly in labeled containers.
1. If you need to add m-cresol to your well plate after a first run through teh Spec, use a 10 uL pipette to pipette **5 uL** of m-cresol into each well.
  1. Be quick so your sample does not shift from the desired temperature, but also be careful to maintain precision amongst your wells. 
1. Immediately place your well plate into the Spec on the reader tray and run your samples again, saving them to a new plate ([in SMP7](#Plate_Read_Setup_SOP))

<a name=cleaning_and_storage></a> **Cleaning and storage**

1. Once finished with the plate, use DI water to rinse out the wells, and dispose of both the initial contents and the rinse solution as needed per the contents' waste procedures.
  1. If using any solutions with Mercuric Chloride (HgCl2) use the large beaker labeled "HgCl2" to dump the contents and into which to rinse with DI.  Pour these contents from the beaker into a proper waste container.
  1. Note that liquid waste with m-cresol should be stored separately from liquid waste without m-cresol (ex. one waste container for HgCl2 waste, and one for m-cresol and/or m-cresol with HgCl2 waste)
1. Let the plate dry on kim wipes and covered on top by kim wipes, and/or use only kim wipes to wipe away any remaining DI water, again being careful to not disturb (smudge or scratch) the bottom surface of the plate.

<a name=Export_Data_SOP></a>
## Protocol for exporting data and protocols from the SpectraMax iD3 Spectrophotometer using the SoftMax Pro 7 (SMP7) software

**Contents**  
* [**Exporting Data**](#Exporting_data)  
* [**Saving Protocols and Data Files**](#Saving_protocols)  

<a name=Exporting_data></a> **Exporting Data**  

1. Open the SoftMax Pro 7 program from the desktop.
1. From the Home screen, select Export in the Template Tools ection of the upper menu.  This exported file contains the well ID's you provided in your plate map prior to your read.  Change "Save as Type" to .xls
    1. Save your plates using the following as a guideline: (name)_(date)_Template.xls
1. To export your read values, click on the "File" tab which is depicted by an encirculed well plate icon in the upper lefthand corner of the program screen to reveal a dropdown menu.
1. Select Export, then click export to XML XLS TXT.
1. In the export options window, select each plate you want to export; select to either export just the raw data, just the reduced data, or both (if you set "blanks" in your well plate template earlier, it is suggested to export either the raw data or both raw and reduced, rather than just reduced).  In Output Format, select Plate (.txt or .xls).  Change "Save as Type" to .xls
1. Save your plates using the following as a guideline: (name)_(date)_Plate.xls
    1. Files are exported as .xls files, so once saved, you will need to open the file and save as a .csv to access in R.

<a name=Saving_protocols></a> **Saving Protocols and Data Files**  

1. If you intend to use the same well plate configuration and possibly same plate ID's for future plate reads, you can save your plate settings as a Protocol.
1. Save your protocol (plate configuration and map settings) in the following folder location on the lab computer: C drive > Users > Public > Public Documents > pH_Spec_Protocols > (Your Folder)
1. Save as a protocol file .spr using the following as a guideline: (name)_(date)_Protocol.spr
1. To save your read data as a data file, follow the same process, but save as a data file .sda
    1. You can open a data file in SoftMax Pro to work with your data later in the program and subsequently export later on using the above steps.


<a name="pH_SOP"></a>
## Protocol for measuring pH on the spectrophotometer using m-cresol Purple dye

**Tris Read**

1. Before measuring absorbance of your seawater samples, first check that both the spec is functioning normally and m-cresol dye is still providing accurate results.
2. When setting up your plate map, 





