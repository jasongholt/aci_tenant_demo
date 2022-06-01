output "filter_dn" {
    value = values(aci_filter_entry.terraform_filter_entry).*.id
    }