import processing.serial.*;

Serial myPort;
PImage[] images;
int currentImage = 0;

void setup() {
  size(800, 600);
  printArray(Serial.list()); // check available serial ports
  myPort = new Serial(this, Serial.list()[1], 9600); // update index if needed

  String[] imageFiles = {"image1.png", "image2.png", "image3.png"};
  images = new PImage[imageFiles.length];
  for (int i = 0; i < imageFiles.length; i++) {
    images[i] = loadImage(imageFiles[i]);
  }
}

void draw() {
  background(0);
  imageMode(CENTER);
  image(images[currentImage], width/2, height/2, width, height);
}

void serialEvent(Serial myPort) {
  String inString = myPort.readStringUntil('\n');
  if (inString != null) {
    inString = trim(inString);
    if (inString.equals("NEXT")) {
      currentImage = (currentImage + 1) % images.length;
      println("Switched to image " + currentImage);
    }
  }
}
