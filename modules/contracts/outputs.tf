output "contract_dn" {
    value = values(aci_contract.terraform_contract).*.id
    }