resource "ibm_container_cluster" "cluster" {
  count                = var.enable && ! var.on_vpc ? 1 : 0
  name                 = "${var.project_name}-${var.environment}-cluster"
  datacenter           = var.datacenter
  default_pool_size    = var.workers_count[0]
  machine_type         = var.flavors[0]
  hardware             = "shared"
  kube_version         = local.roks_version
  resource_group_id    = data.ibm_resource_group.group.id
  public_vlan_id       = ""
  private_vlan_id      = ""
  force_delete_storage = var.force_delete_storage
  // gateway_enabled          = true
  // public_service_endpoint  = true
  // private_service_endpoint = true

  entitlement = "cloud_pak"

  tags = [
    "project:${var.project_name}",
    "env:${var.environment}",
    "owner:${var.owner}"
  ]
}
