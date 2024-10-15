CREATE PROPERTY GRAPH SecurityGraph
  NODE TABLES (
    User,
    Device,
    Vulnerability
  )
  EDGE TABLES (
    DeviceAccessLog
      SOURCE KEY (id) REFERENCES Device 
      DESTINATION KEY (device_id) REFERENCES Device
      LABEL Accesses, 
    VulnerabilityMitigation
      SOURCE KEY (id) REFERENCES Device 
      DESTINATION KEY (vulnerability_id) REFERENCES Vulnerability
      LABEL Mitigates,
    UserDevice
      SOURCE KEY (id) REFERENCES User
      DESTINATION KEY (device_id) REFERENCES Device
      LABEL Possede 
  );