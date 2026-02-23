#!/bin/bash
# Environment Test Script

{
    echo "=== Environment Test - $(date) ==="
    echo "PATH: $PATH"
    echo "HOME: $HOME"
    echo "USER: $USER"
    echo "PWD: $PWD"
    echo "Shell: $SHELL"
    echo "=== End Environment Test ==="
    echo ""
} >> ~/env_test.log
