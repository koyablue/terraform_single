output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "public_subnet_a_id" {
  value = aws_subnet.public_subnet_a.id
}

output "public_subnet_c_id" {
  value = aws_subnet.public_subnet_c.id
}
