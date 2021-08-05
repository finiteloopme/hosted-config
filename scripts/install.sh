#!bin/bash

export CONFIG_CONTROLLER_NAME=kl-altostrat-gcp-krmapi
export PROJECT_ID=anthos-demo-kunall
export LOCATION=us-central1
gcloud config set project ${PROJECT_ID}
gcloud components install pkg
gcloud services enable krmapihosting.googleapis.com cloudresourcemanager.googleapis.com

# Create default network
gcloud compute networks create default --subnet-mode=auto
# Create required firewall rules
gcloud compute firewall-rules create allow-ssh-http --network default --allow tcp:22,tcp:3389,tcp:80,tcp:443,tcp:8080,tcp:8443,icmp

echo "Creating config connector can take upto 15 minutes"
gcloud alpha anthos config controller create ${CONFIG_CONTROLLER_NAME} \
  --location=${LOCATION}

gcloud alpha anthos config controller list --location=${LOCATION}
gcloud alpha anthos config controller get-credentials ${CONFIG_CONTROLLER_NAME} \
  --location ${LOCATION}

export SA_EMAIL="$(kubectl get ConfigConnectorContext -n config-control \
  -o jsonpath='{.items[0].spec.googleServiceAccount}' 2> /dev/null)"

gcloud projects add-iam-policy-binding "${PROJECT_ID}" \
  --member "serviceAccount:${SA_EMAIL}" \
  --role "roles/owner" \
  --project "${PROJECT_ID}"
