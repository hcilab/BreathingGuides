# Comparing HRVB and Paced Breating - HRV-b Visualization Tool

This tool was used during an experiment comparing the effects of HRV-b and Simple Paced Breathing in non-clinical use. Specifically, this folder contains the source code for the HRV-b visualization tool. HRV was sensed using the [Polar H10 chest strap](https://www.polar.com/ca-en/sensors/h10-heart-rate-sensor/)


# System Architecture

This project adopts a client / server architecture:

**Server (node.js) `node-h7-hr`** - This is a modified fork of the existing [node-h7-hr](https://github.com/jakelear/node-h7-hr) project. Specifically, the existing project was modified to a) capture RR-intervals, and b) stream the data across a web-socket for visualization in the corresponding client app (see below).

**Client (Processing 3.0) `hrvb`** - This is a processing sketch that consumes the captured RR interval data and presents it visually using a scrolling line graph.


# Running the application

After installing project dependencies for both projects, the application can be run with the following commands. Please ensure that your device has bluetooth enabled, and that the Polar HR monitor is in *direct* contact with the skin (the band has a battery-saving feature that turns the data capture off when the band isn't being worn).

## Step 1. Start the Server
```bash
cd node-h7-hr
node index.js
```


## Step 2. Start the HRV-b visualizer

This application is most easily run through the `Processing 3.0` GUI / IDE (e.g., open the sketch, and click the "play" button to launch the app)