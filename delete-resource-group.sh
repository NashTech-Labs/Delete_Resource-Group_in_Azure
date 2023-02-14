#!/bin/bash

echo "List of all ResourceGroups"

az group list -o table

echo "Enter ResourceGroup Name, you want to delete:"
read rgname

az group list -o table | sed 's/\|/ /'|awk '{print $1}' | awk '/^Name|^-----|^Name/ {next}{for (i=1;i<=NF;i++){print $i}}' > rg-list.txt

echo "====Checking ResourceGroup exists or not====="

        if grep -w -i $rgname rg-list.txt
        then

        az group delete --resource-group $rgname

        echo "----Deleted ResourceGroup----"

        rm rg-list.txt
        else
        echo "----ResourceGroup not available----"
        rm rg-list.txt
        fi
