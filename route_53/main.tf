
resource "aws_route53_zone" "zimbra_route53_zone" {
  name = var.domain_name
}

data "terraform_remote_state" "instances" {
  backend = "local"
  config = {
    path = "../zimbra_servers/terraform.tfstate"  # Adjust the path to your instances state file
  }
}

resource "aws_route53_record" "A_record" {
  for_each = data.terraform_remote_state.instances.outputs.zimbra_private_ip

  zone_id = aws_route53_zone.zimbra_route53_zone.zone_id
  name    = each.key
  type    = "A"
  ttl     = 300
  records = [each.value]
}

resource "aws_route53_record" "mx_record" {
  zone_id = aws_route53_zone.zimbra_route53_zone.zone_id
  name    = var.domain_name
  type    = "MX"
  ttl     = 300
  records = [
    for k, v in data.terraform_remote_state.instances.outputs.zimbra_private_ip : format("%d %s.%s", 10 * (index(keys(data.terraform_remote_state.instances.outputs.zimbra_private_ip), k) + 1), k, var.domain_name)
  ]
}