#!/bin/bash
nmcli radio wifi | grep -q enabled && echo true || echo false