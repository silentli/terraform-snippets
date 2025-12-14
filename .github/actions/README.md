# Terraform Actions

Minimal, reusable composite actions for Terraform workflows.

## Prerequisites

**Important**: Install Terraform once in the main workflow before using these actions:

```yaml
- name: Setup Terraform
  uses: hashicorp/setup-terraform@v3
  with:
    terraform_version: 1.10.0
```

## Available Actions

### `tf-fmt`
Run `terraform fmt -check -recursive` for formatting validation.

```yaml
- uses: ./.github/actions/tf-fmt
  with:
    working_directory: 01-network
```

### `tf-init`
Run `terraform init` to initialize the working directory.

```yaml
- uses: ./.github/actions/tf-init
  with:
    working_directory: 01-network
```

### `tf-validate`
Run `terraform validate` to validate configuration (requires init first).

```yaml
- uses: ./.github/actions/tf-validate
  with:
    working_directory: 01-network
```

### `tf-plan`
Run `terraform plan` with optional var-file and extra arguments.

```yaml
- uses: ./.github/actions/tf-plan
  with:
    working_directory: 01-network
    varfile: envs/dev/network.tfvars  # optional
    out: tfplan                      # optional, default: tfplan
    extra_args: "-target=module.vpc" # optional
```

### `tf-apply`
Run `terraform apply` on a plan file with optional auto-approve and extra arguments.

```yaml
- uses: ./.github/actions/tf-apply
  with:
    working_directory: 01-network
    plan_file: tfplan                # optional, default: tfplan
    auto_approve: 'true'             # optional, default: 'false'
    extra_args: "-parallelism=10"    # optional
```

**Outputs**: `tf-apply` captures Terraform outputs as JSON:
```yaml
- uses: ./.github/actions/tf-apply
  id: apply
  with:
    working_directory: 01-network

- name: Use outputs
  run: echo "${{ steps.apply.outputs.outputs_json }}"
```
