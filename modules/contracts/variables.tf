variable "tenant_id" {
    default = ""
}
variable "epg_dn" {
    default = ""
}

variable "relation_vz_rs_subj_filt_att" {
    default = ""
}

variable "contract" {
  type = map(object({
    contract = string,
    subject  = string,
    filter = string,
  }))
  description = "Map of filters to create and their associated subjects"
  default     = {}
}

variable "epg_to_contract" {
  type = map(object({
    epg = string,
    contract  = string,
    contract_type = string,
  }))
  description = "Map of filters to create and their associated subjects"
  default     = {}
}
