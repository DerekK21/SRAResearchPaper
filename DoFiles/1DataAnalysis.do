/*MERGES ADULT DATA WITH FAMILY DATA TO CONTAIN INCOME DATA
CHANGE INTO YOUR DIRECTORY*/
use "C:\Users\derek\OneDrive\Desktop\SRAResearch\Data\2018"
merge 1:1 _n using "C:\Users\derek\OneDrive\Desktop\SRAResearch\Data\NHIS2018\family2018.dta"
save "C:\Users\derek\OneDrive\Desktop\SRAResearch\Data\2018", replace