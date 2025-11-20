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

# Determine repo root (script can be run from anywhere)
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

PROJECTS=(
  "00-bootstrap"
  "01-network"
  "02-ec2-creation"
  "cost-governance"
)

MODULES=(
  "modules/network"
  "modules/oidc"
  "modules/s3-backend"
  "modules/iam-network"
  "modules/iam-compute"
  "modules/iam-ec2"
  "modules/budgets"
)

DIRECTORIES=("${PROJECTS[@]}" "${MODULES[@]}")

ROOT_CONFIG="$ROOT_DIR/.tflint.hcl"

# Initialize TFLint once up front with the root config
echo -e "${YELLOW}Initializing TFLint plugins...${NC}"
tflint --config "$ROOT_CONFIG" --init

# Run TFLint on each directory with the appropriate config
FAILED=0
for dir in "${DIRECTORIES[@]}"; do
  TARGET_DIR="$ROOT_DIR/$dir"

  if [ ! -d "$TARGET_DIR" ]; then
    echo -e "${YELLOW}⚠ $dir not found, skipping...${NC}"
    continue
  fi

  echo -e "\n${YELLOW}Checking $dir...${NC}"
  if tflint --config "$ROOT_CONFIG" --chdir="$TARGET_DIR" --format=default; then
    echo -e "${GREEN}✓ $dir passed${NC}"
  else
    echo -e "${RED}✗ $dir failed${NC}"
    FAILED=1
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
