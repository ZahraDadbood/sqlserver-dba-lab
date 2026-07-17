
# Orphan Users in SQL Server

Orphan Users are database users that are no longer associated with a valid SQL Server login. This situation commonly occurs after restoring or migrating a database to another SQL Server instance.

## 📖 Overview

This project demonstrates how to:

- Create an orphan user scenario
- Detect orphan users
- Fix orphan users using supported methods
- Clean up the demo environment

## 📂 Files

| File | Description |
|------|-------------|
| 01-create-demo.sql | Creates a demo environment with an orphan user |
| 02-detect-orphan-users.sql | Identifies orphan users |
| 03-fix-orphan-users.sql | Demonstrates different methods to fix orphan users |
| 04-cleanup-demo.sql | Removes demo objects |

## 🎯 Learning Objectives

After completing this lab, you will be able to:

- Understand what orphan users are
- Identify the common causes
- Detect orphan users
- Repair orphan users safely
- Apply SQL Server security best practices

## 📚 Requirements

- Microsoft SQL Server 2016 or later
- SQL Server Management Studio (SSMS)

## 📝 Notes

The scripts in this lab are intended for learning and demonstration purposes. Always validate and test scripts before using them in production environments.
