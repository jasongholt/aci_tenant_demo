variable "tenant_id" {
    default = ""
    }

variable "vrf_id" {
    default = ""
    }

variable "bd" {
    default = ""
    }

variable "ip" {
    default = ""
    }

variable "arp_flood" {
    default = "yes"
}

variable "unicast_route" {
    default = "yes"
}

variable "unkunicast_route" {
    default = "flood"
}