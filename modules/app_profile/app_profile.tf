resource "aci_application_profile" "aci_p01_ap" {
  tenant_dn         = var.tenant_id
  name              = "aci_app1_prod"
  description = "from terraform"
  name_alias = "app1"
}

