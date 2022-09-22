variable "resource_names" {
  description = "Map of known resource names"
  type        = map(string)


  default = {
    # VPC Name
    vpc_name = "VPC"

    # Application Subnet
    app_subnet_name = "APST_AZ"

    # Public Subnet
    public_subnet_name = "PBST_AZ"

    # Catalog Subnet
    catalog_subnet_name = "CGST_AZ"

    # Database Subnet
    db_subnet_name = "DBST_AZ"

    # User workspace Subnet
    uwsp_subnet_name = "UWST_AZ"

    # Public Route table
    pubic_rt_name = "PUB_RT"

    # Public Route table
    private_rt_name = "PVT_RT"

    # NAT Gateway
    nat_gateway_name = "NAT_AZ"

    # DHCP Options
    dhcp_options_name = "DHCP_OPT"

    # Internet Gateway
    igw_name = "IGW"

    # NAT EIP
    nat_eip_name = "NAT_EIP"

    # DB Subnet Group
    dbsubnet_group_name = "DBST-GRP"

  }
}
