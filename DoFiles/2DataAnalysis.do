/* MERGES ADULT DATASET FROM 2017 TO THE FAMILY DATA FROM 2017 TO CONTAIN INCOME
CHANGE FOR YOUR DIRECTORY*/
use "C:\Users\derek\OneDrive\Desktop\SRAResearch\Data\2017"
merge 1:1 _n using "C:\Users\derek\OneDrive\Desktop\SRAResearch\Data\NHIS2017\family2017.dta"
save "C:\Users\derek\OneDrive\Desktop\SRAResearch\Data\2017", replace