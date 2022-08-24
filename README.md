# SQL Data Warehouse Deployment Automation

This project covers the management, build, drift reporting and publishing of SQL Database projects for both:

1. SDK-style SQL Database Projects (Azure Data Studio DB Projects) and
2. Standard SQL Database Projects (Visual Studio DB Projects).

Each of these SQL Database Projects can be found in the [`code`](/code/) folder and each one of them contains the exact same artifact definitions: a schema definition, a role definition and a table definition.

This project demonstrates the following:

1. Comparison of both project types to better understand how each one of them roles out incremental changes to the database.
2. Automation of SQL Database Project build, drift reporting, deploy reports and publishing using GitHub Actions.

## Automation of build, drift reporting and publishing

This repository automates the lifecycle of SQL database projects using GitHub Actions. As SDK-sytle SQL Database Projects are built on top of .NET Core 6, the build can run on Linux, Mac and Windows machines. This is different for the standard SQL Database projects as they are relying on the older .NET Framework and therefore can only be build on Windows agents. In the [`.github/workflows`](/.github/workflows/) folder, you can find a number of GitHub reusable workflow templates:

* [`buildDotNetCoreTemplate.yml`](/.github/workflows/buildDotNetCoreTemplate.yml): Is used to build a SDK-style database project and create an output artifact based on the successful build.
* [`buildDotNetTemplate.yml`](/.github/workflows/buildDotNetTemplate.yml): Is used to build a standard database project and create an output artifact based on the successful build. This workflow has to run on a Windows agent.
* [`reportTemplate.yml`](/.github/workflows/reportTemplate.yml): Is used to generate a deploy report and a drift report before applying changes to a target database. The workflow first downloads the build artifact and then generates the reports. An output artifact containing the reports is created, which can be reviewed by the code reviewer before approving the pull request or the deployment to the target database.
* [`deployTemplate.yml`](/.github/workflows/deployTemplate.yml): Is used to publish incremental changes to a target database. The workflow first downloads the build artifact and then applies the changes.

These reusable GitHub workflows are used by the following GitHub Action workflows:
* [`sqlDotNetCore.yml`](/.github/workflows/sqlDotNetCore.yml): Is used to run the end-to-end process for the SDK-style database project that includes build, report generation and deployment.
* [`sqlDotNet.yml`](/.github/workflows/sqlDotNet.yml): Is used to run the end-to-end process for the standard database project that includes build, report generation and deployment.

## Comparison of database project types

As both database projects contain the exact same artifact definitions, we can evaluate how each one of them performs on different tasks and changes in the source database project. The reports generated for each project on a pull request can be reviewed to understand how incremental changes are applied within the respective template.
