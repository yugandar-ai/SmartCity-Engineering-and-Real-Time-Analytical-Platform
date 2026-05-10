import requests
import pandas as pd
import mysql.connector

# ---------------- API CONFIG ----------------

API_URL = "https://data.cityofnewyork.us/resource/erm2-nwe9.json?$limit=2000"

response = requests.get(API_URL)
data = response.json()

df = pd.DataFrame(data)

# ---------------- SELECT REQUIRED COLUMNS ----------------

required_columns = [
    "unique_key",
    "created_date",
    "complaint_type",
    "descriptor",
    "borough",
    "incident_address",
    "city",
    "zipcode",
    "latitude",
    "longitude",
    "status"
]

df = df[required_columns]

# ---------------- CLEAN DATA ----------------

df["created_date"] = pd.to_datetime(df["created_date"], errors='coerce')
df["latitude"] = pd.to_numeric(df["latitude"], errors='coerce')
df["longitude"] = pd.to_numeric(df["longitude"], errors='coerce')

df = df.dropna(subset=["latitude", "longitude"])

df = df.fillna("Unknown")

print("Sample Data:")
print(df.head())

# ---------------- MYSQL CONNECTION ----------------

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="2711",
    database="smart_city"
)

cursor = conn.cursor()

# Clear old data
cursor.execute("TRUNCATE TABLE public_safety_nyc")
conn.commit()

# ---------------- INSERT QUERY ----------------

insert_query = """
INSERT INTO public_safety_nyc
(unique_key, created_date, complaint_type, descriptor,
 borough, incident_address, city, zipcode,
 latitude, longitude, status)
VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
"""

for _, row in df.iterrows():
    cursor.execute(insert_query, tuple(row))

conn.commit()

print("✅ Public Safety NYC Multi-Location Data Inserted Successfully!")

cursor.close()
conn.close()
