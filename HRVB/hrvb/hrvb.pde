
import processing.net.*;

Client client;
String message = "";

SensorGraphApplet sa = null; 
LimitedSizeQueue<Integer> rr_readings = new LimitedSizeQueue<Integer>(50); 

Table rrLog;
String rrFilename;
long elapsedTime = 0;


void setup() {
  size(725, 410);

  rrFilename = "rr-intervals-" + System.currentTimeMillis() + ".csv";
  rrLog = new Table();
  rrLog.addColumn("Elapsed Time");
  rrLog.addColumn("RR Interval");

  client = new Client(this, "localhost", 12345);
  showGraphDisplay();
}


void draw() {
  if (client.available() > 0) {
  	char c = (char) client.read();
  	if (c == ';') {
  		handleMessage();
  		message = "";
  	} else {
  		message += c;
  	}
  }
}


void handleMessage() {
	String[] tokens = message.split(":");
	String metric = tokens[0];
	int reading = Integer.parseInt(tokens[1]);

	if (metric.equals("HR")) {
		println("Heart Rate: " + reading);
	} else if (metric.equals("RR")) {
		println("RR Interval: " + reading);
		rr_readings.add(60000 / reading);

    logReading(reading);
	}
}

void logReading(int reading) {
  elapsedTime += reading;
  
  TableRow r = rrLog.addRow();
  r.setLong("Elapsed Time", elapsedTime);
  r.setLong("RR Interval", reading);

  saveTable(rrLog, rrFilename);

}

  public void showGraphDisplay() {
    Frame parentFrame = ((processing.awt.PSurfaceAWT.SmoothCanvas) getSurface().getNative()).getFrame();
    if (sa == null){
      String[] args = {"Sensor Graph", "--display=2", "--location=0,0"};
      sa = new SensorGraphApplet(parentFrame);
            
      PApplet.runSketch(args, sa);
      sa.getSurface().setLocation(0,0);
      sa.removeExitEvent();      
      
    }
    else
    {
      sa.getSurface().setVisible(true);
      sa.loop();
    }
        
  }