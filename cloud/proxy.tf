variable "proxy_hosted_zones" {
  description = "An online placeholer"
  type        = map(string)
}

variable "image" {
  description = "Flaked snapshots"
  type        = string
}

variable "vhs" {
  description = "Storage of the image"
  type        = string
  default     = "router.vhs"
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/datasources/s3_bucket
resource "aws_s3_bucket" "server" {
  bucket = var.vhs
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls
resource "aws_s3_bucket_ownership_controls" "vhs" {
  bucket = aws_s3_bucket.server.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block
resource "aws_s3_bucket_public_access_block" "lock" {
  bucket = aws_s3_bucket.server.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/datasources/s3_object
resource "aws_s3_object" "upload" {
  bucket = aws_s3_bucket.server.id
  key    = "web.vhd"
  source = var.image
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/ebs_snapshot_import
resource "aws_ebs_snapshot_import" "route" {
  role_name = aws_iam_role.vm.id

  disk_container {
    format = "VHD"

    user_bucket {
      s3_bucket = aws_s3_bucket.server.id
      s3_key    = aws_s3_object.upload.id
    }
  }

  lifecycle {
    replace_triggered_by = [
      aws_s3_object.upload
    ]
  }
}

# https://search.opentofu.org/provider/hashicorp/random/latest/docs/resources/pet
resource "random_pet" "web" {
  length = 2
  keepers = {
    snapshot_id = aws_ebs_snapshot_import.route.id
  }
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/ami
resource "aws_ami" "web" {
  name                = "webami-${random_pet.web.id}"
  virtualization_type = "hvm"
  ena_support         = true
  root_device_name    = "/dev/xvda"

  ebs_block_device {
    device_name = "/dev/xvda"
    snapshot_id = aws_ebs_snapshot_import.route.id
  }
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/instance
resource "aws_instance" "redirect" {
  ami                    = aws_ami.web.id
  instance_type          = "t3.nano"
  iam_instance_profile   = aws_iam_instance_profile.ec2.name
  vpc_security_group_ids = [aws_security_group.network.id]

  lifecycle {
    create_before_destroy = true
  }
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment
resource "aws_iam_role_policy_attachment" "vm" {
  role       = aws_iam_role.vm.id
  policy_arn = aws_iam_policy.vm.arn
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/iam_role
resource "aws_iam_role" "vm" {
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "vmie.amazonaws.com" }
        Action    = "sts:AssumeRole"
        Condition = {
          StringEquals = {
            "sts:Externalid" = "vmimport"
          }
        }
      }
    ]
  })
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/iam_role_policy
resource "aws_iam_policy" "vm" {
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetBucketLocation",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:PutObject",
          "s3:GetBucketAcl"
        ]
        Resource = [
          "arn:aws:s3:::${aws_s3_bucket.server.id}",
          "arn:aws:s3:::${aws_s3_bucket.server.id}/*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "ec2:ModifySnapshotAttribute",
          "ec2:CopySnapshot",
          "ec2:RegisterImage",
          "ec2:Describe*"
        ],
        Resource = "*"
      }
    ]
  })
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment
resource "aws_iam_role_policy_attachment" "ec2" {
  role       = aws_iam_role.ec2.id
  policy_arn = aws_iam_policy.ec2.arn
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/iam_role
resource "aws_iam_role" "ec2" {
  name = "nixos-ec2"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/iam_policy
resource "aws_iam_policy" "ec2" {
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["kms:Decrypt", "kms:DescribeKey"]
      Resource = aws_kms_key.sops.arn
    }]
  })
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/iam_instance_profile
resource "aws_iam_instance_profile" "ec2" {
  name = "nixos-ec2"
  role = aws_iam_role.ec2.name
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/kms_key
resource "aws_kms_key" "sops" {
  description             = "Secret to the vault"
  deletion_window_in_days = 7
  enable_key_rotation     = true
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/kms_alias
resource "aws_kms_alias" "sops" {
  name          = "alias/dotfiles"
  target_key_id = aws_kms_key.sops.key_id
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/security_group
resource "aws_security_group" "network" {
  name = "tom.lock"
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule
resource "aws_vpc_security_group_egress_rule" "outbound" {
  security_group_id = aws_security_group.network.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule
resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.network.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule
resource "aws_vpc_security_group_ingress_rule" "https" {
  security_group_id = aws_security_group.network.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule
resource "aws_vpc_security_group_ingress_rule" "ntp" {
  security_group_id = aws_security_group.network.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "udp"
  from_port   = 123
  to_port     = 123
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule
resource "aws_vpc_security_group_ingress_rule" "wireguard" {
  security_group_id = aws_security_group.network.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "udp"
  from_port   = 51820
  to_port     = 51820
}

# https://search.opentofu.org/provider/opentofu/aws/latest/docs/resources/route53_record
resource "aws_route53_record" "root" {
  name    = "o526.net"
  type    = "A"
  zone_id = var.proxy_hosted_zones["o526.net"]
  ttl     = 300
  records = [aws_instance.redirect.public_ip]
}

# https://search.opentofu.org/provider/opentofu/aws/latest/docs/resources/route53_record
resource "aws_route53_record" "dev" {
  name    = "dev.o526.net"
  type    = "A"
  zone_id = var.proxy_hosted_zones["o526.net"]
  ttl     = 300
  records = [aws_instance.redirect.public_ip]
}

# https://search.opentofu.org/provider/opentofu/aws/latest/docs/resources/route53_record
resource "aws_route53_record" "tom" {
  name    = "tom.o526.net"
  type    = "A"
  zone_id = var.proxy_hosted_zones["o526.net"]
  ttl     = 300
  records = [aws_instance.redirect.public_ip]
}

# https://search.opentofu.org/provider/opentofu/aws/latest/docs/resources/route53_record
resource "aws_route53_record" "quintus" {
  name    = "quintus.sh"
  type    = "A"
  zone_id = var.proxy_hosted_zones["quintus.sh"]
  ttl     = 300
  records = [aws_instance.redirect.public_ip]
}

output "public_dns" {
  value = aws_instance.redirect.public_dns
}

output "public_ip" {
  value = aws_instance.redirect.public_ip
}
