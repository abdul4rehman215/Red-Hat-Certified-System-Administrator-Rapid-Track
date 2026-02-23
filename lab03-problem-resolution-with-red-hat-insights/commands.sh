#!/bin/bash
# Lab 03 – Problem Resolution with Red Hat Insights
# Commands Executed – Sequential Order

# ==============================
# VERIFY & REGISTER SUBSCRIPTION
# ==============================

sudo subscription-manager register --username labuser --password ********

sudo subscription-manager attach --auto


# ==============================
# INSTALL INSIGHTS CLIENT
# ==============================

sudo dnf install -y insights-client


# ==============================
# REGISTER SYSTEM WITH INSIGHTS
# ==============================

sudo insights-client --register


# ==============================
# RUN INITIAL SYSTEM ANALYSIS
# ==============================

sudo insights-client


# ==============================
# APPLY RECOMMENDED PACKAGE UPDATE
# ==============================

sudo dnf update bash -y


# ==============================
# FIX SSH CONFIGURATION ISSUE
# ==============================

sudo vi /etc/ssh/sshd_config

sudo systemctl restart sshd


# ==============================
# VERIFY RESOLUTION
# ==============================

sudo insights-client
