# SQL Login Password Policy

## Overview

A common cause of unexpected application outages is the expiration of SQL Login passwords.

When an application uses SQL Authentication and the login is configured with:

- CHECK_POLICY = ON
- CHECK_EXPIRATION = ON

the password may eventually expire, preventing the application from connecting to SQL Server.

This lab demonstrates:

- Creating an application login
- Checking password policy settings
- Modifying login properties
- Understanding security and availability trade-offs

---

## Learning Objectives

After completing this lab, you will be able to:

- Understand SQL Login password policies
- Identify login settings
- Configure CHECK_POLICY and CHECK_EXPIRATION
- Apply security best practices for application logins

---

## Execution Order

1. 01-create-login.sql
2. 02-check-login-properties.sql
3. 03-modify-password-policy.sql
4. 04-cleanup-demo.sql
