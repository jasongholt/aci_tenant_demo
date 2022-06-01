resource "aci_bridge_domain" "bd" {
    tenant_dn             = var.tenant_id
    arp_flood             = var.arp_flood
    unicast_route         = var.unicast_route
    unk_mac_ucast_act     = var.unkunicast_route
    relation_fv_rs_ctx    = var.vrf_id
    name                  = var.bd
    }

resource "aci_subnet" "bd_subnet" {
    parent_dn             = aci_bridge_domain.bd.id
    ip                    = var.ip
    } 