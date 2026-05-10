import pandas as pd
import mysql.connector

# -----------------------------
# 1. Load CSV Dataset
# -----------------------------

file_path = (r"D:\major project 4-2\indian data sets without using api\electricity\Mumbai Electricity Consumption Dataset\mumbai_electricity_final_realistic.csv")

df = pd.read_csv(file_path)

# Convert timestamp column
df['timestamp'] = pd.to_datetime(df['timestamp'])

print("Dataset Loaded")
print(df.head())

# -----------------------------
# 2. Connect to MySQL
# -----------------------------

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="2711",
    database="smart_city"
)

cursor = conn.cursor()

print("Connected to MySQL")

# -----------------------------
# 3. Insert Data into SQL
# -----------------------------

insert_query = """
INSERT INTO electricity_mumbai (
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
humidity_percent
)
VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)
"""

for _, row in df.iterrows():
    cursor.execute(insert_query, tuple(row))

conn.commit()

print("Data inserted successfully!")

cursor.close()
conn.close()