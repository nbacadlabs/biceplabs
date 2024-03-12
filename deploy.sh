#!/bin/bash
az deployment group create \
    --resource-group biceptestRG \
    --name deployment \
    --template-file main.bicep \
    --parameters @params.json
