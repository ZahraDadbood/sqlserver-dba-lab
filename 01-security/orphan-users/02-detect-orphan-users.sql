/*
===============================================================================
Script Name : 02-detect-orphan-users.sql
Project     : SQL Server DBA Lab
Category    : Security
Topic       : Orphan Users
Author      : Zahra Dadbood

Description:
Detects orphan users across all online user databases.

An orphan user is a database user whose SID does not match any SQL
Server login on the current instance.

This script scans all databases and returns orphan users, excluding:
    - guest
    - DATABASE_ROLE principals

Tested On:
SQL Server 2016+
===============================================================================
*/

PRINT 'Scanning all databases for orphan users...';
GO

EXEC sp_MSforeachdb '
IF DB_ID(''?'') > 4
BEGIN
    USE [?];

    SELECT
        DB_NAME() AS DatabaseName,
        name AS UserName,
        type_desc AS PrincipalType,
        authentication_type_desc AS AuthenticationType,
        create_date,
        modify_date
    FROM sys.database_principals
    WHERE sid NOT IN
    (
        SELECT sid
        FROM master.sys.server_principals
    )
    AND type_desc <> ''DATABASE_ROLE''
    AND name <> ''guest''
    ORDER BY name;
END
';
GO

PRINT 'Scan completed.';
GO

/*
===============================================================================
Expected Result

DatabaseName   UserName    PrincipalType
-------------  ----------  ----------------
SecurityLab    LabUser     SQL_USER

If rows are returned, those users are orphaned.

Next Step:
Run:
03-fix-orphan-users.sql
===============================================================================
*/