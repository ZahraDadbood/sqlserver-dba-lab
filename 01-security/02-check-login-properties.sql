/*
===============================================================================
Script Name : 02-check-login-properties.sql
Project     : SQL Server DBA Lab
Category    : Security
Topic       : SQL Login Password Policy
Author      : Zahra Dadbood

Description:
Checks SQL Login password policy settings.

This script displays whether CHECK_POLICY and CHECK_EXPIRATION
are enabled for SQL Server logins.

Tested On:
SQL Server 2016+
===============================================================================
*/

USE master;
GO

/*=============================================================================
Step 1 - Check Login Properties
=============================================================================*/

SELECT
    name AS LoginName,
    type_desc AS LoginType,
    is_disabled AS IsDisabled,
    is_policy_checked AS CheckPolicy,
    is_expiration_checked AS CheckExpiration,
    create_date AS CreateDate,
    modify_date AS LastModified
FROM sys.sql_logins
WHERE name = 'AppLogin';
GO

/*=============================================================================
Step 2 - Interpretation

CheckPolicy = 1
    Password complexity policy is enabled.

CheckExpiration = 1
    Password expiration is enabled.

CheckExpiration = 0
    Password expiration is disabled.

=============================================================================*/

PRINT 'Login properties checked successfully.';
GO

/*=============================================================================
Expected Result

LoginName   : AppLogin
CheckPolicy : 1
CheckExpiration : 1

Next Step:
Run:
03-modify-password-policy.sql
=============================================================================*/