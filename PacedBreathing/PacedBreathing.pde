//
// Breath Guide
//
// A simple visualization to pace breathing rate.
//

import controlP5.*;

ControlP5 controlP5;

float cpm;
float depth;


void setup() {
	size(800, 800);
	background(255);
	frameRate(15);

	strokeWeight(2);
	stroke(0);
	ellipseMode(CENTER);

	controlP5 = new ControlP5(this);
	controlP5.addSlider("cpm")
		.setPosition(100, 20)
		.setSize(200, 20)
		.setRange(4.0, 20.0)
		.setValue(6.0)
		.setColorCaptionLabel(color(0));
	controlP5.addSlider("depth")
		.setPosition(100, 50)
		.setSize(200, 20)
		.setRange(0.0, 1.0)
		.setValue(1.0)
		.setColorCaptionLabel(color(0));
}


void draw() {
	clear();
	background(255);

	int breathLengthMillis = int((60/cpm) * 1000);
	float sinWave = sin(map(millis() % breathLengthMillis, 0, breathLengthMillis, 0, TWO_PI));

	float radius = map(sinWave, -1.0, 1.0, 300, 300 + depth*300);
	float intensity = map(sinWave, -1.0, 1.0, 240, 240 - depth*225);

	fill(intensity);
	ellipse(400, 480, radius, radius);
}