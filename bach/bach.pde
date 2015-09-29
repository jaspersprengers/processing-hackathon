//import processing.sound.*;
String baseDirectory = "C:/dev/processing-hackathon/bach/";
//dimensions of the canvas in pixels
float width = 1024;
float height = 700;
// tempo in proportion to original note duration; < 1 faster, >1 slower
float tempo = 1;
// change pitch by moving all note values n steps up or down
int transpose = 0;

float baseLine = (height/2)+100;
int noteDistance = 10;

//interal: don't touch
PFont f;
ArrayList<String> lines = new ArrayList();
int currentLine =0;
long time;
int horizontalNotePosition = 50;
float millisOffset=0;

//SinOsc sinOsc;
 
void setup() {
  colorMode(HSB, 100, 100, 100);
  size(1024, 700);
  f = createFont("Arial",50,true);
  //sinOsc = new SinOsc(this);
  //sinOsc.play();
  // Open the file from the createWriter() example
  loadFile();
}
 
void loadFile() {
  BufferedReader reader = createReader(baseDirectory+"prelude.csv"); 
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
  
 
void draw() {
  float now = millis() - millisOffset;
  if ( currentLine == lines.size() ){
    currentLine = 0;
    millisOffset = now;
    now = 0;
  }  
    if ( time < now ){    
    String line = lines.get(currentLine); 
    currentLine++;
    //sinOsc.freq(getHertzForNote(note));
    //sinOsc.amp(1.0);
    processNewLine(now, line);
  }
} 

void processNewLine(float millisRunning, String line){
   String[] pieces = split(line, "|");
    time = int(tempo * float(pieces[0]));
    int note = transpose + int(pieces[1]);
    int velocity = int(pieces[2]);   
     //if ( abs(time-millisRunning) < 10){
      //println("time: "+time+" Note: "+note+" Duration:"+velocity);
      //println(transpose);
      processNote(note,velocity);      
    //}    
}

void processNote(int note, int velocity){
    if ( velocity == 0)
    return;
    advanceNote();    
    float noteHeight = baseLine - (noteDistance * (note-43 ));        
    strokeWeight(3);        
    fill(note*3 % 100, 100, 80 );   
    stroke(note*3 % 100, 100, 80); 
    line(horizontalNotePosition+14,noteHeight,horizontalNotePosition+14,noteHeight-40);        
    ellipse(horizontalNotePosition, noteHeight, 28, 16);
    text(getNoteNameForNote(note), horizontalNotePosition, noteHeight);
}


void advanceNote(){
  if ( horizontalNotePosition > width-50){
    clear();  
    background(100);
    horizontalNotePosition= 50;
  } else {
    horizontalNotePosition += 32;
  }
}

String getNoteNameForNote(int note){
  String[] notes = new String[]{"G","G#","A","A#","B","C","C#","D","D#","E","F","F#"};
  return notes[abs((note-43) % 12)];
}

float getHertzForNote(int note){
  //note 69 = 440 Hertz
  int noteOffset = note-69; 
  float factor= pow(1.059463, noteOffset);
  float noteHz = 440.0 * factor;  
  return noteHz;
}