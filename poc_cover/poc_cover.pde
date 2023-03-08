float linesHeight;
float linesWidth;
float linesPerRow = 368;
float lines = 4;
boolean PROCESS_AUDIO = true;
int fftSize = 1024;
float[] frequencies;
int[] result;

import ddf.minim.*;
import ddf.minim.analysis.*;
Minim minim;

public void settings() {
  size(1104, 1104);
 
}

void setup() {
  surface.setResizable(true);
  noLoop();
}

void draw() {
  linesHeight = height / lines;
  linesWidth = width / linesPerRow;
  
  println(linesWidth);
  
  if(PROCESS_AUDIO) {
    result = getFrequencies("song.mp3");
    saveToFile();
  } else {
    result = loadFromFile();
  }
  
  noStroke();
  
  int trace = 0;
  for(int y = 0; y <= lines - 1; y++) {
    
     for(int x = 0; x <= linesPerRow - 1; x++) {
       fill(result[trace]);
       trace++;
       rect(float(x) * linesWidth, float(y) * linesHeight, linesWidth, linesHeight);
     }
  }
  
  saveFrame("test-###.png");
}

// This function takes in the path to an audio file and returns an array of frequencies for each second of the song
int[] getFrequencies(String filePath) {
  // Load the audio file
  Minim minim = new Minim(this);
  AudioPlayer player = minim.loadFile(filePath);

  // Get the length of the song in seconds
  int songLength = floor(player.length() / 1000);

  // Initialize the array to hold the frequencies
  frequencies = new float[songLength];

  // Create an FFT object to perform frequency analysis
  FFT fft = new FFT(fftSize, player.sampleRate());

  // Loop through each second of the song
  for (int i = 0; i < songLength; i++) {
    // Read audio data for the current second
    player.play();
    // player.skip(1000);
    delay(1000);
    // Perform frequency analysis on the audio data
    fft.forward(player.left.toArray());

    // Calculate the mean frequency for the current second
    float sum = 0;
    for (int j = 0; j < fftSize; j++) {
      sum += fft.getFreq(j);
    }
    float mean = sum / float(fftSize);

    // Add the mean frequency to the array
    frequencies[i] = mean;
    println(mean);
  }

  // Return the array of frequencies
  return mapFrequencies(songLength);
}

void saveToFile() {
  String[] resultsToSave = new String[result.length];
  
  for(int k = 0; k <= result.length - 1; k++) {
    resultsToSave[k] = str(result[k]);
  }
  saveStrings("frequencies.txt",resultsToSave);
}

int[] loadFromFile() {
  String[] lines = loadStrings("frequencies.txt");
  frequencies = new float[lines.length];
  for(int k = 0; k <= lines.length - 1; k++) {
    frequencies[k] = float(lines[k]);
  }
  
  return mapFrequencies(lines.length);
}

int[] mapFrequencies(int l) {
  int[] mappedFrequencies = new int[l];

  // Map the frequencies to the 0-255 interval
  for (int i = 0; i < l; i++) {
    mappedFrequencies[i] = (int) map(frequencies[i], 0, max(frequencies), 0, 255);
  }
  return mappedFrequencies;
}
