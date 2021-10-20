#! /usr/bin/env python3
# coding: utf-8
# modified example from https://weatherstack.com/documentation
import requests

params = {
  'access_key': '<api_key>',
  # Nashville
  'query': '36.1608014,-86.7833216',
  'forcast_days': '1',
  'days': '1',
  'units': 'f'
}

api_result = requests.get('http://api.weatherstack.com/forecast', params)

api_response = api_result.json()

city = api_response['location']['name']
region = api_response['location']['region']

for i, k in enumerate(api_response['forecast']):
    forecast_values = api_response['forecast'][k]

max_temp = forecast_values['maxtemp']
min_temp = forecast_values['mintemp']
avg_temp = forecast_values['avgtemp']
uv_index = forecast_values['uv_index']

print(f'Forcast for {city}, {region} tomorrow is \n\taverage temp: {avg_temp} F \n\tminimum temp: {min_temp} F \n\tmaximum temp: {max_temp} F \n\tUV index: {uv_index}')