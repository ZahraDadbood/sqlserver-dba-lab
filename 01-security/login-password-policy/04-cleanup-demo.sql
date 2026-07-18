/*
===============================================================================
Script Name : 04-cleanup-demo.sql
Project     : SQL Server DBA Lab
Category    : Security
Topic       : SQL Login Password Policy
Author      : Zahra Dadbood

Description:
Removes the SQL Login created for this lab.

This script restores the SQL Server instance to its original state.

Tested On:
SQL Server 2016+
===============================================================================
*/

USE master;
GO

/*=============================================================================
Step 1 - Remove Demo Login
=============================================================================*/

IF EXISTS
(
    SELECT 1
    FROM sys.sql_logins
    WHERE name = 'AppLogin'
)
BEGIN
    DROP LOGIN AppLogin;

    PRINT 'Demo login [AppLogin] removed successfully.';
END
ELSE
BEGIN
    PRINT 'Demo login does not exist.';
END
GO

/*=============================================================================
Cleanup Completed
=============================================================================*/

PRINT 'Lab cleanup completed successfully.';
GO