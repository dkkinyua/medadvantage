import os
import pandas as pd
from dotenv import load_dotenv
from sqlalchemy import create_engine

load_dotenv()

DB_URL = os.getenv("DB_URL")

def load_table(csv_path, table_name):
    df = pd.read_csv(csv_path)

    engine = create_engine(DB_URL)

    try:
        with engine.connect() as conn:
            df.to_sql(
                name=table_name,
                con=conn,
                index=False,
                if_exists='append'
            )
        print(f"Loaded {table_name} successfully!")
    except Exception as e:
        print(f"Error loading {table_name}: {e}")

if __name__ == '__main__':
    print("Loading members table")
    load_table('/home/deecodes/medadvantage/data/members.csv', 'members')

    print("Loading medical records table")
    load_table('/home/deecodes/medadvantage/data/medical_claims.csv', 'medical_claims')

    print("Loading pharmacy records table")
    load_table('/home/deecodes/medadvantage/data/pharmacy_claims.csv', 'pharmacy_claims')

    print("Loading icd_to_hcc seed table")
    load_table('/home/deecodes/medadvantage/data/icd_to_hcc.csv', 'icd_to_hcc')

    print("Loading ndc_to_rxhcc seed table")
    load_table('/home/deecodes/medadvantage/data/ndc_to_rxhcc.csv', 'ndc_to_rxhcc')

    print("Loading job complete.")
