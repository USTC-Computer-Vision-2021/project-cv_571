[![Open in Visual Studio Code](https://classroom.github.com/assets/open-in-vscode-f059dc9a6f8d3a56e377f745f24479a46679e63a5d9fe6f495e02850cd0d8118.svg)](https://classroom.github.com/online_ide?assignment_repo_id=6638949&assignment_repo_type=AssignmentRepo)
# Image Stitching
Implementation of Feature-Based Image Registration Method<br>
胡少佳 PB17061177

## Problem Description
Image stitching technology is to stitch several images of ordered and repeated areas in the same scene into a single panorama. It is widely used in the military and civilian fields, such as the acquisition of battlefield wide-area scenes, satellite remote sensing images, video surveillance, etc. Image stitching is the use of image registration and image fusion technology to form a plurality of partially overlapping images into a wide viewing angle, as new as possible without distortion and without gaps. The registration of images is the core technology of image stitching. The principle is to find the position of the feature points of the original image and the reference image, and then use a certain algorithm to establish a model transformation between the reference image and the registered image to determine the overlap of the two images.

## Theory Analysis
We will use two classic feature–based image registration algorithms, SIFT and SURF.

### SIFT
SIFT (Scale Invariant Feature Transform) feature matching algorithm is a highly robust local feature descriptor that uses images produced by SIFT. The performance of eigenvectors is stable, for rotation, scaling, target occlusion, noise, etc. It has good immutability. Feature extraction mainly includes four steps.

1. Scale space extreme value detection:<br>
First, Gaussian difference tower pyramid is applied to the image to obtain a Gaussian difference image. The Gaussian difference image is then subjected to key point detection in a multi–scale range. The scale space G(x, y, σ) can be obtained by convolving the Gaussian function L(x, y, σ) with the original image.<br>
$$
L(x,y,\sigma) = G(x,y,\sigma) \times I(x,y)
$$
<br>where I(x,y) is the original image, G(x,y,σ) is a scale variable Gaussian function whose expression is as follows.<br>
$$
G(x,y,\sigma) = \frac{1}{2\pi\sigma^2}e^{-(x^2+y^2)/2\sigma^2}
$$
<br>The Gaussian difference scale space (DoG) is produced by convolving the Gaussian convolution kernels with different scales.<br>
$$
D(x,y,\sigma) = L(x,y,k\sigma) - L(x,y,\sigma)
$$
<br>When performing extreme value detection in the DoG space, it is necessary to compare the key points with 9 × 2 points of eight adjacent and upper and lower adjacent scales of the same scale, for a total of 26 points. If the key point is in the DoG scale space, the maximum and minimum of the 26 layers of the layer and the adjacent layers, then the point can be used as a feature point of the image.

2. Accurate positioning of feature points:<br>
After obtaining a large number of candidate feature points of the image, the three–dimensional quadratic function is fitted to accurately determine the position and scale of the key points, while removing the low-contrast key points and the unstable edge response points to enhance the matching stability and improve the resistance, noise capacity.

3. Character point direction calibration:<br>
Using the local properties of the image, the gradient distribution characteristics of the pixels in the key point domain are used to specify the direction parameters for each key point, thereby ensuring that the operator has rotation invariance. The gradient magnitude at a pixel (x, y) in an image can be expressed by L(x, y).At the same time, the direction of the pixel (x,y) can be expressed as<br>
$$
\theta(x,y) = \tan^{-1} \frac{L(x,y+1) - L(x,y-1)}{L(x+1,y) - L(x-1,y)}
$$
<br>With these size and orientation data, you can create a direction histogram so you can calculate the dominant direction of each key point.

4. Generation of feature descriptors:<br>
The characterization descriptor can be uniquely characterized by the gradient and direction of all points in the Gaussian window region. The 16 × 16 neighborhood around each key point is divided into sixteen 4 × 4 sub-regions, and then an 8–direction histogram is calculated and generated in each 4 × 4 sub–region. By performing the above calculation on all sub–regions of the key point, a 4 × 4 × 8 = 128 dimensional feature vector (SIFT descriptor) can be generated. Each key point can be uniquely determined by its feature vector.

### SURF
Speeded Up Robust Features (SURF) is a robust local feature point detection and description algorithm. SURF is an improvement of the Sift algorithm, which improves the exe- cution efficiency of the algorithm and provides the possibility for the algorithm to be applied in real–time computer vision systems. SURF has two great magics in terms of execution efficiency, one is the use of integral graphs on Hessian, and the other is the use of dimensionality descriptors.

1. Feature point extraction:<br>
The SURF algorithm uses Gaussian filtering to construct image pyramids and obtain image sequences in different scale spaces. Let the original image be I(x,y), and the image sequence of different scale spaces obtained by Gaussian convolution is L(x, y, σ), and σ is the image scale. Then calculate the Hessian matrix is as follows.<br>
$$
H(x,\sigma) = {
\left[
\begin{matrix}
L_{xx}(x,y,\sigma) & L_{xy}(x,y,\sigma) \\
L_{xy}(x,y,\sigma) & L_{yy}(x,y,\sigma) \\
\end{matrix}
\right]}
$$
<br>Where $L_{xx}(x,y,\sigma)$ is the convolution of Gaussian second-order differential at x with image 1, $L_{xx}(x,y,\sigma)$ is the same as $L_{yy}(x,y,\sigma)$.<br>
In digital images, Dxx, Dxy and Dyy are used to approximate Lxx, Lxy and Lyy, respectively, to construct a fast Hessian matrix discriminant to extract local maxima and determine the location of key points. The fast Hessian matrix is judged as<br>
$$
det(H) = D_{xx}D_{yy} - (\omega D_{xy})^2 > T
$$
<br>Where T is the selected threshold; ω is the compensation factor. In order to ensure the uniformity of the discriminant, ω is generally taken as 0 for different σ values and template sizes.

2. Feature point description:<br>
Centering on the feature points, calculate the Harr wavelet response in the horizontal and vertical directions of the points in the neighborhood with a radius of 6s (s is the scale value at which the feature points are located). The sum of the wavelet responses in the 60◦ sector window is counted, and the direction corresponding to the sector with the largest value is the main direction dx and dy are the horizontal and vertical wavelet responses, respectively, and w is the sector area. The corresponding direction of the area is calculated as follows.Feature point description: Centering on the feature points, calculate the Harr wavelet response in the horizontal and vertical directions of the points in the neighborhood with a radius of 6s (s is the scale value at which the feature points are located). The sum of the wavelet responses in the 60◦ sector window is counted, and the direction corresponding to the sector with the largest value is the main direction dx and dy are the horizontal and vertical wavelet responses, respectively, and w is the sector area. The corresponding direction of the area is calculated as follows.
$$
\theta_{\omega} = \arctan{\sum_{\omega}{dx}/\sum_{\omega}{dy}}
$$
<br>Centering on the feature points, divide the 20s × 20s image into 4 × 4 sub-blocks in the main direction, and calculate $\sum{dx}$, $\sum{dy}$, $\sum{|dx|}$ and $\sum{|dy|}$ in each sub-area to generate a 64–dimension feature description.

3. Feature point matching:<br>
A certain feature point F1i in the source image 1 and all the feature points in the source image 2 are first judged by the Hessian matrix trace. If the traces are in the same direction, the Euclidean distance between the two feature point descriptors is calculated. To the next point of comparison, the closest feature point in the source image 2 to the Euclidean distance is the best matching point of F1i.

## Code Implementation and Results
The SIFT algorithm runs on the MATLAB platform and the SURF algorithm is based on the C++ implementation of the OpenCV library, respectively.<br>
The two original images are shown in the Fig. 1 and Fig. 2.<br>
<p align='center'><img src='./matlab/34.jpg' style='zoom:25%;'></br>Fig. 1</p>
<p align='center'><img src='./matlab/35.jpg' style='zoom:25%;'></br>Fig. 2</p>

### SIFT
Here we use SIFT to extract the feature points of gray image, and obtain the position information and feature description of the feature points. According to the feature description of the feature points, the correlation is obtained and the threshold is set to 0.9. A feature point pair having a correlation greater than the threshold satisfies the condition of feature point matching.<br>
Using the histogram drawing function hist(X, n) in MATLAB, the distribution of the feature points to the rotation angle (the amplitude is from 0◦ to 180◦ is obtained, and a certain number of feature point pairs are selected from the range of angle values with the largest number of points. In the solution of the transfer matrix T, the final image stitching work is completed. The registration result is shown in the Fig. 3.<br>
<p align='center'><img src='./matlab/output.jpg' style='zoom:25%;'></br>Fig. 3: Registration result based on SIFT algorithm</p>
It can be seen from the registration result that the SIFT algorithm can achieve better image mosaic, but the edge of the image is not natural enough and needs further improvement.

### SURF
The SURF feature extraction algorithm is used to replace the above SIFT feature extraction, and the image fusion technology is added to make the transition of the interface more natural. Like the SIFT algorithm, the basic path of the Surf algorithm can be divided into three parts: the extraction of local feature points, the description of feature points, and the matching of feature points. The C++ implementation based on Opencv library achieves the ideal effect. The feature matching based on SURF algorithm is shown in the Fig. 4, in addition, the registration result is shown in the Fig. 5.<br>
<p align='center'><img src='./opencv/first_match.jpg' style='zoom:25%;'></br>Fig. 4: Feature matching based on SURF algorithm</p>
<p align='center'><img src='./opencv/dst.jpg' style='zoom:25%;'></br>Fig. 5: Registration result based on SURF algorithm</p>
The SURF–based registration algorithm has achieved excellent results and is intuitively better than SIFT–based algorithm which can be seen from the above figures. Furthermore, this report makes a quantitative comparison of the two algorithms. Table I gives the number of features extracted by the two algorithms. It can be seen from the Table I that the SURF algorithm achieves faster (Related to the implementation tool) image registration and requires fewer feature matching points. However, both algorithms achieve high accuracy.<br>
TABLE I: Comparison of SIFT and SURF

Algorithm|Feature points|Time|Accuracy rate(%)
---------|--------------|-----|-----------------
SIFT|594|126|81
SURF|67|18.4|84

## Code Structure
```
.
├── README.md
├── matlab
│   ├── code
│   │   └── Pro2_main.m
│   ├── input
│   │   ├── 34.jpg
│   │   └── 35.jpg
│   └── output
│       └── output.jpg
└── opencv
    ├── code
    │	└── Pro2.cpp
    ├── input
    │	├── 1.jpg
    │	└── 2.jpg
    └── output
    	└── dst.jpg
```

## Quick Start
### SIFT
run Pro2_main.m
### SURF
run Pro2.cpp
