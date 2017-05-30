# Face_Detection
Face detection with haarcascade.
haarcascade_frontalface_alt.xml is used as classifier.
Visual Studio 2015 and OpenCV 3.1.0 .
Precompiled header file is used in Visual ( #include "stdafx.h" ).

* 'face_live_using_Raspberry_Pi' 
can be runned in the Raspberry Pi. When compile this folder open terminal in the current folder (F4) and write 
'g++ $(pkg-config --libs --cflags opencv) -o face_live_using_Raspberry_Pi face_live_using_Raspberry_Pi.cpp' onto the terminal.
