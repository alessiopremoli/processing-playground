float linesHeight;
float linesWidth;
float linesPerRow = 368;
float lines = 4;

import ddf.minim.*;
import ddf.minim.analysis.*;
Minim minim;

// Set the size of the FFT to be used for frequency analysis
int fftSize = 1024;
// Create an array to hold the frequencies for each second of the song
float[] frequencies;
int[] result;

public void settings() {
  size(1840, 1840);
 
}

void setup() {
  surface.setResizable(true);
  noLoop();
}

void draw() {
  linesHeight = height / lines;
  linesWidth = width / linesPerRow;
  
  result = getFrequencies("song.mp3");
  println(result, result.length);
  
  noStroke();
  
  println(linesHeight, linesWidth, linesPerRow);
  int trace = 0;
  for(int y = 0; y <= lines - 1; y++) {
    
     for(int x = 0; x <= linesPerRow; x++) {
       
       fill(frequencies[trace]);
       trace++;
       rect(float(x) * linesWidth, float(y) * linesHeight, linesWidth, linesHeight);
     }
  }
}

// This function takes in the path to an audio file and returns an array of frequencies for each second of the song
int[] getFrequencies(String filePath) {
  // Load the audio file
  Minim minim = new Minim(this);
  AudioPlayer player = minim.loadFile(filePath);

  // Get the length of the song in seconds
  int songLength = player.length();

  // Initialize the array to hold the frequencies
  frequencies = new float[songLength];

  // Create an FFT object to perform frequency analysis
  FFT fft = new FFT(fftSize, player.sampleRate());

  // Loop through each second of the song
  for (int i = 0; i < songLength; i++) {
    println(i, songLength);
    // Read audio data for the current second
    player.play();
    player.skip((int) (i * player.sampleRate()));

    // Perform frequency analysis on the audio data
    fft.forward(player.left.toArray());

    // Calculate the mean frequency for the current second
    float sum = 0;
    for (int j = 0; j < fftSize; j++) {
      sum += fft.getFreq(j);
    }
    float mean = sum / fftSize;

    // Add the mean frequency to the array
    frequencies[i] = mean;
  }

  // Create an array to hold the frequencies mapped to the 0-255 interval
  int[] mappedFrequencies = new int[songLength];

  // Map the frequencies to the 0-255 interval
  for (int i = 0; i < songLength; i++) {
    mappedFrequencies[i] = (int) map(frequencies[i], 0, player.sampleRate()/2, 0, 255);
  }

  // Return the array of frequencies
  return mappedFrequencies;
}
