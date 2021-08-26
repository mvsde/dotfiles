#!/bin/sh

# Somehow the system immediately wakes up after sending it to sleep.
# This seems to be related to any externally attached mouse or keyboard.

echo XHC > /proc/acpi/wakeup
