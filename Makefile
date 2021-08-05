# organisation_id=870163400932
# project_id="anthos-demo-kunall"
ORG_ID=870163400932
PROJECT_ID=bootstrap-altostrat-kl
INFRA=0-infra
PLATFORM=1-platform
dummy:

init:
	gsutil mb -p ${PROJECT_ID} gs://${PROJECT_ID}
	gsutil versioning set on gs://${PROJECT_ID}

enable-compute:
	gcloud services enable compute.googleapis.com --project=${PROJECT_ID}

disable-compute:
	gcloud services disable compute.googleapis.com --project=${PROJECT_ID}

tf-clean:
	cd ${INFRA}; rm -fr .terraform*
	cd ${PLATFORM}; rm -fr .terraform*

state-clean:
	cd ${INFRA}; rm -fr terraform.tfstate
	cd ${PLATFORM}; rm -fr terraform.tfstate

clean-all: tf-clean state-clean
	cd ${INFRA}; rm -fr *tfout
	cd ${PLATFORM}; rm -fr *tfout

infra-init:
	cd ${INFRA}; terraform init

infra-plan: infra-init enable-compute 
	cd ${INFRA}; terraform plan -var="organisation_id=${ORG_ID}" -var="project_id=${PROJECT_ID}" -out=${PROJECT_ID}-infra.tfout

infra-apply: infra-plan 
	cd ${INFRA}; terraform apply ${PROJECT_ID}-infra.tfout

infra-deploy: infra-apply

infra-clean-dummy: enable-compute
	cd ${INFRA}; terraform destroy -var="organisation_id=${ORG_ID}" -var="project_id=${PROJECT_ID}" -auto-approve

infra-clean: infra-clean-dummy disable-compute 

platform-init:
	cd ${PLATFORM}; terraform init

platform-plan: platform-init enable-compute 
	cd ${PLATFORM}; terraform plan -var="project_id=${PROJECT_ID}" -out=${PROJECT_ID}-pf.tfout

platform-apply: platform-plan 
	cd ${PLATFORM}; terraform apply ${PROJECT_ID}-pf.tfout

platform-deploy: infra-deploy platform-apply

platform-clean-dummy: enable-compute
	cd ${PLATFORM}; terraform destroy -var="project_id=${PROJECT_ID}" -auto-approve

platform-clean: platform-clean-dummy disable-compute 