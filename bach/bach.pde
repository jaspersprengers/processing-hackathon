//import processing.sound.*;

String baseDirectory = "C:/dev/processing-hackathon/bach/";

BufferedReader reader;
ArrayList<String> lines = new ArrayList();
int currentLine =0;
String line;
float width = 1024;
float height = 700;
float time;
//int note;
//int velocity;
float tempo = 0.7;
float transpose = 0;
PFont f;

//SinOsc sinOsc;
 
void setup() {
  size(1024, 700);
  f = createFont("Arial",50,true);
  //sinOsc = new SinOsc(this);
  //sinOsc.play();
  // Open the file from the createWriter() example
  loadFile();
}
 
void loadFile() {
  reader = createReader(baseDirectory+"prelude.csv"); 
  try {
    line = reader.readLine();
  while (line != null){    
      lines.add(line);  
      line = reader.readLine();
  }
  }catch(Exception e){
    noLoop();
  }
}
  
 
void draw() {
  float now = millis();
  currentLine = currentLine == lines.size() ? 0 : currentLine;
  //transpose = 20 * (mouseX == 0 ? width : float(mouseX)/width); 
    if ( time < now ){    
    line = lines.get(currentLine); 
    currentLine++;
    //sinOsc.freq(getHertzForNote(note));
    //sinOsc.amp(1.0);
    processNewLine(now, line);
  }
} 

void processNewLine(float millisRunning, String line){
   String[] pieces = split(line, "|");
    time = (1/tempo) * float(pieces[0]);
    int note = int(pieces[1]);
    int velocity = int(pieces[2]);   
     if ( abs(time-millisRunning) < 10){
      //println("time: "+time+" Note: "+note+" Duration:"+velocity);
      //println(transpose);
      processNote(note,velocity);
      
    }    
}

void processNote(int note, int velocity){

    background(0);
      fill(255-(3*note), 1.8*note, time/300 );
      int elWidth = 50+(7*note);
      int elHeight = 50+(5*note);
      ellipse(width/2, height/2, elWidth, elHeight);     
      int fontSize = int(2.3*note);
      textFont(f, fontSize);
      fill(255);                        
      text(note+"",width/2 - fontSize/2, height/2);
}



float getHertzForNote(int note){
  //69 = 440
  int noteOffset = int(transpose) + (note-69); 
  float factor= pow(1.059463, noteOffset);
  float noteHz = 440.0 * factor;
  
  return noteHz;
}