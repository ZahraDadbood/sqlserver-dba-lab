/*
===============================================================================
Script Name : 03-fix-orphan-users.sql
Project     : SQL Server DBA Lab
Category    : Security
Topic       : Orphan Users
Author      : Zahra Dadbood

Description:
Repairs orphan users by mapping them to an existing SQL Server login.

This script first recreates the missing login and then re-associates
the database user using ALTER USER ... WITH LOGIN.

Tested On:
SQL Server 2016+
===============================================================================
*/

USE master;
GO

/*=============================================================================
Step 1 - Recreate the Missing Login
=============================================================================*/

IF NOT EXISTS
(
    SELECT 1
    FROM sys.server_principals
    WHERE name = 'LabUser'
)
BEGIN
    CREATE LOGIN LabUser
    WITH PASSWORD = 'SecurityLab@195';

    PRINT 'Login [LabUser] created.';
END
ELSE
BEGIN
    PRINT 'Login [LabUser] already exists.';
END
GO

/*=============================================================================
Step 2 - Map the Database User to the Login
=============================================================================*/

USE SecurityLab;
GO

ALTER USER LabUser
WITH LOGIN = LabUser;
GO

PRINT 'Database User [LabUser] successfully mapped to Login [LabUser].';
GO

/*=============================================================================
Step 3 - Verify the Mapping
=============================================================================*/

SELECT
    dp.name AS UserName,
    sp.name AS LoginName
FROM sys.database_principals dp
LEFT JOIN master.sys.server_principals sp
ON dp.sid = sp.sid
WHERE dp.name = 'LabUser';
GO

/*=============================================================================
Expected Result

UserName    LoginName
----------  ----------
LabUser     LabUser

The orphan user has been successfully repaired.

Next Step:
Run:
04-cleanup-demo.sql
===============================================================================
*/