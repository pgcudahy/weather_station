from typing import Optional
from fastapi import FastAPI
from pydantic import BaseModel
from datetime import date
import csv

app = FastAPI()

class WeatherItem(BaseModel):
    wind_direction_raw: int
    rain_amount_raw: int
    timestamp: list = []
    elapsed_time: int
    wind_speed_raw: int
    message_id: int

class PowerItem(BaseModel):
    status_index: int
    solar_watts: float
    battery_voltage: float
    battery_amperage: float
    external_temperature: float
    power_time_date: list = []

class ErrorItem(BaseModel):
    error_time_date: list = []
    reset_code = int

@app.post("/station")
async def create_item(item: WeatherItem):

    write_path = "/home/pi/weather_station/data/weather_data_" + date.today().strftime("%Y-%m-%d") + ".csv"

    #print(dict(item).values())

    with open(write_path, "a") as f:
        writer = csv.writer(f)
        writer.writerow(dict(item).values())
    return item

@app.post("/power")
async def create_item(item: PowerItem):

    write_path = "/home/pi/weather_station/data/power_data_" + date.today().strftime("%Y-%m-%d") + ".csv"

    print(dict(item).values())

    with open(write_path, "a") as f:
        writer = csv.writer(f)
        writer.writerow(dict(item).values())
    return item

@app.post("/error")
async def create_item(item: ErrorItem):

    write_path = "/home/pi/weather_station/data/reset_data_" + date.today().strftime("%Y-%m-%d") + ".csv"

    print(dict(item).values())

    with open(write_path, "a") as f:
        writer = csv.writer(f)
        writer.writerow(dict(item).values())
    return item