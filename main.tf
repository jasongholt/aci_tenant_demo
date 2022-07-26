
#Define the path for the provider that is being used.  In this case
#we are using the Cisco Dev Net ACI provider. 

terraform {
  required_providers {
    aci = {
      source  = "CiscoDevNet/aci"
      version = "2.2.0"
    }
  }
}

#Create the credentials, in production this should not be hard coded into
#the file, but variablized or using TFC for credentials protection. Test

provider "aci" {
  username = var.apic_user 
  password = var.apic_password
  url      = var.apic_url
  insecure = true
}

#The following module creates the tenant that will hold your application and   
#netrowking elements.  In the tenant line, you can replace with your required naming

module "my_tenant" {
  source = "github.com/jasongholt/aci_tenant_demo/modules/tenant"
  tenant = "banking_app"
}

#The following module creates the VRF inside of the tenant.  You can customize the
#naming in the vrf = line.

module "my_vrf" {
  source    = "github.com/jasongholt/aci_tenant_demo/modules/vrf"
  vrf       = "vrf_prod_1"
  tenant_id = module.my_tenant.tenant_id
}

#The following module creates the App Profile that will define your customized settings
#for your application

module "my_app_profile" {
  source    = "github.com/jasongholt/aci_tenant_demo/modules/app_profile"
  tenant_id = module.my_tenant.tenant_id
}

#The Following module creates the Bridge domain that will allow rouing between subnets and 
#will allow traffic to flow inside your application. You can customize the bridge domain name
#via bd, and the ip of the bridge domain via ip.

module "my_bridgedomain_app" {
  source    = "github.com/jasongholt/aci_tenant_demo/modules/bridge_domain"
  bd        = "pod01_app"
  ip        = "5.1.1.1/24"
  tenant_id = module.my_tenant.tenant_id
  vrf_id    = module.my_vrf.vrf_id
}

#The following modules create the EPG's.  In this example we are using a seperate module 
#for each epg that we create. You can add more EPG's by adding or removing epg module 
#blocks.  Here we demonstrate a three tier app. 

module "my_epg_web" {
  source   = "github.com/jasongholt/aci_tenant_demo/modules/endpoint_group"
  epg_name = "epg_web"
  bd_id    = module.my_bridgedomain_app.bd_id
  app_id   = module.my_app_profile.app_id
}

module "my_epg_app" {
  source   = "github.com/jasongholt/aci_tenant_demo/modules/endpoint_group"
  epg_name = "epg_app"
  bd_id    = module.my_bridgedomain_app.bd_id
  app_id   = module.my_app_profile.app_id
}

module "my_epg_db" {
  source   = "github.com/jasongholt/aci_tenant_demo/modules/endpoint_group"
  epg_name = "epg_db"
  bd_id    = module.my_bridgedomain_app.bd_id
  app_id   = module.my_app_profile.app_id
}

#The following module block creates the firewall filter rules that will be applied with the
#contracts.  We are using a list of rules, you can expand or subtract rules to meet your needs. 

module "my_filters" {
  source    = "github.com/jasongholt/aci_tenant_demo/modules/filters"
  tenant_id = module.my_tenant.tenant_id
  filters_entry = {
    filter_https = {
      filter   = "https",
      entry    = "https",
      protocol = "tcp",
      port     = "443"
    },
    filter_sql = {
      filter   = "sql",
      entry    = "sql",
      protocol = "tcp",
      port     = "3306",
    },
    filter_app = {
      filter   = "app",
      entry    = "app",
      protocol = "tcp",
      port     = "8080",
    }
  }
}

#The following module block creates the contracts that are going to allow traffic flows between 
#the EPG's in your tenant.  Here we have created a three tier app and are joining the filters with 
#the contracts.  This is a list as well, and can be edited to meet your needs.

module "my_contracts" {
  source                       = "github.com/jasongholt/aci_tenant_demo/modules/contracts"
  tenant_id                    = module.my_tenant.tenant_id
  relation_vz_rs_subj_filt_att = module.my_filters.filter_dn
  contract = {
    contract_web = {
      contract = "web",
      subject  = "https",
      filter   = "filter_https"
    },
    contract_db = {
      contract = "sql",
      subject  = "sql",
      filter   = "filter_sql"
    },
    contract_app = {
      contract = "app",
      subject  = "app",
      filter   = "filter_app"
    }
  }

#The second part of this module block defines the behavior of the EPG's.  This is also a list and 
#can be edited based on your needs.  

#epg_to_contract = {
#    terraform_one = {
#          epg           = module.my_epg_web.epg_dn,
#          contract      = "contract_app",
#          contract_type = "consumer" 
#        },
#    terraform_two = {
#          epg           = module.my_epg_db.epg_dn,
#          contract      = "contract_db",
#          contract_type = "provider" 
#    },
#    terraform_three = {
#          epg           = module.my_epg_web.epg_dn,
#          contract      = "contract_web",
#          contract_type = "provider" 
#    },
#   terraform_four = {
#          epg           = module.my_epg_app.epg_dn,
#          contract      = "contract_app",
#          contract_type = "provider" 
#    },
#    terraform_five = {
#          epg           = module.my_epg_app.epg_dn,
#         contract      = "contract_db",
#          contract_type = "consumer" 
#    }
#}
}

