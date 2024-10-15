----- Creat Tables
CREATE TABLE User (
  id INT64 NOT NULL,
  name STRING(MAX),
) PRIMARY KEY (id);

CREATE TABLE Device (
  id INT64 NOT NULL,
  registration_time TIMESTAMP,
  is_compromised BOOL,
  device_type STRING(MAX), -- e.g., 'laptop', 'mobile', 'IoT'
) PRIMARY KEY (id);

CREATE TABLE Vulnerability (
  id INT64 NOT NULL,
  severity_score FLOAT64, -- CVSS score or similar
  risk_level FLOAT64, -- Calculated risk based on severity and other factors
  discovery_time TIMESTAMP,
  exploitability_score FLOAT64, 
) PRIMARY KEY (id);

CREATE TABLE DeviceAccessLog ( 
  id INT64 NOT NULL,
  device_id INT64 NOT NULL,
  access_time TIMESTAMP NOT NULL,
  location STRING(MAX), -- IP address or geolocation
) PRIMARY KEY (id, device_id, access_time),
  INTERLEAVE IN PARENT Device ON DELETE CASCADE;

CREATE TABLE VulnerabilityMitigation (
  id INT64 NOT NULL,
  vulnerability_id INT64 NOT NULL,
  mitigation_time TIMESTAMP NOT NULL,
  mitigation_status STRING(MAX), -- e.g., 'patched', 'mitigated', 'in progress'
) PRIMARY KEY (id, vulnerability_id, mitigation_time),
  INTERLEAVE IN PARENT Device ON DELETE CASCADE; 

CREATE TABLE UserDevice (
  id INT64 NOT NULL,
  device_id INT64 NOT NULL,
  assignment_time TIMESTAMP,
) PRIMARY KEY (id, device_id),
  INTERLEAVE IN PARENT User ON DELETE CASCADE;

CREATE TABLE DeviceSecurityEvents (
     INT64 NOT NULL,
  event_timestamp TIMESTAMP,
  event_details STRING(MAX), -- e.g., 'login failure', 'suspicious activity'
) PRIMARY KEY (id, event_timestamp),
  INTERLEAVE IN PARENT Device ON DELETE CASCADE;