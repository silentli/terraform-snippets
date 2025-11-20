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
   tflint --config="$(pwd)/.tflint.hcl" --chdir=00-bootstrap --format=default
   ```

3. **All directories** (preferred)  
   ```bash
   ./scripts/tflint.sh
   ```

### Script behavior
- Uses the root `.tflint.hcl` for every directory, ensuring consistent rules
- Projects (`00-bootstrap`, `01-network`, etc.) must pass every rule (they own `versions.tf`)
- Modules reuse callers’ providers, so version/provider rules stay disabled in the shared config

## Config Layout
- `.tflint.hcl` (repo root): enables AWS + Terraform rulesets and configures all rules for both projects and modules

## Troubleshooting
If TFLint complains about plugins (handshake errors, missing binaries), clear the cache and reinit:
```bash
rm -rf ~/.tflint.d/plugins
tflint --init
```
