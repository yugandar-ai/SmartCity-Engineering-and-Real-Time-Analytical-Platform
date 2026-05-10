USE smart_city;
drop table hyderabad_public_safety;
CREATE TABLE hyderabad_public_safety (

    incident_id VARCHAR(50),

    date DATE,
    time TIME,
    year INT,
    month INT,
    hour INT,
    day_of_week VARCHAR(20),

    area VARCHAR(100),
    locality VARCHAR(100),
    street_name VARCHAR(150),
    zone VARCHAR(50),
    location_type VARCHAR(50),

    latitude DECIMAL(10,6),
    longitude DECIMAL(10,6),

    incident_type VARCHAR(100),
    incident_sub_type VARCHAR(100),

    severity VARCHAR(50),
    status VARCHAR(50),
    department VARCHAR(100),

    response_time_minutes INT,

    people_involved INT,
    victim_count INT,
    injuries INT,

    damage_cost DECIMAL(12,2),

    report_source VARCHAR(100),
    lighting_condition VARCHAR(50),
    cctv_available VARCHAR(10),
    premises_status VARCHAR(50),
    weather_condition VARCHAR(50),
    offender_captured VARCHAR(10)

);
select *from hyderabad_public_safety;