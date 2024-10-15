# Cloud Spanner and Spanner GraphDB: A Cybersecurity Use Case

This guide explores how Cloud Spanner and its graph extension, Spanner GraphDB, are used to model and query cybersecurity data.

## Cloud Spanner:
Cloud Spanner, by Google Cloud, is a scalable and consistent database that offers:

### Global Scale: 
Manages large datasets with consistent performance worldwide.
### Strong Consistency: 
Provides globally consistent transaction views.
### High Availability: 
Designed for uninterrupted service with automatic failover.
### SQL Support: 
Familiar relational database concepts for ease of use.

## Spanner GraphDB:
Spanner GraphDB adds graph database capabilities to Cloud Spanner, supporting complex data relationships and queries using GQL.

Integrated Graph and Relational Querying: Use both SQL and GQL without data migration.
Advanced Graph Queries: Enables detailed analysis of interconnected data.
Scalability and Performance: Inherits Cloud Spanner’s efficiency for graph operations.
Cybersecurity Use Case: Schema and Queries

## Schema Setup:
Users, Devices, and Vulnerabilities: Tables tracking users, devices, vulnerabilities, and their interactions.
Access and Events Logging: Tables for access logs and security events.
there are 2 option to creat the DEMO DB:
1) Manualy -> creat a database in Spanner and then run the resources/create_tables.sql and resources\insert_data.sql.
2) Sciprt -> run the Python Script python_script/create_env.py that will creat the DB, Table and insert random datat to the tables.
### Read the notes on the Python file heder

Once you have the DB and Table+Data, you csn rub the resources/create_graph.sql  in the Spanner Query editor and them start quering the data with GQL, demo query exist in the resources/queries.sql.

## Graph Mapping:
Relationships Captured in Edges: Links such as device accesses, mitigations, and ownerships formatted as a property graph (SecurityGraph).
Key Graph Queries:
## The tables:
**Identify Mitigated Vulnerabilities:** On devices owned by users.

**Analyze Access Patterns:** Across devices.

**Calculate Access Ratios:** For devices owned by users.

**Retrieve Security Events:** Related to compromised devices.

**Explore Multi-step Device Access:** For inter-device connectivity.

**Track Security Issues and Mitigations:** Highlighting vulnerabilities and responses.

## Scripts:
**Schema Creation:** create_tables.sql

**Data Insertion:** insert_data.sql

**Graph Construction:** create_graph.sql

**Demo Queries:** queries.sql

**Python Script to creat DB and Generat Table and Data** create_env.py

More information can be find in the **[Detailed_Readme](Detailed_Readme.md)** file