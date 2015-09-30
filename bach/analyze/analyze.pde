import processing.sound.*;

FFT fft;
AudioIn in;
int bands = 512;
float[] spectrum = new float[bands];

void setup() {
  colorMode(HSB, 100, 100, 100);
  size(800, 600);
  background(255);
    
  // Create an Input stream which is routed into the Amplitude analyzer
  fft = new FFT(this);
  in = new AudioIn(this, 1);
  
  // start the Audio Input
  in.start();
  
  // patch the AudioIn
  fft.input(in, 512);
}      

void draw() { 
  background(255);
  fft.analyze(spectrum);
  int bars = 100;
  int barWidth = width/bars;
  int sensitivity = 900;
  for(int i = 0; i < bars; i++){
  // The result of the FFT is normalized
  // draw the line for frequency band i scaling it up by 5 to get more amplitude.
    strokeWeight(barWidth);
    float value = spectrum[i]*sensitivity;
    stroke(value, 100, 100); 
    line( i*barWidth, height, i*barWidth, height-value);
  } 
}