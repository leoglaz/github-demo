# Sample GitHub Demo: Azure Function + Bicep + GitHub Actions
(TEST)
This repository demonstrates:
- An Azure Function written in Python
- Bicep code to deploy the Azure Function on a Consumption plan
- GitHub Actions workflow to deploy the function to Azure

## Structure
- `azure-function/` - Python Azure Function code
- `infra/` - Bicep deployment files
- `.github/workflows/` - GitHub Actions workflow

## How to Use
1. Update the workflow secrets with your Azure credentials.
2. Push changes to trigger deployment.
3. The workflow will deploy the Azure Function using Bicep on a Consumption plan.

## Features Demonstrated
- Source control (commits, branches, pull requests)
- CI/CD with GitHub Actions
- Infrastructure as Code with Bicep
- Azure Function deployment

---
Replace any placeholder values with your actual Azure subscription details before deploying.
