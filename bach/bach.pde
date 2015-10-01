import processing.sound.*;
//dimensions of the canvas in pixels
float width = 1024;
float height = 700;
// tempo in proportion to original note duration; < 1 faster, >1 slower
float tempo = 1;

float baseLine = (height/2)+100;
int noteDistance = 10;

//interal: don't touch
ArrayList<String> lines = new ArrayList();
int currentLine =0;
long time;
int currentNote;
int currentVelocity;
int horizontalNotePosition = 50;
float millisOffset=0;

SinOsc sinOsc;
 
void setup() {
  colorMode(HSB, 100, 100, 100);
  background(100);
  size(1024, 700);
  sinOsc = new SinOsc(this);
  sinOsc.play();
  loadFile();
}
 
void draw() {
  float now = millis() - millisOffset;
  if ( currentLine == lines.size() ){
    //start the loop over again
    currentLine = 0;
    millisOffset = now;
    now = 0;
  }  
  if ( time < now ){    
    String line = lines.get(currentLine); 
    currentLine++;
    sinOsc.freq(getHertzForNote(currentNote));
    sinOsc.amp(1.0);
    processNewLine(line);
  }
} 

void processNewLine(String line){
   String[] pieces = split(line, "|");
    time = int(tempo * float(pieces[0]));
    currentNote = int(pieces[1]);
    currentVelocity = int(pieces[2]);   
    drawNewNote();      
}

void drawNewNote(){
    if ( currentVelocity == 0)
      return;
    advanceNote();    
    float noteHeight = baseLine - (noteDistance * (currentNote-43 ));        
    strokeWeight(3);
    int saturation = 100;//int(10 + 90 * (horizontalNotePosition / width));
    fill(currentNote*3 % 100, saturation, 100 );   
    stroke(currentNote*3 % 100, saturation, 100); 
    line(horizontalNotePosition+14,noteHeight,horizontalNotePosition+14,noteHeight-40);        
    ellipse(horizontalNotePosition, noteHeight, 28, 16);    
}

void advanceNote(){
  if ( horizontalNotePosition > width-50){
    clear();  
    background(100);
    horizontalNotePosition= 50;
  } else {
    horizontalNotePosition += 40;
  }
}

float getHertzForNote(int note){
  //note 69 = 440 Hertz
  int noteOffset = note-69; 
  float factor= pow(1.059463, noteOffset);
  float noteHz = 440.0 * factor;  
  return noteHz;
}


void loadFile() {
  BufferedReader reader = createReader("allemande.csv"); 
  try {
    String line = reader.readLine();
  while (line != null){    
      lines.add(line);  
      line = reader.readLine();
  }
  }catch(Exception e){
    noLoop();
  }
}
  