variable "tenant_id" {
    default = ""
}

variable "filters_entry" {
  type = map(object({
    filter = string,
    entry  = string,
    protocol = string,
    port = string
  }))
  description = "Map of filters to create and their associated subjects"
  default     = {}
}