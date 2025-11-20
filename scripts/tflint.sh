#!/bin/bash

# TFLint Runner Script
# Runs TFLint on all Terraform directories

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Running TFLint on all Terraform directories...${NC}\n"

# Directories to check
DIRECTORIES=(
  "00-bootstrap"
  "01-network"
  "02-ec2-creation"
  "cost-governance"
  "modules/network"
  "modules/oidc"
  "modules/s3-backend"
  "modules/iam-network"
  "modules/iam-compute"
  "modules/iam-ec2"
  "modules/budgets"
)

# Initialize TFLint from root (uses root .tflint.hcl)
echo -e "${YELLOW}Initializing TFLint plugins...${NC}"
tflint --init

# Run TFLint on each directory
FAILED=0
for dir in "${DIRECTORIES[@]}"; do
  if [ -d "$dir" ]; then
    echo -e "\n${YELLOW}Checking $dir...${NC}"
    # Run tflint and capture output (tflint exits non-zero if warnings found)
    set +e  # Don't exit on error
    OUTPUT=$(tflint --chdir="$dir" --format=default 2>&1)
    EXIT_CODE=$?
    set -e  # Re-enable exit on error
    
    # For modules, version warnings are acceptable (modules don't need versions.tf)
    if [[ "$dir" == modules/* ]]; then
      # Check if there are any non-version warnings
      NON_VERSION_WARNINGS=$(echo "$OUTPUT" | grep "Warning:" | grep -vE "terraform_required_version|terraform_required_providers" | wc -l | tr -d ' ')
      
      if [ "$NON_VERSION_WARNINGS" -eq 0 ] && [ "$EXIT_CODE" -ne 0 ]; then
        # Only version warnings exist, which is acceptable for modules
        echo -e "${GREEN}✓ $dir passed (version warnings are acceptable for modules)${NC}"
      elif [ "$EXIT_CODE" -eq 0 ]; then
        echo -e "${GREEN}✓ $dir passed${NC}"
      else
        # Other warnings exist, show them
        echo "$OUTPUT"
        echo -e "${RED}✗ $dir failed${NC}"
        FAILED=1
      fi
    else
      # For projects, all warnings are failures
      if [ "$EXIT_CODE" -eq 0 ]; then
        echo -e "${GREEN}✓ $dir passed${NC}"
      else
        echo "$OUTPUT"
        echo -e "${RED}✗ $dir failed${NC}"
        FAILED=1
      fi
    fi
  else
    echo -e "${YELLOW}⚠ $dir not found, skipping...${NC}"
  fi
done

echo ""
if [ $FAILED -eq 0 ]; then
  echo -e "${GREEN}All checks passed!${NC}"
  exit 0
else
  echo -e "${RED}Some checks failed${NC}"
  exit 1
fi
