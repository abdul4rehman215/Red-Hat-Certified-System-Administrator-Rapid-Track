#!/bin/bash
# Debug Script for Cron Execution

DEBUG_LOG=~/cron_debug.log

{
    echo "=== Cron Debug Session - $(date) ==="
    echo "Script executed from: $PWD"
    echo "Script path: $0"
    echo "Arguments: $@"
    echo "Environment variables:"
    env | sort
    echo "=== End Debug Session ==="
    echo ""
} >> $DEBUG_LOG 2>&1
