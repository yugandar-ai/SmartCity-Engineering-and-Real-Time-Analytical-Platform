CREATE DATABASE smart_city;

USE smart_city;

CREATE TABLE traffic_bengaluru_csv (

id INT AUTO_INCREMENT PRIMARY KEY,

date DATE,
time TIME,

area_name VARCHAR(100),
zone VARCHAR(50),
road_name VARCHAR(200),

latitude FLOAT,
longitude FLOAT,

traffic_volume INT,
average_speed FLOAT,
travel_time_index FLOAT,

congestion_level VARCHAR(20),
peak_hour VARCHAR(10),
holiday VARCHAR(10),
event_impact VARCHAR(50),

road_type VARCHAR(50),
lane_count INT,
road_capacity INT,
road_capacity_utilization FLOAT,

signal_waiting_time FLOAT,

incident_reports INT,
accident_reports INT,
emergency_vehicle_count INT,
emergency_response_time FLOAT,

roadwork_activity VARCHAR(50),
road_condition_score INT,

bus_count INT,
auto_count INT,
car_count INT,
bike_count INT,
truck_count INT,
ev_count INT,

public_transport_usage INT,
metro_passenger_count INT,
distance_to_metro FLOAT,

parking_usage INT,
parking_capacity INT,

pedestrian_count INT,
cyclist_count INT,

weather VARCHAR(20),
temperature FLOAT,
humidity FLOAT,

air_quality_index INT,
environmental_impact VARCHAR(20),
fuel_consumption FLOAT,
co2_emission FLOAT,
noise_level FLOAT,

signal_compliance FLOAT,

cctv_count INT,
police_count INT,

data_source VARCHAR(20)

);
select* from traffic_bengaluru_csv;