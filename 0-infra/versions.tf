terraform {
  required_version = ">= 0.14.8"
  backend "gcs" {
    # bucket  = var.project_id
    # TODO: FIXME
    bucket  = "bootstrap-altostrat-kl"
    prefix  = "terraform/state/infra"
  }
}