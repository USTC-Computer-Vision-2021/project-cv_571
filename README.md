[![Open in Visual Studio Code](https://classroom.github.com/assets/open-in-vscode-f059dc9a6f8d3a56e377f745f24479a46679e63a5d9fe6f495e02850cd0d8118.svg)](https://classroom.github.com/online_ide?assignment_repo_id=6638949&assignment_repo_type=AssignmentRepo)
# Image Stitching
Implementation of Feature-Based Image Registration Method<br>
胡少佳 PB17061177

## Problem Description
Image stitching technology is to stitch several images of ordered and repeated areas in the same scene into a single panorama. It is widely used in the military and civilian fields, such as the acquisition of battlefield wide-area scenes, satellite remote sensing images, video surveillance, etc. Image stitching is the use of image registration and image fusion technology to form a plurality of partially overlapping images into a wide viewing angle, as new as possible without distortion and without gaps. The registration of images is the core technology of image stitching. The principle is to find the position of the feature points of the original image and the reference image, and then use a certain algorithm to establish a model transformation between the reference image and the registered image to determine the overlap of the two images.

## Theory Analysis
We will use two classic feature–based image registration algorithms, SIFT and SURF.
