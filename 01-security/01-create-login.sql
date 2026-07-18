/*
===============================================================================
Script Name : 01-create-login.sql
Project     : SQL Server DBA Lab
Category    : Security
Topic       : SQL Login Password Policy
Author      : Zahra Dadbood

Description:
Creates a SQL Login to demonstrate SQL Server password policy settings,
including CHECK_POLICY and CHECK_EXPIRATION.

This login simulates an application login used by a production system.

Tested On:
SQL Server 2016+
===============================================================================
*/

USE master;
GO

/*=============================================================================
Step 1 - Remove Existing Demo Login (if exists)
=============================================================================*/

IF EXISTS
(
    SELECT 1
    FROM sys.sql_logins
    WHERE name = 'AppLogin'
)
BEGIN
    DROP LOGIN AppLogin;
END
GO

PRINT 'Previous demo login removed.';
GO

/*=============================================================================
Step 2 - Create Demo SQL Login
=============================================================================*/

CREATE LOGIN AppLogin
WITH PASSWORD = 'SecurityLab@195',
     CHECK_POLICY = ON,
     CHECK_EXPIRATION = ON;
GO

PRINT 'SQL Login [AppLogin] created successfully.';
GO

/*=============================================================================
Step 3 - Verify Login Properties
=============================================================================*/

SELECT
    name,
    type_desc,
    is_policy_checked,
    is_expiration_checked,
    create_date
FROM sys.sql_logins
WHERE name = 'AppLogin';
GO

/*=============================================================================
Expected Result

Login Name          : AppLogin
CHECK_POLICY        : ON
CHECK_EXPIRATION    : ON

Next Step:
Run:
02-check-login-properties.sql
=============================================================================*/