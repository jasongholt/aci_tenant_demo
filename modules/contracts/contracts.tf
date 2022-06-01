# Define an ACI Contract Resource.
resource "aci_contract" "terraform_contract" {
    for_each      = var.contract
    tenant_dn     = var.tenant_id
    name          = each.key
    scope         = "tenant"
    description   = "Contract created using Terraform"
}

# Define an ACI Contract Subject Resource.
resource "aci_contract_subject" "terraform_contract_subject" {
    for_each                      = var.contract
    contract_dn                   = aci_contract.terraform_contract[each.key].id
    name                          = each.value.subject
    relation_vz_rs_subj_filt_att  = var.relation_vz_rs_subj_filt_att
}

# Assignes the Contracts to the EPG for the web epgs
resource "aci_epg_to_contract" "terraform_epg_to_contract" {
    for_each           = var.epg_to_contract
    #application_epg_dn = var.epg_dn
    application_epg_dn = each.value.epg
    contract_dn        = aci_contract.terraform_contract[each.value.contract].id
    contract_type      = each.value.contract_type
}