#!/bin/bash
printf '\033]2;Core Speeds\a'
watch -n0.2 'cat /proc/cpuinfo | grep MHz'
