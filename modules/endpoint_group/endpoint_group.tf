resource "aci_application_epg" "application_epg" {
    application_profile_dn  = var.app_id
    name                              = var.epg_name
    description                   = var.description
    relation_fv_rs_bd       = var.bd_id
    # relation_fv_rs_cons     = var.contract_id
    # relation_fv_rs_prov     = var.contract_id

}