drop table pollution_delhi;
use smart_city;
CREATE TABLE pollution_delhi (
    id INT AUTO_INCREMENT PRIMARY KEY,
    date_only DATE,
    time_only TIME,
    pm25 FLOAT,
    pm10 FLOAT,
    carbon_monoxide FLOAT,
    nitrogen_dioxide FLOAT,
    sulphur_dioxide FLOAT,
    ozone FLOAT,
    pollution_level VARCHAR(30),
    category VARCHAR(20),
    relative_hour INT
);

select * from pollution_delhi;

