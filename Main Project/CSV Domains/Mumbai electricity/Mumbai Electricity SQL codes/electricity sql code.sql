USE smart_city;
drop table electricity_mumbai;
CREATE TABLE electricity_mumbai (
timestamp DATETIME,
zone VARCHAR(50),

household_kwh FLOAT,
commercial_kwh FLOAT,
industrial_kwh FLOAT,

total_demand_kwh FLOAT,

thermal_power_kwh FLOAT,
solar_power_kwh FLOAT,
hydro_power_kwh FLOAT,
gas_power_kwh FLOAT,
wind_power_kwh FLOAT,

renewable_kwh FLOAT,

distribution_loss_percent FLOAT,
grid_load_percent FLOAT,

power_outage INT,

temperature_c FLOAT,
humidity_percent FLOAT
);
select *from electricity_mumbai;

USE smart_city;

CREATE OR REPLACE VIEW vw_electricity_dashboard AS
SELECT
    timestamp,
    zone,
    household_kwh,
    commercial_kwh,
    industrial_kwh,
    total_demand_kwh,

    thermal_power_kwh,
    solar_power_kwh,
    hydro_power_kwh,
    gas_power_kwh,
    wind_power_kwh,
    renewable_kwh,

    distribution_loss_percent,
    grid_load_percent,
    power_outage,
    temperature_c,
    humidity_percent,

    DATE(timestamp)      AS date_only,
    HOUR(timestamp)      AS hour_of_day,
    DAYNAME(timestamp)   AS day_name,
    MONTH(timestamp)     AS month_no,
    MONTHNAME(timestamp) AS month_name,

    ROUND((renewable_kwh / NULLIF(total_demand_kwh, 0)) * 100, 2)
        AS renewable_percent,

    ROUND((thermal_power_kwh / NULLIF(total_demand_kwh, 0)) * 100, 2)
        AS thermal_percent,

    CASE
        WHEN grid_load_percent >= 90 THEN 'CRITICAL'
        WHEN grid_load_percent >= 75 THEN 'HIGH'
        WHEN grid_load_percent >= 55 THEN 'MODERATE'
        ELSE 'NORMAL'
    END AS grid_status,

    CASE
        WHEN distribution_loss_percent >= 10 THEN 'HIGH LOSS'
        WHEN distribution_loss_percent >= 8  THEN 'MODERATE'
        ELSE 'ACCEPTABLE'
    END AS loss_status,

    CASE
        WHEN HOUR(timestamp) BETWEEN 17 AND 20 THEN 'Evening Peak'
        WHEN HOUR(timestamp) BETWEEN 7  AND 10 THEN 'Morning Peak'
        WHEN HOUR(timestamp) BETWEEN 11 AND 16 THEN 'Mid Day'
        ELSE 'Off Peak'
    END AS time_slot,

    CASE
        WHEN power_outage = 1 THEN 'OUTAGE'
        ELSE 'NORMAL'
    END AS outage_status

FROM electricity_mumbai;


CREATE OR REPLACE VIEW vw_zone_summary AS
SELECT
    zone,

    ROUND(AVG(total_demand_kwh), 2) AS avg_demand,
    ROUND(SUM(total_demand_kwh), 2) AS total_demand,

    ROUND(AVG(household_kwh), 2)  AS avg_household,
    ROUND(AVG(commercial_kwh), 2) AS avg_commercial,
    ROUND(AVG(industrial_kwh), 2) AS avg_industrial,

    ROUND(AVG(grid_load_percent), 2)         AS avg_grid_load,
    ROUND(AVG(distribution_loss_percent), 2) AS avg_loss,
    ROUND(AVG(renewable_kwh), 2)             AS avg_renewable,

    SUM(power_outage) AS total_outages,
    ROUND(AVG(temperature_c), 1) AS avg_temp,
    COUNT(*) AS total_records,

    SUM(CASE
            WHEN grid_load_percent >= 90 THEN 1
            ELSE 0
        END) AS critical_hours,

    SUM(CASE
            WHEN distribution_loss_percent >= 10 THEN 1
            ELSE 0
        END) AS high_loss_hours

FROM electricity_mumbai
GROUP BY zone;


CREATE OR REPLACE VIEW vw_hourly_pattern AS
SELECT
    HOUR(timestamp) AS hour_of_day,
    zone,

    ROUND(AVG(total_demand_kwh), 2) AS avg_demand,
    ROUND(AVG(grid_load_percent), 2) AS avg_grid_load,
    ROUND(AVG(renewable_kwh), 2) AS avg_renewable,
    ROUND(AVG(distribution_loss_percent), 2) AS avg_loss,

    SUM(power_outage) AS outage_count

FROM electricity_mumbai
GROUP BY
    HOUR(timestamp),
    zone
ORDER BY hour_of_day;


CREATE OR REPLACE VIEW vw_outage_analysis AS
SELECT
    zone,
    DATE(timestamp) AS outage_date,
    HOUR(timestamp) AS outage_hour,

    temperature_c,
    humidity_percent,
    grid_load_percent,
    distribution_loss_percent

FROM electricity_mumbai
WHERE power_outage = 1
ORDER BY timestamp DESC;
select * from electricity_mumbai;
SELECT * FROM vw_electricity_dashboard;
SHOW FULL TABLES
WHERE Table_type = 'VIEW';

SELECT * FROM vw_zone_summary;
SELECT * FROM vw_hourly_pattern;
SELECT * FROM vw_outage_analysis;