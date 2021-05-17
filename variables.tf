variable "do_token" {
  type        = string
  description = "DigitalOcean Personal Access Token"
}

variable "ssh_key_fingerprints" {
  type        = list(string)
  description = "List of SSH Key fingerprints"
}

variable "region" {
  type        = string
  description = "Region in which to deploy the cluster. Default is fra1 (Frankfurt, Germany)"
  default     = "fra1"
  validation {
    condition     = length(regexall("^nyc1|sfo1|nyc2|ams2|sgp1|lon1|nyc3|ams3|fra1|tor1|sfo2|blr1|sfo3$", var.region)) > 0
    error_message = "Invalid region. Valid regions are nyc1, sfo1, nyc2, ams2, sgp1, lon1, nyc3, ams3, fra1, tor1, sfo2, blr1 or sfo3."
  }
}

variable "vpc_network_range" {
  type        = string
  description = "Range of IP addresses for the VPC in CIDR notation. Cannot be larger than /16 or smaller than /24. Default is 10.10.10.0/24"
  default     = "10.10.10.0/24"
}

variable "k3s_channel" {
  type        = string
  description = "K3s release channel. 'stable', 'latest', 'testing' or a specific channel or version e.g. 'v1.20', 'v1.21.0+k3s1'"
  default     = "stable"
}

variable "database_user" {
  type        = string
  description = "Database Username"
  default     = "k3s_default_user"
}

variable "database_engine" {
  type        = string
  description = "Database engine. PostgreSQL (13) or MySQL (8)"
  default     = "postgres"
  validation {
    condition     = length(regexall("^postgres|mysql$", var.database_engine)) > 0
    error_message = "Invalid database engine. Valid types are postgres or mysql."
  }
}

variable "database_size" {
  type        = string
  description = "Database Droplet size associated with the cluster (ex. db-s-1vcpu-1gb)"
  default     = "db-s-1vcpu-1gb"
}

variable "database_node_count" {
  type        = number
  description = "Number of nodes that comprise the database cluster"
  default     = 1
}

variable "flannel_backend" {
  type        = string
  description = "Flannel Backend Type. Valid options include vxlan, host-gw, ipsec (default) or wireguard"
  default     = "ipsec"
  validation {
    condition     = length(regexall("^ipsec|vxlan|host-gw|wireguard$", var.flannel_backend)) > 0
    error_message = "Invalid Flannel backend value. Valid backend types are vxlan, host-gw, ipsec & wireguard."
  }
}

variable "server_size" {
  type        = string
  description = "Server droplet size. e.g. s-1vcpu-2gb"
  default     = "s-1vcpu-2gb" # prod = s-1vcpu-2gb
}
variable "agent_size" {
  type        = string
  description = "Agent droplet size. e.g. s-1vcpu-2gb"
  default     = "s-1vcpu-2gb" # prod = s-2vcpu-4gb
}

variable "server_count" {
  type        = number
  description = "Number of server (master) nodes to provision"
  default     = 2
}
variable "agent_count" {
  type        = number
  description = "Number of agent (worker) nodes to provision"
  default     = 1
}

variable "server_taint_criticalonly" {
  type        = bool
  description = "Allow only critical addons to be scheduled on servers? (thus preventing workloads from being launched on them)"
  default     = true
}

variable "k8s_dashboard" {
  type        = bool
  description = "Pre-install the Kubernetes Dashboard? (Default is false)"
  default     = false
}

variable "cert_manager" {
  type        = bool
  description = "Pre-install cert-manager? (Default is false)"
  default     = false
}