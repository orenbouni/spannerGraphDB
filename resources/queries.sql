-- Query 1: User, Device, Vulnerability filterd by device type 
GRAPH SecurityGraph
MATCH 
  (user:User)-[Possede:Possede]->
  (device:Device{device_type:"laptop"})-[mitigates:Mitigates]->(vulnerability:Vulnerability)
RETURN 
  device.device_type AS device_type, 
  mitigates.mitigation_time AS mitigation_time, 
  mitigates.mitigation_status AS mitigation_status, 
  vulnerability.id AS vulnerability_id, 
  vulnerability.severity_score AS severity_score
ORDER BY mitigates.mitigation_time;

-- Query 2: Device Access Log
GRAPH SecurityGraph
MATCH 
  (src_device:Device{device_type:"laptop"})-[accesses:Accesses]->(dst_device:Device)
RETURN 
  src_device.id AS accessing_device_id,
  src_device.device_type AS accessing_device_type,
  dst_device.id AS accessed_device_id,
  dst_device.device_type AS accessed_device_type,
  COUNT(accesses) AS num_accesses
GROUP BY src_device.id, dst_device.id,src_device.device_type,dst_device.device_type;

-- Query 3 - Witch devices access what (Device ID,Type,IP)
GRAPH SecurityGraph
MATCH 
  (device1:Device)-[access1:Accesses]->(device2:Device)-[access2:Accesses]->(device3:Device)-[access3:Accesses]->(device4:Device)
RETURN 
  device1.id AS device1_id, 
  device1.device_type AS type1,
  access1.location as Device1IP,
  device2.id AS device2_id, 
  device2.device_type AS type2,
  access2.location as Device2IP,
  ARRAY_AGG(device3.id) AS device3_ids,
  ARRAY_AGG(device3.device_type) AS type3,
  ARRAY_AGG(access3.location) as Device3IP

-- Query 4: Device Security Events (Combination of GQL and SQL)
SELECT 
  events.id AS device_id,
  devices.device_type AS device_type,
  events.event_timestamp AS event_ts,
  events.event_details AS details
FROM 
  DeviceSecurityEvents events,
  GRAPH_TABLE(
    SecurityGraph
    MATCH (compromised_device:Device)-[:Accesses]->{1,2}(dest_device)
    RETURN DISTINCT dest_device.id AS reached_device_id
  ) AS device_accesses,
  Device devices  
WHERE device_accesses.reached_device_id = events.id
  AND events.id = devices.id

-- -- Query 5 - Witch device compremis Whats and the Mitigation
GRAPH SecurityGraph
MATCH 
  (device1:Device)-[access:Accesses]->(device2:Device {is_compromised: true})-[mitigates:Mitigates]->(vulnerability:Vulnerability)
RETURN
  device1.id AS source_device_id,
  device1.device_type AS source_device_type,
  device2.id AS compromised_device_id,
  device2.device_type AS compromised_device_type,
  vulnerability.id AS vulnerability_id,
  vulnerability.severity_score AS vulnerability_severity,
  mitigates.mitigation_status AS mitigation_status


-- Query 6: Source and affected + Issue tyoe - a Union query with combination of GQL and SQL
GRAPH SecurityGraph
MATCH
  (device1:Device)-[:Accesses]->(device3:Device)-[:Mitigates]->(vulnerability:Vulnerability)
WHERE
  device3.is_compromised = true OR vulnerability.severity_score >= 7.0
RETURN
  device1.id AS source_device_id,
  device1.device_type AS source_device_type,
  device3.id AS affected_device_id,
  device3.device_type AS affected_device_type,
  vulnerability.id AS vulnerability_id,
  vulnerability.severity_score AS vulnerability_severity,
  (
    SELECT
      CASE
        WHEN device3.is_compromised = true THEN 'Compromised Device'
        WHEN vulnerability.severity_score >= 7.0 THEN 'High Severity Vulnerability'
        ELSE 'Unknown'
      END
  ) AS issue_type

UNION DISTINCT

MATCH
  (device1:Device)-[:Accesses]->(device2:Device)-[:Accesses]->(device3:Device)-[:Mitigates]->(vulnerability:Vulnerability)
WHERE
  device3.is_compromised = true OR vulnerability.severity_score >= 7.0
RETURN
  device1.id AS source_device_id,
  device1.device_type AS source_device_type,
  device3.id AS affected_device_id,
  device3.device_type AS affected_device_type,
  vulnerability.id AS vulnerability_id,
  vulnerability.severity_score AS vulnerability_severity,
  (
    SELECT
      CASE
        WHEN device3.is_compromised = true THEN 'Compromised Device'
        WHEN vulnerability.severity_score >= 7.0 THEN 'High Severity Vulnerability'
        ELSE 'Unknown'
      END
  ) AS issue_type
  