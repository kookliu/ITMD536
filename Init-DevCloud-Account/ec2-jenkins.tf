module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = local.name
  description = "Security group for example usage with EC2 instance"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "all-icmp", "ssh-tcp","http-8080-tcp"]
  egress_rules        = ["all-all"]

  tags = local.tags
}


resource "aws_key_pair" "sin_key" {
  key_name   = "sin-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCsdf2rKa0HeX+h6NWJ/At4a+QLKpo6QJGok1EKjgtVhDdgpWBio+MZVqyacAZf//8V2ShRVnPZGjwo09R1SLNiGDP0ddl37Xk6epIzRhcwEqPZ8VRZd4AFK0b/3p9ttCFnpe6O4nxq0u5PZI1I1oKg1E0K7DvjQ5S9aUQAoOZIdcoPfKt9lCSNm0iWjWpif98RhGSA1L15PooHzSR4Pff8EkWi4zWTNmQkxhDKuRH9vNmiOiOUbHU+FCr3O/c4OeprUpSKIRJkEoinghhFMm0F+7zVgzPGwmCzVuI6dR328nl6LTNEa6JCB0VQpbIa5vasznXJyFj0T3Z1yURBogj9QIM5iXYaaHDsrAppKbjSoo1liTo5bbdSXCVKwnjgazhOkQzP6r+UeC+XoRLZN3rlL99pfigWUHdWWtxHznI+Vg/s/UECRJwNS4XSK16qmstXGLLWpoQATpCAMJ0Az2xGNr5tpzwGl+syFny3mMWIoaBk3qvN5H2UGLtFiIUkl3s= jason@Jias-MacBook-Pro.local"
}

module "ec2" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-ec2-instance.git?ref=v4.2.0"

  name = local.name

  ami                         = data.aws_ami.amazon_linux.id
  key_name                    = aws_key_pair.sin_key.key_name
  user_data_base64            = base64encode(file("./files/user_data.sh"))
  instance_type               = "t3.small"
  availability_zone           = local.availability_zone
  subnet_id                   = element(module.vpc.public_subnets, 0)
  vpc_security_group_ids      = [module.security_group.security_group_id]
  associate_public_ip_address = true

  tags = local.tags
}

resource "aws_volume_attachment" "this" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.this.id
  instance_id = module.ec2.id
}

resource "aws_ebs_volume" "this" {
  availability_zone = local.availability_zone
  size              = 1

  tags = local.tags
}