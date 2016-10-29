# Compute Spatial Pyramid Representation / K-Nearest Neighbor
@author Anthony (Tony) Poerio
@email adp59@pitt.edu

## Overall Notes
- For this assignment, because there are many code dependencies (including re-use of code from previous assignments), I have included everything in my workspace, as-is.
- To get this code to work, I needed to re-visit previous code used in this class, and in almost all instances UPDATE the previous code to work with my implementation.
- As such--**please use the version of each file that I have included in this main directory for testing**--not the standard version initially provided by Dr. Kovashka.

## Graded Files
- The three files which the assignment prompt specifically notes will be graded are:
1. computeSPMHistogram.m -- this is included, and you will see the changes I implemented to get this to work. My changes are commented
2. findLabelsKNN.m -- this is included, and was written from scratch, to suit my implementation
3. main script --> named: 'getImagesAndLabels.m'. This is the main script I wrote for this project. It performs all calculations requested, and displays the accuracy results of each KNN run, upon completion.

## Notes and Instructions
* To Note:  I have used a smaller subset in my own testing, and this file still takes about 1-minute run on my computer.
* The exact files/structure I used is included, (~20 images for each category in both the testing and training sets)
* **LINES TO CHANGE:**  lines 28 and 29 in this script. That specifices the path to my **testing** and **training** folders.
* Even with only 20-images per category, the results were reasonably good. I have some randomization of exactly which features are stored (just like in the example code from HW05-P), so results may vary from run to run. But here's output from a sample run:  
>> getImagesAndLabels  
   kmeans run...  
   Accuracy for k=1:   0.196078 PERCENT CORRECT  
   Accuracy for k=5:   0.163399 PERCENT CORRECT  
   Accuracy for k=25:   0.081699 PERCENT CORRECT  
   Accuracy for k=125:   0.065359 PERCENT CORRECT  

This makes it look like a lower KNN is generally better. Though a KNN of size-1 will still suffer from inaccuracy (overfitting?) on most data sets.




