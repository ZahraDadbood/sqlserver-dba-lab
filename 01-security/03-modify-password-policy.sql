/*
===============================================================================
Script Name : 03-modify-password-policy.sql
Project     : SQL Server DBA Lab
Category    : Security
Topic       : SQL Login Password Policy
Author      : Zahra Dadbood

Description:
Modifies SQL Login password policy settings.

This script demonstrates how to disable password expiration
while keeping Windows password policy enforcement enabled.

Recommended for SQL Logins used by applications.

Tested On:
SQL Server 2016+
===============================================================================
*/

USE master;
GO

/*=============================================================================
Step 1 - Verify Current Login Settings
=============================================================================*/

SELECT
    name AS LoginName,
    is_policy_checked AS CheckPolicy,
    is_expiration_checked AS CheckExpiration
FROM sys.sql_logins
WHERE name = 'AppLogin';
GO

/*=============================================================================
Step 2 - Modify Login Settings
=============================================================================*/

ALTER LOGIN AppLogin
WITH CHECK_POLICY = ON,
     CHECK_EXPIRATION = OFF;
GO

PRINT 'Password policy settings updated successfully.';
GO

/*=============================================================================
Step 3 - Verify Changes
=============================================================================*/

SELECT
    name AS LoginName,
    is_policy_checked AS CheckPolicy,
    is_expiration_checked AS CheckExpiration
FROM sys.sql_logins
WHERE name = 'AppLogin';
GO

/*=============================================================================
Expected Result

LoginName        : AppLogin
CheckPolicy      : 1
CheckExpiration  : 0

Result:
Password complexity remains enforced while password expiration
is disabled.

Next Step:
Run:
04-cleanup-demo.sql
=============================================================================*/