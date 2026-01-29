#!/bin/bash
# bootstrap-state-storage.sh
# Quick bootstrap script to create Terraform state storage using Azure CLI
# Alternative to using the Terraform bootstrap module

# Flow:
# 1. Set subscription
# 2. Create state storage for all environments
# 3. Print next steps