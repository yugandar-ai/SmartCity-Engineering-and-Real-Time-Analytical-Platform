use smart_city;
DROP TABLE  water_chennai_analytics;

CREATE TABLE water_chennai_analytics (

id INT AUTO_INCREMENT PRIMARY KEY,

data_date DATE,
system_entry_time DATETIME,

division_no INT,
zone_no VARCHAR(10),

division_office_address VARCHAR(255),
division_office_landline VARCHAR(50),
division_mobile_no VARCHAR(50),
has_cash_counter VARCHAR(10),

zonal_office_address VARCHAR(255),
zonal_office_landline VARCHAR(50),

zone_population INT,

water_supply_capacity_liters FLOAT,
daily_water_supply_liters FLOAT,
daily_water_consumption_liters FLOAT,
water_shortage_liters FLOAT,

pipeline_leakage_percent FLOAT,
reservoir_level_percent FLOAT,

per_capita_water_liters FLOAT,
supply_demand_ratio FLOAT,
consumption_rank FLOAT

);

select * from water_chennai_analytics;