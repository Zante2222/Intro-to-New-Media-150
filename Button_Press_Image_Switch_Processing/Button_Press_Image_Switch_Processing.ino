// Arduino Nano 33 IoT - One Image per Button Press (with internal pull-up)

const int buttonPin = 2;
bool lastButtonState = HIGH;
bool currentButtonState = HIGH;
unsigned long lastDebounceTime = 0;
unsigned long debounceDelay = 50;

void setup() {
  pinMode(buttonPin, INPUT_PULLUP); // use internal pull-up
  Serial.begin(9600);
}

void loop() {
  int reading = digitalRead(buttonPin);

  // Debounce
  if (reading != lastButtonState) {
    lastDebounceTime = millis();
  }

  if ((millis() - lastDebounceTime) > debounceDelay) {
    if (reading != currentButtonState) {
      currentButtonState = reading;

      // Active LOW: when button is pressed
      if (currentButtonState == LOW) {
        Serial.println("NEXT");
      }
    }
  }

  lastButtonState = reading;
}
