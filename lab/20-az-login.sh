if [ -n "$AZURE_CLIENT_ID" ]; then
    az login --identity --client-id $AZURE_CLIENT_ID --allow-no-subscriptions --debug
fi
