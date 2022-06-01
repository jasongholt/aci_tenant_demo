output "tenant_id" {
  value = module.my_tenant.tenant_id
}
output "vrf_id" {
  value = module.my_vrf.vrf_id
}
output "app_id" {
  value = module.my_app_profile.app_id
}
output "filter_dn" {
  value = module.my_filters.filter_dn
}
output "contract_dn" {
  value = module.my_contracts.contract_dn
}
output "epg_dn" {
  value = module.my_epg_app.epg_dn
}
output "epg_dn2" {
  value = module.my_epg_web.epg_dn
}
output "epg_dn3" {
  value = module.my_epg_db.epg_dn
}