# OIDC Module

Creates AWS IAM OIDC identity provider for GitHub Actions authentication.

## Usage

```hcl
module "oidc" {
  source = "../modules/oidc"
}
```

## Outputs

- `oidc_provider_arn` - ARN of the OIDC identity provider
- `oidc_provider_url` - URL of the OIDC identity provider

## Security

Uses GitHub's official OIDC thumbprints and is configured for `sts.amazonaws.com` audience. No variables required.