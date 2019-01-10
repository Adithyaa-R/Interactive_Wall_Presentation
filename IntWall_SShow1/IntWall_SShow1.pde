import processing.serial.*;

Serial myPort;  // Create object from Serial class
byte[] val;      // Data received from the serial port
int linefeed = 48;
String SVal;

String[] imgName = {"1.jpg", "2.jpg", "3.jpg", "4.jpg", "5.jpg", "6.jpg", "7.jpg", "8.jpg", "9.jpg", "10.jpg", "11.jpg", "12.jpg"};
PImage[] img = new PImage[imgName.length];  // Declare variable "a" of type PImage
int[] SensV = new int[8];
int[] SensT = {800,800,500,500,500,500,500,500};//threshold levels for detecting touch.

//PImage dimg;
int CurrImg = 0;
void setup() 
{
  size(640, 360);
  //fullScreen();
  String portName = Serial.list()[0];//serial 
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
  checkSensV();
  background(0);
  //println(CurrImg);
  image(img[CurrImg], 0, 0);
  
}

void keyPressed()
{
  CurrImg = key-48;
}

void splitter(String sval2)
{
  sval2 = trim(sval2);
  //print(sval2 + " ");
  String[] spt = split(sval2, '\t');
  //print(spt.length + " ");
  for (int i = 0; i < spt.length; i++)
  {
    //print(spt[i]);
    //print(" ");
  }
  //println(" XXX");
}

String getSerial()
{
  SVal = myPort.readString();
  return SVal;
}

void checkSensV()
{
  for (int i = 0; i < SensV.length; i++)
  {
    switch()
    {
      case 2:
      CurrImg = ;
      break;
      
      case 3:
      CurrImg = ;
      break;
      
      case 4:
      CurrImg = ;
      break;
      
      case 5:
      CurrImg = ;
      break;
      
      case 6:
      CurrImg = ;
      break;
      
      case 7:
      CurrImg = ;
      break;
      
      default:
      //do nothing
      break;
    }
  }
}
