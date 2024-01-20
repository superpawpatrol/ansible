#!/bin/bash
# Improved script with better variable naming and checks for required scripts

# Exit on any error
set -e

# Improved variable naming for clarity
WORKING_DIRECTORY=$(pwd)

# Check if API script is present
API_SCRIPT_PATH="${WORKING_DIRECTORY}/bashCommun/apiPlatform.sh"
if [[ ! -f "${API_SCRIPT_PATH}" ]]; then
    echo "Error: API script not found at ${API_SCRIPT_PATH}" >&2
    exit 1
fi

# Define the constant variables script path
CONSTANTS_SCRIPT_PATH="${PATH_COM}/bashCommun/defConstantes.sh"

# Source the API and constant variables scripts
source "${API_SCRIPT_PATH}"
source "${CONSTANTS_SCRIPT_PATH}"

# Retrieve an IAMaaS token for interacting with Platform objects
TOKEN_IAMAAS=$(getIamaasToken ${CREDENTIALS_TAMAAS} "${SCOPES_TERRAFORM}")

# Check if the IAMaaS token was retrieved successfully
if [[ "$TOKEN_IAMAAS" == "null" ]]; then
  echo "Unable to retrieve IAMaaS token. The script requires at least one of the following scopes: obj:read, obj write, myvault: read, myvault: write."
  exit 1
else
  echo "IAMaaS token obtained successfully."
fi

# Verify if access keys exist for the specified client ID
echo "Verifying if access keys exist for client ID: ${CLIENT_ID}"
ACCESS_KEY_PARIS=$(getAccessKey ${TOKEN_IAMAAS} ${CLIENT_ID} Paris)
ACCESS_KEY_NORTH=$(getAccessKey ${TOKEN_IAMAAS} ${CLIENT_ID} North)

# Check if both access keys exist
if [[ "$ACCESS_KEY_PARIS" == "null" ]] && [[ "$ACCESS_KEY_NORTH" == "null" ]]; then
  # No access keys exist, create them
  echo "No access keys found for the specified client ID. Creating access keys..."
  ACCESS_KEY_PARIS=$(createAccessKey ${TOKEN_IAMAAS} ${CLIENT_ID} Paris)
  ACCESS_KEY_NORTH=$(createAccessKey ${TOKEN_IAMAAS} ${CLIENT_ID} North)

  # Check if the creation was successful
  if [[ "$ACCESS_KEY_PARIS" == "null" ]] || [[ "$ACCESS_KEY_NORTH" == "null" ]]; then
    echo "Failed to create access keys."
    exit 1
  else
    echo "Access keys created successfully."
    echo "Paris: $ACCESS_KEY_PARIS"
    echo "North: $ACCESS_KEY_NORTH"
  fi
else
  # Access keys exist for at least one location
  if [[ "$ACCESS_KEY_PARIS" != "null" ]]; then
    echo "Access key found for Paris location."
  else
    echo "Access key not found for Paris location."
  fi

  if [[ "$ACCESS_KEY_NORTH" != "null" ]]; then
    echo "Access key found for North location."
  else
    echo "Access key not found for North location."
  fi

  # Warn about the possibility of missing access keys
  echo "Warning: The script expects access keys to be present for both Paris and North locations. Missing access keys may prevent the infrastructure creation."
fi

# Verify the token for MyVault
TOKEN_MYVAULT=$(getMyVaultToken ${TOKEN_IAMAAS})
if [[ "$TOKEN_MYVAULT" == "null" ]]; then
  echo "Failed to retrieve MyVault token."
  exit 1
else
  echo "MyVault token obtained successfully."
fi

#########################################################
# Optimisation du code en utilisant les fonctions de Bash #
#########################################################
getAccessKeys() {
  ACCESS_KEY_PARIS=$(getAccessKey ${TOKEN_IAMAAS} ${CLIENT_ID} Paris)
  ACCESS_KEY_NORTH=$(getAccessKey ${TOKEN_IAMAAS} ${CLIENT_ID} North)

  if [[ "$ACCESS_KEY_PARIS" == "null" ]] || [[ "$ACCESS_KEY_NORTH" == "null" ]]; then
    echo "No access keys found for the specified client ID."
  else
    echo "Access keys found for both Paris and North locations."
  fi
}

try {
  ACCESS_KEY_PARIS=$(createAccessKey ${TOKEN_IAMAAS} ${CLIENT_ID} Paris)
  ACCESS_KEY_NORTH=$(createAccessKey ${TOKEN_IAMAAS} ${CLIENT_ID} North)
} catch {
  echo "Error creating access keys: $error"
  exit 1
}
