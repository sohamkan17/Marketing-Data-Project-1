from pathlib import Path
import pandas as pd
import sqlite3

ROOT = Path(__file__).resolve().parent.parent
DATA = ROOT / "data"

conn = sqlite3.connect(ROOT / "marketing.db")

#load python db to sql

pd.read_csv(DATA / "users.csv").to_sql("users", conn, if_exists="replace", index = False)
pd.read_csv(DATA / "campaigns.csv").to_sql("campaigns", conn, if_exists="replace", index = False)
pd.read_csv(DATA / "ads.csv").to_sql("ads", conn, if_exists="replace", index = False)
pd.read_csv(DATA / "ad_events.csv").to_sql("ad_events", conn, if_exists="replace", index = False)

conn.close()

print("marketing.db is created")