variable "organisation_id" {
  description = "The organization id for the associated services"
}

variable "project_id" {
  description = "ID for the project"
}

variable "gcp_region" {
  description = "GCP Region"
  default = "us-central1"
}

variable "gcp_zone" {
  description = "GCP zone"
  default = "us-central1-b"
}

variable "activate_apis" {
  description = "The list of apis to activate for the project"
  type        = list(string)
  default     = [
    "container.googleapis.com",
    "monitoring.googleapis.com",
    "logging.googleapis.com",
    "cloudtrace.googleapis.com",
    "meshca.googleapis.com",
    "meshtelemetry.googleapis.com",
    "meshconfig.googleapis.com",
    "iamcredentials.googleapis.com",
    "gkeconnect.googleapis.com",
    "gkehub.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "stackdriver.googleapis.com",
    "anthos.googleapis.com",
    "cloudbuild.googleapis.com",
  ]
}

variable "allow_org_policies" {
  description = "List of ALLOW org policies for the project"
  type        = list(string)
  default     = [
    "constraints/compute.vmExternalIpAccess", 
    "constraints/cloudbuild.allowedWorkerPools",
    "constraints/compute.restrictVpcPeering",
    # "constraints/iam.allowedPolicyMemberDomains",
  ]
}
