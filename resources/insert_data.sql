---- insert demo data to the tables

  -- Insert data into User table
INSERT INTO User (id, name) VALUES
(1, 'Alice Smith'),
(2, 'Bob Johnson'),
(3, 'Charlie Brown'),
(4, 'David Lee'),
(5, 'Emily Davis'),
(6, 'Frank Wilson'),
(7, 'Grace Moore'),
(8, 'Henry Taylor'),
(9, 'Isabella Anderson'),
(10, 'Jack Thomas'),
(11, 'Katherine Jackson'),
(12, 'Liam White'),
(13, 'Mia Harris'),
(14, 'Noah Martin'),
(15, 'Olivia Thompson'),
(16, 'Katherine Martin'),
(17, 'Liam Thompson'),
(18, 'Mia Jackson'),
(19, 'Noah Harris'),
(20, 'Olivia White');

-- Insert data into Device table
INSERT INTO Device (id, registration_time, is_compromised, device_type) VALUES
(1, TIMESTAMP '2023-05-01 10:00:00', false, 'laptop'),
(2, TIMESTAMP '2023-06-15 14:30:00', false, 'mobile'),
(3, TIMESTAMP '2023-07-22 09:15:00', true, 'IoT'),
(4, TIMESTAMP '2023-08-10 11:45:00', false, 'laptop'),
(5, TIMESTAMP '2023-09-03 16:20:00', false, 'mobile'),
(6, TIMESTAMP '2023-10-18 12:00:00', false, 'desktop'),
(7, TIMESTAMP '2023-11-25 08:30:00', false, 'laptop'),
(8, TIMESTAMP '2024-01-05 15:15:00', false, 'tablet'),
(9, TIMESTAMP '2024-02-12 10:45:00', false, 'mobile'),
(10, TIMESTAMP '2024-03-20 17:00:00', true, 'server'),
(11, TIMESTAMP '2024-04-28 09:30:00', false, 'laptop'),
(12, TIMESTAMP '2024-05-15 14:00:00', false, 'IoT'),
(13, TIMESTAMP '2024-06-22 11:15:00', false, 'desktop'),
(14, TIMESTAMP '2024-07-10 16:45:00', false, 'mobile'),
(15, TIMESTAMP '2024-08-03 12:20:00', false, 'laptop');

-- Insert data into Vulnerability table
INSERT INTO Vulnerability (id, severity_score, risk_level, discovery_time, exploitability_score) VALUES
(1, 7.5, 6.0, TIMESTAMP '2023-04-10', 0.8),
(2, 9.0, 8.5, TIMESTAMP '2023-05-15', 0.9),
(3, 5.0, 3.0, TIMESTAMP '2023-06-22', 0.6),
(4, 6.8, 5.5, TIMESTAMP '2023-07-10', 0.7),
(5, 8.2, 7.8, TIMESTAMP '2023-08-03', 0.85),
(6, 4.3, 2.5, TIMESTAMP '2023-09-18', 0.5),
(7, 7.1, 6.2, TIMESTAMP '2023-10-25', 0.75),
(8, 8.8, 8.0, TIMESTAMP '2023-11-05', 0.9),
(9, 5.5, 4.0, TIMESTAMP '2024-01-12', 0.65),
(10, 6.2, 5.0, TIMESTAMP '2024-02-20', 0.7),
(11, 7.9, 7.5, TIMESTAMP '2024-03-28', 0.8),
(12, 4.7, 3.2, TIMESTAMP '2024-04-15', 0.55),
(13, 8.5, 8.2, TIMESTAMP '2024-05-22', 0.85),
(14, 6.0, 4.8, TIMESTAMP '2024-06-10', 0.6),
(15, 7.3, 6.5, TIMESTAMP '2024-07-03', 0.75);

-- Insert data into DeviceAccessLog table
INSERT INTO DeviceAccessLog (id, device_id, access_time, location) VALUES
(1, 1, TIMESTAMP '2024-09-01 08:00:00', '192.168.1.10'),
(1, 1, TIMESTAMP '2024-09-01 10:30:00', '192.168.1.10'),
(2, 3, TIMESTAMP '2024-09-02 14:15:00', '10.0.0.5'),
(3, 5, TIMESTAMP '2024-09-03 09:45:00', '172.16.0.20'),
(4, 2, TIMESTAMP '2024-09-04 11:20:00', '192.168.1.15'),
(5, 7, TIMESTAMP '2024-09-05 16:00:00', '10.0.0.10'),
(6, 4, TIMESTAMP '2024-09-06 08:30:00', '172.16.0.25'),
(7, 8, TIMESTAMP '2024-09-07 14:45:00', '192.168.1.20'),
(8, 6, TIMESTAMP '2024-09-08 10:15:00', '10.0.0.15'),
(9, 9, TIMESTAMP '2024-09-09 12:00:00', '172.16.0.30'),
(10, 1, TIMESTAMP '2024-09-10 17:30:00', '192.168.1.25'),
(11, 3, TIMESTAMP '2024-09-11 09:00:00', '10.0.0.20'),
(12, 5, TIMESTAMP '2024-09-12 11:45:00', '172.16.0.35'),
(2, 3, TIMESTAMP '2024-09-12 14:30:00', '10.0.0.5'),
(13, 2, TIMESTAMP '2024-09-13 16:15:00', '192.168.1.30');

-- Insert data into VulnerabilityMitigation table (completed)
INSERT INTO VulnerabilityMitigation (id, vulnerability_id, mitigation_time, mitigation_status) VALUES
(1, 3, TIMESTAMP '2024-08-15 10:00:00', 'patched'),
(2, 1, TIMESTAMP '2024-08-22 14:30:00', 'mitigated'),
(3, 5, TIMESTAMP '2024-08-29 09:15:00', 'in progress'),
(4, 2, TIMESTAMP '2024-09-05 11:45:00', 'patched'),
(5, 7, TIMESTAMP '2024-09-12 16:20:00', 'mitigated'),
(6, 4, TIMESTAMP '2024-09-19 12:00:00', 'in progress'),
(7, 8, TIMESTAMP '2024-09-26 08:30:00', 'patched'),
(8, 6, TIMESTAMP '2024-10-03 15:15:00', 'mitigated'),
(9, 9, TIMESTAMP '2024-10-10 10:45:00', 'in progress'),
(10, 10, TIMESTAMP '2024-10-17 17:00:00', 'patched'),
(11, 11, TIMESTAMP '2024-10-24 09:30:00', 'mitigated'),
(12, 12, TIMESTAMP '2024-10-31 14:00:00', 'in progress'),
(13, 13, TIMESTAMP '2024-11-07 11:15:00', 'patched'),
(14, 14, TIMESTAMP '2024-11-14 16:45:00', 'mitigated'),
(15, 15, TIMESTAMP '2024-11-21 12:20:00', 'in progress');


-- Insert data into UserDevice table
INSERT INTO UserDevice (id, device_id, assignment_time) VALUES
(1, 1, TIMESTAMP '2023-05-01 10:30:00'),
(2, 2, TIMESTAMP '2023-06-15 15:00:00'),
(3, 3, TIMESTAMP '2023-07-22 10:00:00'),
(4, 4, TIMESTAMP '2023-08-10 12:15:00'),
(5, 5, TIMESTAMP '2023-09-03 17:00:00'),
(6, 6, TIMESTAMP '2023-10-18 12:30:00'),
(7, 7, TIMESTAMP '2023-11-25 09:00:00'),
(8, 8, TIMESTAMP '2024-01-05 16:00:00'),
(9, 9, TIMESTAMP '2024-02-12 11:30:00'),
(10, 10, TIMESTAMP '2024-03-20 17:30:00'),
(11, 11, TIMESTAMP '2024-04-28 10:00:00'),
(12, 12, TIMESTAMP '2024-05-15 14:30:00'),
(13, 13, TIMESTAMP '2024-06-22 12:00:00'),
(14, 14, TIMESTAMP '2024-07-10 17:15:00'),
(15, 15, TIMESTAMP '2024-08-03 13:00:00')
(1, 9, TIMESTAMP '2024-02-12 11:30:00'),
(1, 10, TIMESTAMP '2024-03-20 17:30:00'),
(2, 11, TIMESTAMP '2024-04-28 10:00:00'),
(2, 12, TIMESTAMP '2024-05-15 14:30:00'),
(6, 13, TIMESTAMP '2024-06-22 12:00:00'),
(9, 14, TIMESTAMP '2024-07-10 17:15:00'),
(14, 15, TIMESTAMP '2024-08-03 13:00:00')
(16, 9, TIMESTAMP '2024-02-12 11:30:00'),
(17, 10, TIMESTAMP '2024-03-20 17:30:00'),
(20, 11, TIMESTAMP '2024-04-28 10:00:00'),
(18, 12, TIMESTAMP '2024-05-15 14:30:00'),
(19, 13, TIMESTAMP '2024-06-22 12:00:00');


-- Insert data into DeviceSecurityEvents table
INSERT INTO DeviceSecurityEvents (id, event_timestamp, event_details) VALUES
(1, TIMESTAMP '2024-09-01 07:55:00', 'login failure'),
(2, TIMESTAMP '2024-09-02 14:10:00', 'suspicious activity detected'),
(3, TIMESTAMP '2024-09-03 09:40:00', 'device connected to unknown network'),
(4, TIMESTAMP '2024-09-04 11:15:00', 'multiple failed login attempts'),
(5, TIMESTAMP '2024-09-05 15:55:00', 'firewall breach attempt'),
(6, TIMESTAMP '2024-09-06 08:25:00', 'antivirus software outdated'),
(7, TIMESTAMP '2024-09-07 14:40:00', 'unauthorized access attempt'),
(8, TIMESTAMP '2024-09-08 10:10:00', 'malware detected'),
(9, TIMESTAMP '2024-09-09 11:55:00', 'suspicious file download'),
(10, TIMESTAMP '2024-09-10 17:25:00', 'device disconnected unexpectedly'),
(11, TIMESTAMP '2024-09-11 08:55:00', 'login from unusual location'),
(12, TIMESTAMP '2024-09-12 11:40:00', 'operating system update required'),
(13, TIMESTAMP '2024-09-13 16:10:00', 'password reset successful'),
(14, TIMESTAMP '2024-09-14 10:05:00', 'bluetooth connection established'),
(15, TIMESTAMP '2024-09-15 12:00:00', 'data encryption enabled');
