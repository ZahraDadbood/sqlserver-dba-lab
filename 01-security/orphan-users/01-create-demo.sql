/*
===============================================================================
Script Name : 01-create-demo.sql
Project     : SQL Server DBA Lab
Category    : Security
Topic       : Orphan Users
Author      : Zahra Dadbood

Description:
Creates a lab environment to simulate an orphan user scenario.

In real-world environments, orphan users commonly appear after restoring
or migrating a database to another SQL Server instance where the
corresponding SQL Server login does not exist.

This script safely simulates that scenario.

Tested On:
SQL Server 2016+
===============================================================================
*/

USE master;
GO

/*=============================================================================
Step 1 - Remove Existing Demo Objects
=============================================================================*/

IF DB_ID('SecurityLab') IS NOT NULL
BEGIN
    ALTER DATABASE SecurityLab
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

    DROP DATABASE SecurityLab;
END
GO

IF EXISTS
(
    SELECT 1
    FROM sys.server_principals
    WHERE name = 'LabUser'
)
BEGIN
    DROP LOGIN LabUser;
END
GO

PRINT 'Previous demo objects removed.';
GO

/*=============================================================================
Step 2 - Create SQL Server Login
=============================================================================*/

CREATE LOGIN LabUser
WITH PASSWORD = 'SecurityLab@195';
GO

PRINT 'Login [LabUser] created.';
GO

/*=============================================================================
Step 3 - Create Demo Database
=============================================================================*/

CREATE DATABASE SecurityLab;
GO

PRINT 'Database [SecurityLab] created.';
GO

/*=============================================================================
Step 4 - Create Database User
=============================================================================*/

USE SecurityLab;
GO

CREATE USER LabUser
FOR LOGIN LabUser;
GO

PRINT 'Database User [LabUser] created.';
GO

/*=============================================================================
Step 5 - Verify User Mapping
=============================================================================*/

SELECT
    dp.name AS UserName,
    dp.type_desc,
    dp.authentication_type_desc
FROM sys.database_principals AS dp
WHERE dp.name = 'LabUser';
GO

/*=============================================================================
Step 6 - Simulate Database Restore Scenario

In production environments, orphan users usually appear after restoring
a database to another SQL Server instance where the original SQL Login
does not exist.

To simulate this behavior, we remove the SQL Login while keeping
the database user.
=============================================================================*/

USE master;
GO

DROP LOGIN LabUser;
GO

PRINT 'Login [LabUser] removed successfully.';
PRINT 'Database User [LabUser] is now an ORPHAN USER.';
GO

/*=============================================================================
Verification

Run the following script next:

02-detect-orphan-users.sql

Expected Result:

Database : SecurityLab
Login    : Does NOT exist
User     : LabUser (Exists inside the database)

This simulates a common post-restore orphan user scenario.
=============================================================================*/