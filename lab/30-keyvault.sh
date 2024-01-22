if [ -n "$VAULT_NAME" ]; then
    for secret_name in $(az keyvault secret list --vault-name "$VAULT_NAME" --query '[].name' --output tsv); do
        secret_value=$(az keyvault secret show --vault-name "$VAULT_NAME" --name $secret_name --query value --output tsv)
        secret_name=${secret_name@U}
        secret_name=${secret_name//-/_}
        echo "Exporting $secret_name"
        export $secret_name="$secret_value"
        unset secret_name secret_value
    done
fi
