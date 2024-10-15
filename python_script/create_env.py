####################################################################################################################
### Before running the Pythong script                                                                           ####
### 1) Install the requirements file using -> run pip install -r requirement/requirement.txt                    ####
### 2) run this Gcloud commen in the terminal to connect to the project {gcloud auth application-default login} ####
####################################################################################################################
import random
import string
from datetime import datetime, timedelta

import google.auth  # Import google.auth
from google.cloud import spanner

# Cloud Spanner Configuration
PROJECT_ID = "Project_ID"
INSTANCE_ID = "Spanner_Instance_name"
DATABASE_ID = "DB_ID" 

# Number of rows to insert in each table - for the demo Top number in the patameter cannot exide  254
## you can change the code in line 169 to have more rows.
NUM_USERS = 30 
NUM_DEVICES = 200
NUM_VULNERABILITIES = 70
NUM_ACCESS_LOGS = 200
NUM_MITIGATIONS = 38
NUM_USER_DEVICES = 200
#NUM_SECURITY_EVENTS = 213
NUM_SECURITY_EVENTS_PER_DEVICE=3

def create_database(instance_id, database_id):
    """Creates a database and tables for sample data."""
    credentials, project = google.auth.default()
    spanner_client = spanner.Client(credentials=credentials)
    instance = spanner_client.instance(instance_id)
    database = instance.database(database_id)

    operation = database.create()
    print("Waiting for operation to complete...")
    operation.result()

    print(f"Created database {database_id} on instance {instance_id}")

    database.update_ddl(
        [
            """CREATE TABLE User (
                id INT64 NOT NULL,
                name STRING(MAX)
            ) PRIMARY KEY (id)""",
            """CREATE TABLE Device (
                id INT64 NOT NULL,
                registration_time TIMESTAMP,
                is_compromised BOOL,
                device_type STRING(MAX)
            ) PRIMARY KEY (id)""",
            """CREATE TABLE Vulnerability (
                id INT64 NOT NULL,
                severity_score FLOAT64,
                risk_level FLOAT64,
                discovery_time TIMESTAMP,
                exploitability_score FLOAT64
            ) PRIMARY KEY (id)""",
            """CREATE TABLE DeviceAccessLog (
                id INT64 NOT NULL,
                device_id INT64 NOT NULL,
                access_time TIMESTAMP NOT NULL,
                location STRING(MAX)
            ) PRIMARY KEY (id, device_id, access_time),
            INTERLEAVE IN PARENT Device ON DELETE CASCADE""",
            """CREATE TABLE VulnerabilityMitigation (
                id INT64 NOT NULL,
                vulnerability_id INT64 NOT NULL,
                mitigation_time TIMESTAMP NOT NULL,
                mitigation_status STRING(MAX)
            ) PRIMARY KEY (id, vulnerability_id, mitigation_time),
            INTERLEAVE IN PARENT Device ON DELETE CASCADE""",
            """CREATE TABLE UserDevice (
                id INT64 NOT NULL,
                device_id INT64 NOT NULL,
                assignment_time TIMESTAMP
            ) PRIMARY KEY (id, device_id),
            INTERLEAVE IN PARENT User ON DELETE CASCADE""",
            """CREATE TABLE DeviceSecurityEvents (
                id INT64 NOT NULL,
                event_timestamp TIMESTAMP,
                event_details STRING(MAX)
            ) PRIMARY KEY (id, event_timestamp),
            INTERLEAVE IN PARENT Device ON DELETE CASCADE""",
        ]
    ).result()

    print("Created tables")


def insert_data(instance_id, database_id):
    """Inserts sample data into the tables."""
    spanner_client = spanner.Client()
    instance = spanner_client.instance(instance_id)
    database = instance.database(database_id)

    # Generate random users with first and last names
    first_names =  ["Alice", "Bob", "Charlie", "David", "Emily", "Frank", "Grace", "Henry", "Isabella", "Jack",
                    "Olivia", "Liam", "Emma", "Noah", "Ava", "Sophia", "Jackson", "Aiden", "Lucas", "Mia",
                    "Ethan", "Amelia", "Matthew", "Harper", "Evelyn", "Abigail", "Daniel", "Emily", "Madison", "William",
                    "James", "Ella", "Benjamin", "Alexander", "Michael", "Elijah", "Sofia", "Avery", "Scarlett", "Chloe",
                    "Joseph", "Andrew", "Samuel", "Logan", "John", "Elizabeth", "Victoria", "Natalie", "Grace", "Lily"]
    last_names =   ["Smith", "Jones", "Williams", "Brown", "Davis", "Miller", "Wilson", "Moore", "Taylor", "Anderson",
                    "Thomas", "Jackson", "White", "Harris", "Martin", "Thompson", "Garcia", "Martinez", "Robinson", "Clark",
                    "Rodriguez", "Lewis", "Lee", "Walker", "Hall", "Allen", "Young", "Hernandez", "King", "Wright",
                    "Lopez", "Hill", "Scott", "Green", "Adams", "Baker", "Gonzalez", "Nelson", "Carter", "Mitchell",
                    "Perez", "Roberts", "Turner", "Phillips", "Campbell", "Parker", "Evans", "Edwards", "Collins", "Stewart"]
    sec_event =    ["Ransomware Attacks", "Phishing Attacks", "Social Engineering", "Malware", "Zero-Day Exploits"
                    "Distributed Denial-of-Service (DDoS) Attacks", "Cloud Security Risks", "Internet of Things (IoT) Vulnerabilities", 
                    "Mobile Malware and Vulnerabilities", "Insider Threats", "Supply Chain Attacks", "AI-Powered Cyber Threats", 
                    "Data Breaches and Privacy Violations", " Advanced Persistent Threats (APTs)", "Cryptocurrency-Related Threats"]

    user_ids = range(NUM_USERS)
    users = [
        (i + 1, f"{random.choice(first_names)} {random.choice(last_names)}")
        for i in user_ids
    ]

    # Generate random devices
    devices = [
        (
            i + 1,
            datetime.now() - timedelta(days=random.randint(0, 365)),
            random.choice([True, False]),
            random.choice(["laptop", "mobile", "IoT", "desktop", "server","BAckend SRV","Frontend SRV","DB SRV","APP SRV"]),
        )
        for i in range(NUM_DEVICES)
    ]

    # Generate random vulnerabilities
    vulnerabilities = [
        (
            i + 1,
            round(random.uniform(4.0, 10.0), 1),
            round(random.uniform(2.0, 10.0), 1),
            datetime.now() - timedelta(days=random.randint(0, 365)),
            round(random.uniform(0.5, 1.0), 2),
        )
        for i in range(NUM_VULNERABILITIES)
    ]

    with database.batch() as batch:
        batch.insert(table="User", columns=("id", "name"), values=users)
        batch.insert(
            table="Device",
            columns=("id", "registration_time", "is_compromised", "device_type"),
            values=devices,
        )
        batch.insert(
            table="Vulnerability",
            columns=(
                "id",
                "severity_score",
                "risk_level",
                "discovery_time",
                "exploitability_score",
            ),
            values=vulnerabilities,
        )

    # Generate and insert related data
    access_logs = []
    mitigations = []
    user_devices = []
    security_events = []

    device_ids = [device[0] for device in devices]
    user_ids = [user[0] for user in users]
    vulnerability_ids = [vulnerability[0] for vulnerability in vulnerabilities]

    # Generate DeviceAccessLog data
    for i in range(NUM_ACCESS_LOGS):
        access_logs.append(
            (
                i + 1,
                random.choice(device_ids),
                datetime.now() - timedelta(days=random.randint(0, 30)),
                ".".join(str(random.randint(0, 255)) for _ in range(4)),
            )
        )

    # Generate VulnerabilityMitigation data
    for i in range(NUM_MITIGATIONS):
        mitigations.append(
            (
                i + 1,
                random.choice(vulnerability_ids),
                datetime.now() - timedelta(days=random.randint(0, 30)),
                random.choice(["Success", "Failed", "In Progress"]),
            )
        )

    # Generate UserDevice data

    CONNECTIONS_PER_USER = round(NUM_DEVICES / NUM_USERS)
    device_index = 0
    for i in range(NUM_USERS):
        
        for ci in range(CONNECTIONS_PER_USER):
            user_devices.append(
            (
                i+1,
                device_ids[device_index],
                datetime.now() - timedelta(days=random.randint(0, 365)),
            ))
            device_index = device_index + 1
            if device_index == (len(device_ids) - 1):
                device_index = 0

        for se in range(NUM_SECURITY_EVENTS_PER_DEVICE):
            security_events.append(
            (
                i + 1,
                datetime.now() - timedelta(hours=random.randint(0, 72)),
                #''.join(random.choices(string.ascii_lowercase + string.digits, k=20))
                random.choice(sec_event)
            )
        )

    with database.batch() as batch:
        batch.insert(
            table="DeviceAccessLog",
            columns=("id", "device_id", "access_time", "location"),
            values=access_logs,
        )
        batch.insert(
            table="VulnerabilityMitigation",
            columns=("id", "vulnerability_id", "mitigation_time", "mitigation_status"),
            values=mitigations,
        )
        batch.insert(
            table="UserDevice",
            columns=("id", "device_id", "assignment_time"),
            values=user_devices,
        )
        batch.insert(
            table="DeviceSecurityEvents",
            columns=("id", "event_timestamp", "event_details"),
            values=security_events,
        )

    print("Inserted data")


if __name__ == "__main__":
    create_database(INSTANCE_ID, DATABASE_ID)
    insert_data(INSTANCE_ID, DATABASE_ID)