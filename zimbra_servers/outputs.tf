output "zimbra_name_ip" {
    # type    = list(string)
    value = [ aws_instance.zimbra_server[*].tags["Name"], aws_instance.zimbra_server[*].public_ip ]
}

output "zimbra_private_ip" {
  value = { for server in aws_instance.zimbra_server : server.tags.Name => server.private_ip }
}
