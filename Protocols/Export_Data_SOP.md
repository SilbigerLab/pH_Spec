# Protocol for exporting data and protocols from the SpectraMax iD3 Spectrophotometer using the SoftMax Pro 7 (SMP7) software

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
