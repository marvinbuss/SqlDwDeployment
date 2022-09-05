# Synapse & SQL Data Warehouse Deployment Automation

This project covers the following aspects for a Synapse- and SQL Data Warehouse-based data project:

1. Infrastructure as Code (IaC): Validation, What-If and Deployment,
2. Synapse Artifacts: Validation and Deployment and
3. Synapse SQL Pool: Build, Drift Reporting and Publishing of SQL DB Projects.

This reference implementation shows you how to safely rollout changes across a `development`, `test` and `production` environment using GitHub Actions.

## SQL Database Projects

### Code Artifacts

In this project, the management, build, drift reporting and publishing of SQL Database projects is covered for both:

1. SDK-style SQL Database Projects (Azure Data Studio DB Projects) and
2. Standard SQL Database Projects (Visual Studio DB Projects).

Each of these SQL Database Projects can be found in the [`code`](/code/) folder and each one of them contains the exact same artifact definitions: a schema definition, a role definition, a table definition, a pre-deployment script and a post-deployment script.

### Automation and Deployment

This repository automates the lifecycle of SQL database projects using GitHub Actions. As SDK-sytle SQL Database Projects are built on top of .NET Core 6, the build can run on Linux, Mac and Windows machines. This is different for the standard SQL Database projects as they are relying on the older .NET Framework and therefore can only be build on Windows agents. In the [`.github/workflows`](/.github/workflows/) folder, you can find a number of reusable GitHub workflow templates:

* [`buildDotNetCoreTemplate.yml`](/.github/workflows/buildDotNetCoreTemplate.yml): Is used to build a SDK-style database project and create an output artifact based on the successful build.
* [`buildDotNetTemplate.yml`](/.github/workflows/buildDotNetTemplate.yml): Is used to build a standard database project and create an output artifact based on the successful build. This workflow has to run on a Windows agent.
* [`reportTemplate.yml`](/.github/workflows/reportTemplate.yml): Is used to generate a deploy report and a drift report before applying changes to a target database. The workflow first downloads the build artifact and then generates the reports. An output artifact containing the reports is created, which can be reviewed by the code reviewer before approving the pull request or the deployment to the target database.
* [`deployTemplate.yml`](/.github/workflows/deployTemplate.yml): Is used to publish incremental changes to a target database. The workflow first downloads the build artifact and then applies the changes.

These reusable GitHub workflows are used by the [`devWorkflow.yml`](/.github/workflows/devWorkflow.yml), [`tstWorkflow.yml`](/.github/workflows/tstWorkflow.yml) and [`prdWorkflow.yml`](/.github/workflows/prdWorkflow.yml) to apply changes in the right order.

## Synapse

### Code Artifacts

Only the development Synapse workspace is connected to this repository to check in changes and updates to pipelines, triggers and all other artifacts. Synapse artifacts are checked into [`code/synapse`](/code/synapse). The `main` branch is used as a collaboraton branch and the `synapse/publish` branch is used as a publish branch. Both branches are protected. `synapse/publish` is used to review changes to the main synapse template after publishing it in the Synapse workspace and before merging it back into the `main` branch. The changed template may also expose new parameters, which may have to be added to the parameter files for the higher environments `test` and `production`.

The just mentioned parameter files for the higher environments can be found in [`code/synapseParameters`](/code/synapseParameters). This is required to make sure the correct resources are referenced in the higher environments when deploying updates.

Since our development workspace is called `data-auto-dev-synapse001`, you can find the generated template in the following folder [`data-auto-dev-synapse001`](/data-auto-dev-synapse001).

### Automation and Deployment

The deployment to the `development` and `production` environment is done in two steps: 1. Validation of Templates and 2. Deploymen of Templates. For this phased rollout process, the following reusable GitHub workflow templates are used:

* [`synapseValidationTemplate.yml`](/.github/workflows/synapseValidationTemplate.yml): Is used to validate the Synapse artifacts.
* [`synapseDeploymentTemplate.yml`](/.github/workflows/synapseDeploymentTemplate.yml): Is used to deploy the Synapse artifacts. A pre- and post-deployment script is executed in order to ensure a safe rollout of changes and no data inconsistencies.

These reusable GitHub workflows are used by the [`devWorkflow.yml`](/.github/workflows/devWorkflow.yml), [`tstWorkflow.yml`](/.github/workflows/tstWorkflow.yml) and [`prdWorkflow.yml`](/.github/workflows/prdWorkflow.yml) to apply changes in the right order.

## Infrastructure as Code (IaC)

### Code Artifacts

The Infrastructure as Code (IaC) artifacts are defined in bicep and can be found in the [`infra`](/infra) folder. The infrastructure is structured into modules and sub-modules and can be used to apply the configuration towards the `development`, `test` and `production` environment. A parameter file per environment (`params.{environment-name}.json`) specifies the properties for each environment.

### Automation and Deployment

The deployment to the environments is done in two steps: 1. Validation of Templates and 2. Deploymen of Templates. For this phased rollout process, the following reusable GitHub workflow templates are used:

* [`infraValidationTemplate.yml`](/.github/workflows/infraValidationTemplate.yml): Is used to validate the IaC template. A What-If report is also generated to provide a report on which changes will be made.
* [`infraDeploymentTemplate.yml`](/.github/workflows/infraDeploymentTemplate.yml): Is used to deploy the IaC artifacts to the Azure environment.

These reusable GitHub workflows are used by the [`devWorkflow.yml`](/.github/workflows/devWorkflow.yml), [`tstWorkflow.yml`](/.github/workflows/tstWorkflow.yml) and [`prdWorkflow.yml`](/.github/workflows/prdWorkflow.yml) to apply changes in the right order.
