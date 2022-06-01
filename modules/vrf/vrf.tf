resource "aci_vrf" "vrf" {
    tenant_dn             = var.tenant_id
    name                  = var.vrf
    }

