if [ -n "$AZURE_CLIENT_ID" ]; then
    az login --identity --username $AZURE_CLIENT_ID --allow-no-subscriptions
fi
