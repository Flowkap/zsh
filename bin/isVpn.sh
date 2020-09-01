#!/bin/bash
if [[ $(ip addr | grep tun0 ) ]]; then echo VPN; fi
