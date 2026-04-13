output "vpc_id" {
  value = aws_vpc.this.id
}

output "private_subnet_ids" {
  value = [for s in aws_subnet.private : s.id]
}

output "public_subnet_ids" {
  value = [for s in aws_subnet.public : s.id]
}

output "network_contract" {
  value = {
    vpc_id          = aws_vpc.this.id
    private_subnets = [for s in aws_subnet.private : s.id]
    public_subnets  = [for s in aws_subnet.public : s.id]
  }
}