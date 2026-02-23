#!/bin/bash

# ===============================
# Lab 17 - Repository & Subscription Management
# ===============================

# Update system
sudo dnf update -y

# Check subscription status
sudo subscription-manager status

# Register system (replace credentials)
sudo subscription-manager register --username=myrhuser --password=********

# Attach subscription automatically
sudo subscription-manager attach --auto

# Verify consumed subscriptions
sudo subscription-manager list --consumed

# List available repositories
sudo subscription-manager repos --list | head

# Enable CodeReady Builder repository
sudo subscription-manager repos --enable=codeready-builder-for-rhel-9-$(arch)-rpms

# Disable repository
sudo subscription-manager repos --disable=codeready-builder-for-rhel-9-$(arch)-rpms

# Verify enabled repositories
sudo dnf repolist enabled

# Search for podman
sudo dnf search podman

# Install podman
sudo dnf install -y podman

# Verify installation
podman --version

# Final subscription check
sudo subscription-manager status
