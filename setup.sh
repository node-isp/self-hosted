#!/usr/bin/env bash

# This script is used to configure the environment for the project.

# If the .env file already exists, then exit the script.
if [ -f .env ]; then
    echo "The .env file already exists. Please remove it before running this script."
    exit 1
fi

# Ask the user for the required inputs, and store them in the .env file.
# Company Name, Domain Name, License Key ID and License Key Code.

read -rp "Company name: " company_name

read -rp "Domain name: " domain_name

read -rp "License key ID: " license_key_id

read -rp "License key code: " license_key_code

# Generate APP Key, Database password
app_key=$(openssl rand -base64 32)
db_password=$(openssl rand -base64 32)

touch .env
# shellcheck disable=SC2129
echo "APP_NAME=\"$company_name\"" >> .env
echo "APP_KEY=base64:$app_key" >> .env
echo "APP_URL=https://$domain_name/" >> .env
echo "NODEISP_DOMAIN=$domain_name" >> .env
echo "NODEISP_LICENCE_KEY_ID=$license_key_id" >> .env
echo "NODEISP_LICENCE_KEY_CODE=$license_key_code" >> .env
echo "DB_PASSWORD=$db_password" >> .env
echo "DB_DATABASE=nodeisp" >> .env

echo "MAIL_MAILER=smtp" >> .env
echo "MAIL_HOST=" >> .env
echo "MAIL_PORT=" >> .env
echo "MAIL_USERNAME=" >> .env
echo "MAIL_PASSWORD=" >> .env
echo "MAIL_ENCRYPTION=tls" >> .env
echo "MAIL_FROM_ADDRESS=" >> .env
echo "MAIL_FROM_NAME=\"$company_name\"" >> .env

echo "SERVICES_GOOGLE_MAPS_API_KEY=" >> .env

echo
echo

echo "Store the following values in a safe place. If you lose the App Key, you will not be able to decrypt the data in the database."
echo "App Key: $app_key"
echo "DB Password: $db_password"

echo
echo "Please configure the mail settings in the .env file before starting the application, if required."
echo

echo "Environment setup is complete. Please run 'docker compose up -d' to start the application."
echo "Once booted, you can access the application at https://$domain_name/admin/ which will guide you through the setup process."
