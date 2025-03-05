#!/bin/bash


export AZCOPY_AUTO_LOGIN_TYPE=MSI

azcopy copy "$@"
