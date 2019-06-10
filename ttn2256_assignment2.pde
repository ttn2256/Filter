PImage img;
PImage img2;

float[][] kernel1 = {{ -1, -1, -1}, 
                    { -1,  9, -1}, 
                    { -1, -1, -1}};

float v = 1.0;
float[][] kernel2 = {{ v, v, v}, 
                    { v, v, v}, 
                    { v, v, v}};

float[][] kernel3 = {{ 0.0625, 0.125, 0.0625 }, 
                    { 0.125, 0.25, 0.125 }, 
                    { 0.0625, 0.125, 0.0625 }};
                    
float[][] kernelx = {{-1, 0, 1}, 
                    {-2, 0, 2}, 
                    {-1, 0, 1}};

float[][] kernely = {{-1, -2, -1}, 
                    {0,  0,  0}, 
                    {1,  2,  1}};


                    
void setup() {    
    surface.setResizable(true);
    img = loadImage ("Husky.png");
    surface.setSize(img.width,img.height);
    img2 = loadImage ("Husky.png");
    
    
}

void draw() {
  image (img2, 0, 0);
 
}

void keyPressed() {
    //apply filkter on image and save to buff
    if (key == '0') {
      img2.copy(img, 0, 0, img.width, img.height, 0, 0, img2.width, img2.height);
    }
    
    if (key == '1') {
      img2.copy(img, 0, 0, img.width, img.height, 0, 0, img2.width, img2.height);
      for (int x = 0; x < img2.width; x++) {
        for (int y = 0; y < img2.height; y++) {

          int index = x + y*img2.width;
          float red = red(img.pixels[index]);
   
          img2.pixels[index] = color(red);
        }
      }
    
      img2.updatePixels(); 

    }
    
    if (key == '2') { 
      img2.copy(img, 0, 0, img.width, img.height, 0, 0, img2.width, img2.height);
      for (int y = 1; y < img2.height-1; y++) {   // Skip top and bottom edges
        for (int x = 1; x < img2.width-1; x++) {  // Skip left and right edges
          float red = 0;
          float green = 0;
          float blue = 0; 
          for (int ky = -1; ky <= 1; ky++) {
            for (int kx = -1; kx <= 1; kx++) {
              // Calculate the adjacent pixel for this kernel point
              int pos = (y + ky)*img2.width + (x + kx);
              // Image is grayscale, red/green/blue are identical
              red = red(img.pixels[pos]);
              green = green(img.pixels[pos]);
              blue = blue(img.pixels[pos]);
              // Multiply adjacent pixels based on the kernel values
              red += kernel2[ky+1][kx+1] * red;
              green += kernel2[ky+1][kx+1] * green;
              blue += kernel2[ky+1][kx+1] * blue;
            }
          }
          
          img2.pixels[y*img2.width + x] = color(red, green, blue);
       }
     }
      img2.updatePixels();
    
    }
    
    if (key == '3') {
      img2.copy(img, 0, 0, img.width, img.height, 0, 0, img2.width, img2.height);
      
      
      
      for (int x = 1; x < img2.width-1; x++) {
        for (int y = 1; y < img2.height-1; y++) {
          
          float red = 0;
          float green = 0;
          float blue = 0; 
          
          for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
              int index = (x + i - 1) + img2.width*(y + j - 1);
              red += red(img.pixels[index]) * kernel3[i][j]; 
              green += green(img.pixels[index]) * kernel3[i][j]; 
              blue += blue(img.pixels[index]) * kernel3[i][j]; 
             
            }
          }
          
          red = constrain (abs(red), 0, 225);
          green = constrain (abs(green), 0, 225);
          blue = constrain (abs(blue), 0, 225);
          
          img2.pixels[y*img2.width + x] = color(red, green, blue);
          
       }
    }
    img2.updatePixels();
    }
    
    if (key == '4') {
      img2.copy(img, 0, 0, img.width, img.height, 0, 0, img2.width, img2.height);
    
      for (int x = 1; x < img2.width -1; x++) {
         for (int y = 1; y < img2.height -1; y++) {
           
           float red = 0.0;
           float green = 0.0;
           float blue = 0.0;
           
           float mag = 0.0;
           float magX = 0.0; 
           float magY = 0.0; 
         
           for (int i = 0; i < 3; i++) {
             for (int j = 0; j < 3; j++) {
               int index = (x + i - 1) + img2.width*(y + j - 1);
               // Image is grayscale, red/green/blue are identical
               red = red(img.pixels[index]);
               green = green(img.pixels[index]);
               blue = blue(img.pixels[index]);
              
               float val1 = (red + green + blue)/3;
               
               // Multiply adjacent pixels based on the kernel values
               magX += kernelx[i][j] * val1;
             }
           }
         
           for (int i = 0; i < 3; i++) {
             for (int j = 0; j < 3; j++) {
               int index = (x + i - 1) + img2.width*(y + j - 1);
               // Image is grayscale, red/green/blue are identical
               red = red(img.pixels[index]);
               green = green(img.pixels[index]);
               blue = blue(img.pixels[index]);
               
               float val2 = (red + green + blue)/3;
               
               // Multiply adjacent pixels based on the kernel values
               magY += kernely[i][j] * val2;
         
              }  
           }
           
           mag = constrain( (sqrt( (magX * magX) + (magY * magY))), 0, 255);        
           img2.pixels[y*img2.width + x] = color(mag);   
          
          }
       }
       img2.updatePixels();
    }
}