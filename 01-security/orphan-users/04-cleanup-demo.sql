/*
===============================================================================
Script Name : 04-cleanup-demo.sql
Project     : SQL Server DBA Lab
Category    : Security
Topic       : Orphan Users
Author      : Zahra Dadbood

Description:
Removes all objects created during this lab.

This script returns the SQL Server instance to its original state.

Tested On:
SQL Server 2016+
===============================================================================
*/

USE master;
GO

/*=============================================================================
Step 1 - Drop Demo Database
=============================================================================*/

IF DB_ID('SecurityLab') IS NOT NULL
BEGIN
    ALTER DATABASE SecurityLab
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

    DROP DATABASE SecurityLab;

    PRINT 'Database [SecurityLab] removed.';
END
GO

/*=============================================================================
Step 2 - Drop Demo Login
=============================================================================*/

IF EXISTS
(
    SELECT 1
    FROM sys.server_principals
    WHERE name = 'LabUser'
)
BEGIN
    DROP LOGIN LabUser;

    PRINT 'Login [LabUser] removed.';
END
GO

/*=============================================================================
Cleanup Completed
=============================================================================*/

PRINT 'Lab cleanup completed successfully.';
GO