--USE ROLE ACCOUNTADMIN;

--CREATE OR REPLACE DATABASE PROD_US_DOMAINS;

--CREATE OR REPLACE SCHEMA STAGING_DATA;

-- TABLE CREATION:
CREATE OR ALTER TABLE "{{database}}"."{{schema_nm}}".EMPLOYEE (
  EMP_ID NUMBER(38,0),
  EMP_NAME varchar,
  EMP_DEP varchar,
  EMP_GENDER varchar,
  EMP_SAL NUMBER(38,0)
) data_retention_time_in_days = 1;
