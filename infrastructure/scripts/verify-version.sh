#!/bin/bash
# verify-version.sh - Verify infrastructure version consistency

# Flow:
# 1. Set environment
# 2. Get version from git tag
# 3. Get version from Terraform state
# 4. Get version from Azure resources
# 5. Compare versions
# 6. Print result