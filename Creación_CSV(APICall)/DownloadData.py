import csv
import os
import math
from fastf1.ergast import Ergast
import fastf1

def generar_nuevo_csv(ruta_archivo, datos):
    with open(ruta_archivo + 'laps.csv', 'w', newline='') as archivo:
        escritor_csv = csv.writer(archivo)
        escritor_csv.writerows(datos)

def agregar_datos_a_csv(ruta_archivo, datos):
    with open(ruta_archivo + 'laps.csv', 'a', newline='') as archivo:
        escritor_csv = csv.writer(archivo)
        escritor_csv.writerows(datos)

datos = [
    ['Broadcast_Name', 'Name', 'Last_Name', 'dateOfBirth', 'Nationality']
]

ruta_archivo = r'C:\Users\Julian\Documents\4o Año Ua\Segundo Cuatrimeste\INGP\Proyecto Final\CSV_Generados\\'

ergast = Ergast()
drivers = ergast.get_driver_info(season=2023, result_type='raw')
drivers_2022 = ergast.get_driver_info(season=2022, result_type='raw')

drivers_ids = []

for driver in drivers:
    datos.append([driver['code'], driver['givenName'], driver['familyName'], driver['dateOfBirth'], driver['nationality']])

for driver in drivers_2022:
    datos.append([driver['code'], driver['givenName'], driver['familyName'], driver['dateOfBirth'], driver['nationality']])

with open(ruta_archivo + 'drivers.csv', 'w', newline='') as archivo:
    escritor_csv = csv.writer(archivo)
    escritor_csv.writerows(datos)

datos = [
    ['GP_Format', 'Fecha_Evento']
]

schedule_2023 = fastf1.get_event_schedule(2023)
schedule_2022 = fastf1.get_event_schedule(2022)

i = 0
while i < schedule_2023.shape[0]:
    format = schedule_2023['EventFormat'][i]
    date = schedule_2023['EventDate'][i]
    datos.append([format, date])
    i += 1

i = 0
while i < schedule_2022.shape[0]:
    format = schedule_2022['EventFormat'][i]
    date = schedule_2022['EventDate'][i]
    datos.append([format, date])
    i += 1

with open(ruta_archivo + 'format.csv', 'w', newline='') as archivo:
    escritor_csv = csv.writer(archivo)
    escritor_csv.writerows(datos)

datos = [
     ['Driver', 'Team', 'Grand_Prix', 'Lap_Number', 'Weather', 
      'Tyre', 'Lap_deleted', 'Deleted_Reason', 'Track_status', 'Date', 'Lap_time', 
      'Sector_1', 'Sector_2', 'Sector_3', 'Speed_S1', 'Speed_S2', 'Speed_FL',
      'Speed_LS', 'Avg_Speed', 'Avg_RPM', 'Avg_Gear', 'Brake_percent', 'DRS_On_Percent', 'Time_OnTrack',
      'Pit_In', 'Pit_Out', 'Tyrelife', 'Track_Temperature']
]

datos_GP = [
    ['Name', 'Circuit_Name', 'Country', 'Location', 'Total_Distance', 'Total_Laps']
]

datos_team = [
    ['Name','Nationality','TeamId']
]

datos_status = [
    ['idTrack_status', 'Status']
]

season_2023 = ergast.get_race_schedule(2023,result_type='raw')
season_2022 = ergast.get_race_schedule(2022,result_type='raw')



grand_prix_ids = []
for grand_prix in season_2023:
    circuito = grand_prix['Circuit']
    location = circuito['Location']
    datos_GP.append([grand_prix['raceName'], circuito['circuitName'], location['country'], location['locality'], 0, 0])
    grand_prix_ids.append(grand_prix['raceName'])

for grand_prix in season_2022:
    if grand_prix['raceName'] not in grand_prix_ids:
        circuito = grand_prix['Circuit']
        location = circuito['Location']
        datos_GP.append([grand_prix['raceName'], circuito['circuitName'], location['country'], location['locality'], 0, 0])

j = 1
while j <= 22:
    session = fastf1.get_session(2023,j, 'R')
    session.load(laps=True, telemetry=True, weather=True, messages=True, livedata=None)

    #Obtener los equipos
    if j == 1:
        for index, row in session.results.iterrows():
            datos_team.append([row['TeamName'], 'Por definir', row['TeamId']])

    #Obtener mensajes de estado de la pista
    track_status = session.track_status
    k = 0
    while k < len(track_status['Status']):
        value = track_status['Status'][k]
        datos_status.append([value, track_status['Message'][k]])        
        k += 1

    #Obtener datos restantes del circuito
    for gp in datos_GP:
        if gp[0] == session.event['EventName']:
            laps = session.total_laps

            # Selecciona una vuelta
            lap = session.laps.pick_fastest()

            # Obtén los datos de telemetría para esa vuelta
            telemetry = lap.get_telemetry()

            # Calcula la distancia total recorrida
            total_distance = telemetry['Distance'].iloc[-1]
            gp[4] = total_distance
            gp[5] = laps

    #Datos generales
    laps = session.laps
    weather = laps.get_weather_data()
    weather_rainfall = weather['Rainfall']
    weather_Track = weather['TrackTemp']
    for index, lap in laps.iterrows():
        telemetry = lap.get_telemetry()
        numActido = telemetry['DRS'].isin([10, 12, 14]).sum()
        tiempoPista = telemetry[telemetry['Status'] == 'OnTrack'].shape[0]
        tiempoTotal = telemetry['Status'].shape[0]
        datos.append([lap['Driver'], lap['Team'], session.event['EventName'], lap['LapNumber'],
        weather_rainfall.iloc[index], lap['Compound'], lap['Deleted'], lap['DeletedReason'], lap['TrackStatus'], session.date,
        lap['LapTime'], lap['Sector1Time'], lap['Sector2Time'], lap['Sector3Time'], lap['SpeedI1'], lap['SpeedI2'], 
        lap['SpeedFL'], lap['SpeedST'], telemetry['Speed'].mean(), telemetry['RPM'].mean(), telemetry['nGear'].mean(), 
        telemetry['Brake'].mean() * 100, (numActido / len(telemetry['DRS'])) * 100, (tiempoPista / tiempoTotal) * 100,
        lap['PitInTime'], lap['PitOutTime'], lap['TyreLife'], weather_Track.iloc[index]])

    if j == 1:
        generar_nuevo_csv(ruta_archivo, datos)
    else:
        agregar_datos_a_csv(ruta_archivo, datos)
    
    datos = []
    j += 1

j = 1
with fastf1.Cache.disabled():  
    while j <= 22:
        session = fastf1.get_session(2022,j, 'R')
        session.load(laps=True, telemetry=True, weather=True, messages=True, livedata=None)

        #Obtener los equipos
        if j == 0:
            for index, row in session.results.iterrows():
                datos_team.append([row['TeamName'], 'Por definir', row['TeamId']])

        #Obtener mensajes de estado de la pista
        track_status = session.track_status
        k = 0
        while k < len(track_status['Status']):
            value = track_status['Status'][k]
            datos_status.append([value, track_status['Message'][k]])        
            k += 1

        #Obtener datos restantes del circuito
        for gp in datos_GP:
            if gp[0] == session.event['EventName']:
                laps = session.total_laps

                # Selecciona una vuelta
                lap = session.laps.pick_fastest()

                # Obtén los datos de telemetría para esa vuelta
                telemetry = lap.get_telemetry()

                # Calcula la distancia total recorrida
                total_distance = telemetry['Distance'].iloc[-1]
                gp[4] = total_distance
                gp[5] = laps

        #Datos generales
        laps = session.laps
        weather = laps.get_weather_data()
        weather_rainfall = weather['Rainfall']
        weather_Track = weather['TrackTemp']
        for index, lap in laps.iterrows():
            if lap['FastF1Generated'] == True:
                datos.append([lap['Driver'], lap['Team'], session.event['EventName'], lap['LapNumber'],
                weather_rainfall.iloc[index], lap['Compound'], lap['Deleted'], lap['DeletedReason'], lap['TrackStatus'], session.date,
                lap['LapTime'], lap['Sector1Time'], lap['Sector2Time'], lap['Sector3Time'], lap['SpeedI1'], lap['SpeedI2'], 
                lap['SpeedFL'], lap['SpeedST'], 'Sin datos', 'Sin datos', 'Sin datos', 'Sin datos', 
                'Sin datos', 'Sin datos',lap['PitInTime'], lap['PitOutTime'], lap['TyreLife'], weather_Track.iloc[index]])
            else:
                telemetry = lap.get_telemetry()
                numActido = telemetry['DRS'].isin([10, 12, 14]).sum()
                tiempoPista = telemetry[telemetry['Status'] == 'OnTrack'].shape[0]
                tiempoTotal = telemetry['Status'].shape[0]
                datos.append([lap['Driver'], lap['Team'], session.event['EventName'], lap['LapNumber'],
                weather_rainfall.iloc[index], lap['Compound'], lap['Deleted'], lap['DeletedReason'], lap['TrackStatus'], session.date,
                lap['LapTime'], lap['Sector1Time'], lap['Sector2Time'], lap['Sector3Time'], lap['SpeedI1'], lap['SpeedI2'], 
                lap['SpeedFL'], lap['SpeedST'], telemetry['Speed'].mean(), telemetry['RPM'].mean(), telemetry['nGear'].mean(), 
                telemetry['Brake'].mean() * 100, (numActido / len(telemetry['DRS'])) * 100, (tiempoPista / tiempoTotal) * 100,
                lap['PitInTime'], lap['PitOutTime'], lap['TyreLife'], weather_Track.iloc[index]])

        agregar_datos_a_csv(ruta_archivo, datos)
        datos = []
        j += 1


constructors_2023 = ergast.get_constructor_standings(2023,result_type='raw')
constructors_2022 = ergast.get_constructor_standings(2022,result_type='raw')

for row in constructors_2023:
    for standing in row['ConstructorStandings']:
        for entrada in datos_team:
            if standing['Constructor']['constructorId'] == entrada[2]:
                entrada[1] = standing['Constructor']['nationality']

for row in constructors_2022:
    for standing in row['ConstructorStandings']:
        for entrada in datos_team:
            if entrada[1] == 'Por definir' and standing['Constructor']['constructorId'] == entrada[2]:
                entrada[1] = standing['Constructor']['nationality']

with open(ruta_archivo + 'grand_prix.csv', 'w', newline='') as archivo:
    escritor_csv = csv.writer(archivo)
    escritor_csv.writerows(datos_GP)

with open(ruta_archivo + 'team.csv', 'w', newline='') as archivo:
    escritor_csv = csv.writer(archivo)
    escritor_csv.writerows(datos_team)

with open(ruta_archivo + 'track_status.csv', 'w', newline='') as archivo:
    escritor_csv = csv.writer(archivo)
    escritor_csv.writerows(datos_status)