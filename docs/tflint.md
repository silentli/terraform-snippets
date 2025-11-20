# TFLint Guide

## Install
- **macOS:** `brew install tflint`
- **Linux:** download from the [releases page](https://github.com/terraform-linters/tflint/releases), unzip, move binary to your `$PATH`
- Any platform: grab the latest binary from the releases page

## Run It
1. **Install plugins**  
   ```bash
   tflint --init
   ```

2. **Single directory**  
   ```bash
   tflint --chdir=00-bootstrap --format=default
   ```

3. **All directories** (preferred)  
   ```bash
   ./scripts/tflint.sh
   ```

### Script behavior
- Projects (`00-bootstrap`, `01-network`, etc.) must pass every rule (they own `versions.tf`)
- Modules reuse callers’ providers, so the script ignores version warnings for anything under `modules/`

## Config Layout
- `.tflint.hcl` (repo root): enables AWS + Terraform rulesets, enforces required providers/versions in top-level projects
- `modules/.tflint.hcl`: extends the root config but disables `terraform_required_version` and `terraform_required_providers` so reusable modules don’t need their own `versions.tf`

## Troubleshooting
If TFLint complains about plugins (handshake errors, missing binaries), clear the cache and reinit:
```bash
rm -rf ~/.tflint.d/plugins
tflint --init
```
