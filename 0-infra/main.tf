
##################################################################
# 1. Setup Project based services
##################################################################

module "project-setup"{
  source            = "git::https://github.com/finiteloopme/tf-modules-argolis.git//modules/setup-project"

  project_id          = var.project_id
  organisation_id     = var.organisation_id
  activate_apis       = var.activate_apis
  allow_org_policies  = var.allow_org_policies
}
