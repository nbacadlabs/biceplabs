#!/bin/bash
az deployment group create \
    --resource-group biceptestRG \
    --name deployment \
    --mode complete \
    --template-file main.bicep \
    --parameters @params.json
