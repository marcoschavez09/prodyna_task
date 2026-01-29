# prodyna_task
Example infrastructure project. 

```
infrastructure/
├── README.md
├── .gitignore
├── azureTemplates/
│   ├── azure-pipelines-template-frontend.yml
│   └── azure-pipelines-template-backend.yml
├── terraform/
│   ├── environments/
│   │   ├── dev/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   ├── terraform.tfvars
│   │   │   ├── backend.tf
│   │   │   └── outputs.tf
│   │   ├── test/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   ├── terraform.tfvars
│   │   │   ├── backend.tf
│   │   │   └── outputs.tf
│   │   └── prod/
│   │       ├── main.tf
│   │       ├── variables.tf
│   │       ├── terraform.tfvars
│   │       ├── backend.tf
│   │       └── outputs.tf
│   ├── modules/
│   │   ├── static-web-app/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   ├── outputs.tf
│   │   │   └── README.md
│   │   ├── app-service/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   ├── outputs.tf
│   │   │   └── README.md
│   │   ├── cosmos-db/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   ├── outputs.tf
│   │   │   └── README.md
│   │   ├── key-vault/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   ├── outputs.tf
│   │   │   └── README.md
│   │   └── monitoring/
│   │       ├── main.tf
│   │       ├── variables.tf
│   │       ├── outputs.tf
│   │       └── README.md
│   └── shared/
│       ├── resource-group.tf
│       ├── networking.tf
│       └── common-variables.tf
├── pipelines/
│   ├── infrastructure/
│   │   ├── azure-pipelines-deploy-dev.yml
│   │   ├── azure-pipelines-deploy-test.yml
│   │   ├── azure-pipelines-deploy-prod.yml
│   │   ├── azure-pipelines-destroy-dev.yml
│   │   ├── azure-pipelines-destroy-test.yml
│   │   ├── azure-pipelines-destroy-prod.yml
├── scripts/
│   ├── azure-state-storage-creation.sh
│   └── verify-version.sh
└── docs/
    ├── architecture.md
    ├── deployment-guide.md
    └── troubleshooting.md
```
