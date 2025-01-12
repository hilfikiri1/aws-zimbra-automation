
    variable "host_os" {
        type = string
        default = "linux"
    }

    variable "instance_count" {
        default = "3"
    }

    variable "instance_names" {
        type    = list(string)
        default = ["mta.domain.pl", "proxy.podolskyi.pl", "mbx.podolskyi.pl"]
    }

    variable "key_name" {
        default = "mainkey"
    }

    variable "domain_name" {
    description = "Nazwa domeny dla wpisu w Route53"
    type        = string
    default     = "domain.pl"
    }
    





    
