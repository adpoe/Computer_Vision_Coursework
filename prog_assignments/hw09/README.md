# Sliding Window Object Detection (Pedestrians on the street)
@author Anthony (Tony) Poerio
@email adp59@pitt.edu

## Overall Notes
- For this assignment, our goal was to use sliding window object detection to identify pedestrians on the street in a test data set.
- There are two .m files containing code for this. The first parses information and trains a classifier. The second uses that classifier to make predictions. File names are outlined below.
- I used a subset of the whole 1GB+ data set provided for my training. My training set can be found in the folders named: `/pos_sample` and `/neg_sample`
- My test set has 15 total images (10 with people, 5 without). The test set I used can be found in the folder named `/small_test`
- After making predictions, I discovered that because the sliding window algorithm necessarily evaluates very many potential locations, I had over 1000 positive results and 17000 negative results.
    * Because I could not hand calculate precision/recall for over 1000 results, I decided to take a uniform sample from my positive responses (30 total).
    * This uniform sample was used to answer the questions in `results.txt`.
    * To view this sample see: `/uniform_sample`

## Graded Files / Folders
- The four files/folders which the assignment prompt specifically notes will be graded are:
1. **setup_and_train.m** - In this file, you will find my setup and training of the SVM classifier
2. **test.m** - This file contains my Sliding Window Object Detection implementation, using the classifier trained previously
3. **results.txt** - This file contains the written results of my testing
4. **/pos_predictions** - This folder contains 10 png files showing detections that my algorithm marked as positive. These were uniformly selected from my whole data set, which found over 1000 detections total.


## Notes and Instructions
**LINES TO CHANGE:**  
These are lines that reference folders in my relative path. Please change to fit yours. All of my folders referenced are included. You should just need to change the outermost folder location, or relative path to the zip file.
- setup_and_train.m
    * Line 18
    * Line 36
    * Line 58
    * Line 103
    * Line 163 (saves the environment variables)

- test.m  
    * Line 22 (loads the environment variables, previously saved)
    * Line 39
    * line 100
    * line 112





