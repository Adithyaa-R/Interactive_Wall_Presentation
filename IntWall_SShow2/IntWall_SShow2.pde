import processing.serial.*;
Serial myPort;  // Create object from Serial class
byte[] val;      // Data received from the serial port
int linefeed = 48;
String SVal;

String[] imgName = {"1.png", "2.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png", "10.png", "11.png", "12.png", "13.png", "14.png"};
PImage[] img = new PImage[imgName.length];  // Declare variable "a" of type PImage
int[] SensV = new int[9];
boolean[] Proceed = {false, true, false, true, true, true, false, true, false, false, false, true, false, true};//if the value is False then display for a few seconds before going to the next one
long lastRun = 0;//used for slide timing AND debouncing keys.
int CurrImg = 0;//very important, the currently displayed slide.

//user variables
int slideSpd = 3000;//value of the delay between changing slides
int thresh = 30;//sensor threshold. baseline values are 1 - 19, central values spike above 45-ish, and can go upto 120~ due to crosstalks.


void setup() 
{
  //size(800, 450);
  fullScreen();
  myPort = new Serial(this, portName, 9600);
  myPort.bufferUntil(linefeed);

  for (int i = 0; i < imgName.length; i++)
  {
    img[i] = loadImage(((String)imgName[i]));
  }
}

void draw() 
{
  // Displays the image at its actual size at point (0,0)
  if ( myPort.available() > 0) // If data is available,
  {  
    splitter(getSerial());
  }
  //checkSensV();
  checkSensAll();
  background(0);
  CurrImg = constrain(CurrImg, 0, imgName.length-1);
  image(img[CurrImg], 0, 0, width, height);

  //println(CurrImg);
  SShow();
}

void SShow()
{
  if ((!Proceed[CurrImg])&&(millis() >= lastRun + slideSpd))
  {
    CurrImg = CurrImg + 1;
    println("SHOW!" +CurrImg);
    Proceed[CurrImg] = true;
    lastRun = millis();
  }
}

void keyPressed()
{
  if ((key == 115)&&(millis()>lastRun+slideSpd))//press 's' to proceed
  {
    //CurrImg = CurrImg + 1;
    SensV[8] = thresh + 20;
    //print("press");
    lastRun = millis();
  }
  if ((key == 122)&&(millis()>lastRun+slideSpd))//press <space> to Restart
  //if (key == 122)//press 'z' to Restart
  {
    CurrImg = 0;
    //print("press");
    lastRun = millis();
  }
}


void splitter(String sval2)
{
  if (sval2 == null)
  {
    return;
  }
  //print(sval2 + " ");  
  String[] spt = split(sval2, ',');

  //print(spt.length + " ");
  for (int i = 0; i < spt.length; i++)
  {
    //print(int(spt[i]));
    //print(" ");
  }

  for (int i = 3; i < spt.length; i++)
  {
    SensV[i] = int(spt[i]);
  }

  //println(CurrImg + " XXX");
}

String getSerial()
{
  SVal = myPort.readStringUntil('\n');
  //print(SVal);
  return SVal;
}

void checkSensAll()
{
  for (int i = 3; i < SensV.length; i++)//this loop scans the array and checks for any values above the threshold. Limited from 4-8th values because first 4 don't respond.
  {
    if ((SensV[i] > thresh)&&(millis() >= lastRun + slideSpd))
    {
      CurrImg = CurrImg + 1;
      println("BOOP!"+CurrImg);
      lastRun = millis();
    }
  }
}
