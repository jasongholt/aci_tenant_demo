resource "aci_filter" "terraform_filter" {
    for_each    = var.filters_entry
    tenant_dn   = var.tenant_id
    description = "This is filter ${each.key} created by terraform"
    name        = each.value.filter
}

# Define an ACI Filter Entry Resource.
resource "aci_filter_entry" "terraform_filter_entry" {
    for_each      = var.filters_entry
    filter_dn     = aci_filter.terraform_filter[each.key].id
    name          = each.key
    ether_t       = "ipv4"
    prot          = each.value.protocol
    d_from_port   = each.value.port
    d_to_port     = each.value.port
}
