#include <Wire.h>
#include <Adafruit_MPU6050.h>
#include <Adafruit_Sensor.h>
#include <TinyGPSPlus.h>
#include <SoftwareSerial.h>

#define GPS_RX_PIN 8
#define GPS_TX_PIN 9

SoftwareSerial gpsSerial(GPS_RX_PIN, GPS_TX_PIN);
TinyGPSPlus gps;

Adafruit_MPU6050 mpu;

bool gpsReady = false;
bool imuReady = false;

void setup() {
  Serial.begin(115200);
  gpsSerial.begin(9600);

  Serial.println("Uruchamianie czujników...");
  delay(1000);

  // Inicjalizacja IMU
  if (!mpu.begin()) {
    Serial.println("BŁĄD: MPU6050 nie znaleziony!");
    imuReady = false;
  } else {
    Serial.println("OK: MPU6050 wykryty.");
    imuReady = true;

    mpu.setAccelerometerRange(MPU6050_RANGE_2_G);
    mpu.setGyroRange(MPU6050_RANGE_250_DEG);
    mpu.setFilterBandwidth(MPU6050_BAND_21_HZ);
  }

  // GPS jest "gotowy" dopiero po otrzymaniu sygnału satelitów
  Serial.println("Oczekiwanie na sygnal GPS...");
}

void loop() {
  // --- Odczyt GPS ---
  while (gpsSerial.available() > 0) {
    char c = gpsSerial.read();
    gps.encode(c);

    if (gps.location.isValid()) {
      gpsReady = true;
    }
  }

  // --- Wyswietl status GPS ---
  Serial.print("GPS: ");
  if (gps.location.isValid()) {
    Serial.print("FIX OK | Lat: ");
    Serial.print(gps.location.lat(), 6);
    Serial.print(" | Lng: ");
    Serial.print(gps.location.lng(), 6);
    Serial.print(" | Sat: ");
    Serial.print(gps.satellites.value());
  } else {
    Serial.print("brak fixu / czekam...");
  }
  Serial.println();

  // --- Odczyt IMU ---
  if (imuReady) {
    sensors_event_t a, g, temp;
    mpu.getEvent(&a, &g, &temp);

    Serial.print("IMU: ");
    Serial.print("Accel X: ");
    Serial.print(a.acceleration.x);
    Serial.print(" | Y: ");
    Serial.print(a.acceleration.y);
    Serial.print(" | Z: ");
    Serial.print(a.acceleration.z);
    Serial.print("  | Gyro X: ");
    Serial.print(g.gyro.x);
    Serial.print(" | Y: ");
    Serial.print(g.gyro.y);
    Serial.print(" | Z: ");
    Serial.println(g.gyro.z);
  } else {
    Serial.println("IMU: brak danych (MPU6050 nie działa)");
  }

  Serial.println("--------------------------------------");
  delay(1000);
}