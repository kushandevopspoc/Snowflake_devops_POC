-- ALWAYS USE ACCOUN ADMIN LEVEL ROLE
USE ROLE ACCOUNTADMIN;

-- CREATING A SMALL WAREHOUSE FOR COMPUTE NEEDS
CREATE WAREHOUSE IF NOT EXISTS POC_WH WAREHOUSE_SIZE = XSMALL, AUTO_SUSPEND = 300, AUTO_RESUME= TRUE;

-- Separate database for git repository
CREATE DATABASE IF NOT EXISTS SNOWCONES_DEVOPS_POC;

-- Schema for the Github integrations
CREATE SCHEMA IF NOT EXISTS SNOWCONES_DEVOPS_POC.POC;

-- Setting context:

USE DATABASE SNOWCONES_DEVOPS_POC;

USE SCHEMA SNOWCONES_DEVOPS_POC.POC;

-- API integration is needed for GitHub integration
-- For enterprise refer below document for creating the api integration
-- https://docs.snowflake.com/en/sql-reference/sql/create-api-integration#access-control-requirements
CREATE OR REPLACE API INTEGRATION GIT_API_INTEGRATION
  API_PROVIDER = git_https_api
  API_ALLOWED_PREFIXES = ('https://github.com/kushandevopspoc') -- INSERT THE GITHUB USERNAME HERE
  ENABLED = TRUE;

-- Git repository object is similar to external stage
-- For enterprise refer below document for creating the api integration
-- https://docs.snowflake.com/en/sql-reference/sql/create-git-repository
CREATE OR REPLACE GIT REPOSITORY GIT_REPO_STG
  API_INTEGRATION = GIT_API_INTEGRATION
  ORIGIN = 'https://github.com/kushandevopspoc/Snowflake_devops_POC/'; -- INSERT URL OF REPO HERE

-- Repo refresh command
alter git repository SNOWCONES_DEVOPS_POC.POC.GIT_REPO_STG fetch;

-- Showing branches in the specific repo:
show git branches in GIT_REPO_STG;

-- listing the files from repo:
list @GIT_REPO_STG/branches/;

-- executing the files directly from repo:
EXECUTE IMMEDIATE FROM @git_repo_stg/branches/main/PROD_US_DOMAINS/STAGING_DATA/Tables/T_Devops_Demo.sql;
