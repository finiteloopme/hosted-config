
##################################################################
# 1. Configure Config Controller
##################################################################
module "host-config-controller"{
  source                  = "git::https://github.com/finiteloopme/tf-modules-argolis.git//modules/hosted-config-controller"

  host_project_id         = var.project_id
  config_connector_region = var.gcp_region
  config_connecor_id      = "altostrat-hosted-cc"

}

##################################################################
# 2. Assign appropriate project roles(s) to CC SA
##################################################################
# module "project-iam-bindings" {
#   source    = "terraform-google-modules/iam/google//modules/projects_iam"
#   projects  = [var.project_id]

#   bindings = {
#     "roles/owner" = ["serviceAccount:${module.host-config-controller.config_controller_sa}"]
#   }
# }

module "member_roles" {
  source                  = "terraform-google-modules/iam/google//modules/member_iam"
  service_account_address = module.host-config-controller.config_controller_sa
  prefix                  = "serviceAccount"
  project_id              = var.project_id
  project_roles           = ["roles/owner"]
}
