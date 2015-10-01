import processing.sound.*;

FFT fft;
AudioIn in;
int bands = 1024;
int sensitivity = 300;
int bandFactor = 35;
float[] spectrum = new float[bands];

void setup() {
  colorMode(HSB, 100, 100, 100);
  size(1024, 800);
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
  background(0,0,100);
  fft.analyze(spectrum);
  //spectrogram();
  drawBars();
}


void drawBars(){
float maxVal= 0;
  int maxBand =0;
  for(int i = 0; i < bands; i++){
    if ( spectrum[i] > maxVal ){
      maxVal = spectrum[i];
      maxBand = i;
    }
  }
  bandFactor = min(100, max(20, 200 * mouseX/width));
  float valueFactor = max(1.0, 10.0 * mouseY/height);
  println(valueFactor);
  float value = sensitivity * valueFactor * maxVal;
  
  stroke(min(100,value), 100, 100); 
  int x = bandFactor * maxBand;
  fill(min(100,value/2), 100, 100); 
  background(min(100, 20+value/3), 20, 100);
  ellipse(x, height/2, value, value);
  
}

void spectrogram(){
   int bars = 100;
  int barWidth = width/bars;
  for(int i = 0; i < bands; i++){
  // The result of the FFT is normalized
  // draw the line for frequency band i scaling it up by 5 to get more amplitude.
    strokeWeight(1);
    float value = spectrum[i]*sensitivity;
    stroke(value, 100, 100); 
    line( i*barWidth, height, i*barWidth, height-value);
  }
}
  