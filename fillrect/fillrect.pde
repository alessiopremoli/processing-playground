JSONArray values;
int idx = 0;
int size = 10;
PrintWriter output;
boolean SAVE_MATRIX = true;
int[][] positionMatrix = new int[192][108];

void setup() {
  size(1920, 1080);

  values = loadJSONArray("final.json");
  output = createWriter("res.txt"); 
  preparePositionMatrix();
}

void draw() {   
}

void fillAll() {

  if (idx > values.size() - 1) {
    println("finishes");
    return;
  }

  JSONObject value = values.getJSONObject(idx);
  float percentage = value.getFloat("value");
  float check = percentage * (width*height/100);
  print(check);

  int count = 0;
  IntList cells = new IntList();

  for (int x = 0; x < width; x += size) {
    for (int y = 0; y < height; y += size) {
      if (count <= check) {
        cells.append(1);
      } else {
        cells.append(0);
      }
      count++;
    }
  }
 
  
  count = 0;
  
  for (int x = 0; x < width; x += size) {
    for (int y = 0; y < height; y += size) {
      int v = cells.get(count);

      stroke(164, 153,179, 20);
      fill(83, 75, 98);
      rect(x, y, size, size);
      if(v == 0) {
        println(count);
        int[] position = findInMatrix(count);
        // stroke(83, 83, 83);
        fill(27,23,37);
        rect(position[0], position[1], size, size);
      }
      count++;
    }
  }
}

void mouseClicked() {
  println("click " + idx);
  fillAll();
  idx++;
}

int[] findInMatrix(int idx) {
  int[] res = new int[2];
  for(int j = 0; j < 108; j++) {
    for(int i = 0; i < 192; i++) {
      if(positionMatrix[i][j] == idx) {
        res[0] = i * 10;
        res[1] = j * 10;
        println(idx, i, j);
        break;
      }
    }
  }
  
  return res;
}

void preparePositionMatrix() {
int t = 0;
   int x = 0; 
   int y = 0;
   int left = -1;
   int top = 0;
   int right = (width/10);
   int bottom = (height/10);
   String direction = "right";
   
   while(t < 192 * 108) {
     positionMatrix[x][y] = t;
     
    if(x == right - 1) {
      if(y == top) {
        direction = "bottom";
        left+=1;
      } else if(y == bottom - 1) {
        direction = "left";
        top+=1;
      }
    } else if (x == left) {
      if(y == top && t != 10000) {
        bottom-=1;
        direction = "right";
      } else if(y == bottom -1) {
        right-=1;
        direction = "top";
      }
    }
    
     if(direction == "right") {
        x+=1;
      } else if(direction == "bottom") {
        y+=1;
      }
      else if(direction == "left") {
        x-=1;
      } else if(direction == "top") {
        y-=1;
      }     
    t++; 
   }
   
   if(SAVE_MATRIX) {
     for(int j = 0; j < 108; j++) {
       for(int i = 0; i < 192; i++) {
         output.print(nf(positionMatrix[i][j], 5) + " ");
       }
       
       output.println();
     }
     
    output.flush(); // Writes the remaining data to the file
    output.close(); // Finishes the file
   }
   
   println("matrix saved");
}
