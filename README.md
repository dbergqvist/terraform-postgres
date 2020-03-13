# terraform-postgres

Repository accompanying the Medium post [Managing Cloud SQL resources with Terraform](https://medium.com/@bexie/managing-cloud-sql-resources-with-terraform-76cc044319e9)

I have created a secret.tfvars file that I don't version control. The file contains the following:

```terraform
project = "[PROJECT_ID]"
credentials_file = "[NAME].json"
```
I then use var-file to load it

```bash
terraform apply -var-file="secret.tfvars"
```
