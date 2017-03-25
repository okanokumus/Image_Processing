# Hough_Transform
Own implementation of Hough transform to detect lines.
(Homework)

4 subfunctions are used in main function when solving problem.

Below steps are followed:

STEP 1: Apply Canny edge detector to the image "pentagon.png" using MATLAB's edge function.
Obtain the edge map E(x,y). Display the original image and the edge map.

STEP 2: Initialize a KxL zero matrix that will serve you as the Hough table. The rows will
correspond to angles [teta1, teta2,... tetaK], where teta1 = -90 and tetaK = 90-delta_teta. The
columns will correspond to rho's [rho_min, rho_min+delta_rho,..., rho_max].
Set delta_teta to 0.5.
Set delt_rho to 1.

STEP 3: Apply the following procedure to cast votes into the Hough table.
For each edge pixel E(x,y)
For each teta from teta1 to tetaK
Calculate rho corresponding to the line with teta and passing through (x,y)
Find the corresponding row and column indices in the Hough table (i,j)
Update H(i,j) = H(i,j) + 1;
NOTE : Be very careful with MATLAB's sin and cos functions. Their arguments should be in
radian units. If your angles are in degrees, you should use sind and cosd.

STEP 4: Display the Hough table using imshow.

STEP 5: Suppress the nonmaxima in the Hough table. Check the 8-neighbours of each value in H,
if it is greater than all its 8 neighbours keep it; if not set it to zero. Display the resulting Hough
table.

STEP 6: Find the locations of five highest values in the Hough table. Indicate them with a red star
on top of the Hough table. Which teta and rho they correspond to? List their values.

STEP 7: Draw the five lines with the parameters you found in Step 6 on top of the original image
"pentagon.png". You can use MATLAB’s line or plot functions, whichever you prefer. Draw
each of the five lines in different colors.
