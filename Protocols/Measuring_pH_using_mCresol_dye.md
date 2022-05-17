# Protocol for measuring pH using m-Cresol purple dye the Silbiger Lab SpectraMax iD3 Spectrophotometer

### written by Danielle Barnas
created: 9/26/2019  
edited: 5/17/2022


**Contents**  
- [Initial setup](#Initial_setup)  
- [Mapping your plate](#Plate_map)  
- [Setting your work flow](#Work_flow)  
- [Preparing your plate](#Prepare_plate)  
- [Exporting data](#Exporting_data)  
- [Cleaning and storage](#cleaning_and_storage)  
- [Saving your protocol](#Saving_protocols)  
- [Troubleshooting](#Troubleshooting)

<a name=Initial_setup></a> **Initial setup**

1. Turn on the spec by tapping the yellow power button (lower left corner of the screen platform) with your finger.  Initial startup will take a few minutes.
1. Open the SoftMax Pro 7 program from the desktop.
    1. If the program does not automatically connect to the plate reader (depicted by an icon of the plate reader in the upper left corner of the program with a green check if connected or a circle with a line if not connected), then click on the plate reader icon for a list of available plate readers.  Select the reader and click OK.
1. To set temperature at 25 C, click Temperature and turn "Set" on and type 25.
1. Select the "Acquisition Settings" icon (two orange gears).
    1. Make sure the appropriate "Read Mode" and "Read Type" are selected.
        1. Read Mode: ABS (Absorbance)
        1. Read Type: Endpoint
    1. To select the plate type, scroll down the list of plates and select the "96 well plate Falcon clear (SilbigerLab)"
    1. In Wavelengths, use the dropdown menu to select 3 total wavelengths and type each number in: 730nm, 578nm, and 434nm
    1. Deselect Pathcheck
    1. Deselect Shake
    1. More Settings: Read Order: Well
    1. Press OK to save these settings
1. From the Document page, right click Plate1 and duplicate once until you see 2 plates under your Experiment
1. Rename the first plate as Tris1, then the next plate as Plate1.
1. In the Tris1 Acquisition Settings (two orange gears icon), select the Read area as the first three wells in column 1. These will be your initial tris triplicates.
    1. Wells highlighted in black will be read by the spec. Cells highlighted in white will be skipped.
1. In the Plate1 Acquisition Settings, select the Read area as all the wells you need to run triplicates of your samples **excluding the first three wells in column1** because these wells will still contain tris during your plate reads, but we do not want to save the tris data in these plate reads.
1. Under your Experiment tab, duplicate the Tris1 plate and call this plate Tris2. Also duplicate the Plate1 plate and call this plate Plate2.
    1. For both the Tris and Plate reads, the first plate will be run without dye, and the second plate will be run with dye. Two separate plates need to be assigned for each set of plate reads so that no data is overwritten by subsequent reads.


<a name=Plate_map></a> **Mapping your Plate**  

1. Select the Tris1 plate, then open the "Template Editor" icon (well plate icon).
    1. Click and drag your mouse over the first three wells in column one (your tris wells). Because you selected Well in the configuration settings above, you can hold down Ctrl as you select your wells.
    1. Once you've highlighted these first three wells, click Unknown on the righthand panel.
    1. Select these three wells again to provide an ID in the Sample field below the plate map (ex. Tris), then select Assign.  It is advisable to provide an ID for your wells so you can assign these to your data later when processing.
        1. Use identical ID's for any replicate wells (for post-processing in R later). Example, all three wells should be labeled as Tris, since they are replicates.
1. Once Tris wells are assigned, open the "Template Editor" for Plate 1 and click and drag your mouse over the remaining wells you intend to use for your samples. Because you selected Well in the configuration settings above, you can hold down Ctrl as you select your wells.
    1. Once you've highlighted these wells, click Unknown on the righthand panel.
    1. Select your first sample's set of triplicate wells and provide an ID in the field below the plate map, then select Assign.
    1. Repeat the above for each set of triplicate wells for each sample, using a unique ID for each sample, but idential ID within triplicates.
1. Once your plate map is completed, select OK to save your plate configuration.  If you close this window without selecting OK, your changes will not be saved.
1. You only need to map the first of your two plates for Tris and Plate reads, because the mapping template can be applied to both in post-processing.
    1. Each plate will save each run's set of data (i.e., data from your sample without m-cresol dye, and data from your sample with m-cresol)


<a name=Work_flow></a> **Setting your work flow**
1. Select WorkFlow in the lefthand panel.
1. Click and drag the following block elements along the flow line in the righthand window:
    1. "Set Temp" - "Open Drawer" - "Read Plate" - "Open Drawer" - "Shake Plate" - "Read Plate" - "Open Drawer"
1. To modify specific settings of each block element, click the pencil at the corner of the block. To select plates, click the drop down menu below the block.
    1. Set Temp: 25 C
    1. Read Plate (first): Tris1
    1. Shake Plate: 30 seconds
    1. Read Plate (second): Tris2
1. The workflow will do the following:
    1. The instrument will open the reader drawer for the first time once the temperature is at your set point (in this case, 25 degrees Celcius).
        1. If the instrument is already at 25degC when you Start the workflow, the workflow may not advance to the next step automatically.  In this case, click Pause in the upper left corner of the workflow menu, then Start again to advance to the next step of opening the drawer.
    1. Once you've placed your plate in the holder,  you must return to the Document tab and then click "Open/Close" near the top of the program screen.
    1. The first plate will be read and saved in Tris1, then the holder will open and eject again.  Remove the plate, pipette the m-cresol dye in the plate, then place back in the holder and, as in the previous step, close the holder using the Open/Close button.
    1. The plate will shake for 30 seconds, the plate will be read and saved in Tris2, then the holder will open and eject.
1. Before you run your workflow, prepare your plate.


<a name=Prepare_plate></a> **Preparing your plate**

1. When handling well plates, be careful to not touch the bottom of the plate with bare hands/gloves or place the plate on any surface that may scratch it. Place on kim wipes when set down, and hold by the sides with gloves on when carrying/handling.
1. Each well has a maximum volume of 340uL, but it is advisable to not greatly exceed 300uL, especially when shaking before your read.
1. Refer to your plate template on the SMP7 software to make sure you pipette your samples into their designated wells.
1. Place tris, your water sample vials and bottle of m-cresol in a water bath at the desired temperature (e.g., 25degC).
    1. m-Cresol Safety Precautions
        1. Always wear gloves when handling m-cresol and other potentially harmful substances.
        1. Keep chemicals sealed and properly stored in the fume hood when not in use.
        1. Always dispose of solid and liquid waste properly in labeled containers.
1. Once the samples and the spec are at temperature, use a 1000uL pipette to pipette **300uL** of tris into the first three wells of column one.
    1. To dispose of the pipette tip, release the tip in the large beaker labeled with HgCl2. Dispose of all pipette tips that have touched mercuric chloride or m-cresol in this beaker.
1. In the Workflow tab, press the green Start arrow. 
1. The instrument will open the reader drawer once the temperature is at your set point (in this case, 25 degrees Celcius).
    1. If the instrument is already at 25degC when you Start the workflow, the workflow may not advance to the next step automatically. In this case, click Pause in the upper left corner of the workflow menu, then Start again to advance to the next step of opening the drawer.
1. Gently place the plate in the holder, with A1 in the back left corner (nearest the spec).
1. Once you've placed your plate in the holder, you must return to the Document tab and then click "Open/Close" near the top of the program screen.
1. Once the three wells have been run, the drawer will open and you can remove the plate (place on kim wipes, not the bare bench).
1. Use a 10uL pipette to add **5uL** of m-Cresol purple dye to each tris well. The dye will come out as a single drop at the tip of the pipette. Be careful with a steady hand to make sure the dye ends up in each desired well.
1. Place the plate back in the spec, and click "Open/Close".
    1. You will hear the plate shaking for 30 seconds before being read by the spec again, and finally opening up to eject the plate.
1. In the Workflow tab, edit the first Read Plate block to select Plate1, and the second Read Plate block to select Plate2. You are now ready to pipette your samples.
1. Use a 1000uL pipette with a new tip per sample (can use the same tip for each set of replicates) to pipette **300uL** of sample into each well of a clean well plate (no scratches or smudges on the bottom of the plate).
  1. Be quick so your sample does not shift from the desired temperature (if your ambient room temperature is not the same)
  1. If you are concerned about a steep temperature change of your samples during this pipetting stage:
    1. When pipetting your sample into the wells, start from the last well that will be read (the most bottom right well) and work backwords, the last pipetted well being the first well to be read (the most upper left well). This will allow the spec to read samples closest to your set temperature first, while any wells that may have cooled down will have time to come back up to temperature inside the spec.
1. In the Work Flow tab, press the green Start arrow.
1. The instrument will open the reader drawer once the temperature is at your set point (in this case, 25 degrees Celcius).
    1. If the instrument is already at 25degC when you Start the workflow, the workflow may not advance to the next step automatically. In this case, click Pause in the upper left corner of the workflow menu, then Start again to advance to the next step of opening the drawer.
1. Gently place the plate in the holder, with A1 in the back left corner (nearest the spec).
1. Once you've placed your plate in the holder, you must return to the Document tab and then click "Open/Close" near the top of the program screen.
1. After samples have been run and the plate is ejected, remove the plate and once again place on kim wipes or a soft surface.
1. Use a 10uL pipette to add **5uL** of m-Cresol purple dye to each sample well.
1. Place the plate back in the spec, and click "Open/Close".
1. Once the samples have run through with the dye and the plate is ejected, remove the plate, click "Open/Close" to finish the workflow, and export your data.4af


<a name=Exporting_data></a> **Exporting Data**  

1. Create a dated folder for your readings in a folder with your name.
1. From the Home screen, select Export in the Template Tools section of the upper menu.  This exported file contains the well ID's you provided in your plate map prior to your read.  Change "Save as Type" to .xls
    1. Save your templates in your dated folder using the following as a guideline: (name)_(date)_Template.xls
1. To export your plate read values, click on the "File" tab which is depicted by an encirculed well plate icon in the upper lefthand corner of the program screen to reveal a dropdown menu.
1. Select Export, then click export to XML XLS TXT.
1. In the export options window, select each plate you want to export (Tris1, Tris2, Plate1, Plate2); select to export just the raw data. 
1. In Output Format, select Plate (.txt or .xls).  Change "Save as Type" to .xls
1. Save your plates in your dated folder using the following as a guideline: (name)_(date)_Plate.xls
    1. Files are exported as .xls files, so once saved, you will need to open the file and save as a .csv to access in R.


<a name=cleaning_and_storage></a> **Cleaning and storage**

1. Once finished with the plate, you will use DI water to rinse out the wells, and dispose of both the initial contents and the rinse solution as needed per the contents' waste procedures following instructions below.
    1. Dump out the pipette tips in the HgCl2 beaker into the Solid Waste container to the right of the fume hood in MG4109.
    1. Use this same wide-mouthed beaker labeled HgCl2 to dump contents of the plate into, and use a squeeze bottle with DI water to rinse out the wells over the beaker.
    1. Pour these contents from the beaker into a proper waste container labeled for m-cresol.
    1. Note that liquid waste with m-cresol should be stored separately from liquid waste without m-cresol (ex. one waste container for HgCl2 waste only, and one for m-cresol and/or m-cresol with HgCl2 waste)
1. Let the plate dry on top of kim wipes and covered by kim wipes over top, and/or use only kim wipes to wipe away any remaining DI water, again being careful to not disturb (smudge or scratch) the bottom surface of the plate.


<a name=Saving_protocols></a> **Saving Protocols and Data Files**  

1. If you intend to use the same well plate configuration and possibly same plate ID's for future plate reads, you can save your plate settings as a Protocol.
1. Save your protocol (plate configuration and map settings) in the following folder location on the lab computer: C drive > Users > Public > Public Documents > pH_Spec_Protocols > (Your Folder)
1. Save as a protocol file .spr using the following as a guideline: (name)_(date)_Protocol.spr
1. To save your read data as a data file, follow the same process, but save as a data file .sda
    1. You can open a data file in SoftMax Pro to work with your data later in the program and subsequently export later on using the above steps.


<a name="Troubleshooting"></a> **Troubleshooting**
1. For quick How-To videos, select the Maintenance icon (wrench) on the bottom left toolbar, then select Support.  Here you can watch videos on
    1. [Getting to know your new ID series reader](https://www.moleculardevices.com/en/assets/tutorials-videos/br/getting-to-know-your-new-spectramax-id3)
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

