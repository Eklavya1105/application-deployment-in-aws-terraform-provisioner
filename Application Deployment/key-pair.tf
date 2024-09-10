resource "aws_key_pair" "example" {
  key_name   = var.key_name 
  public_key = file("/c/Users/Eklavya/.ssh/id_rsa.pub")  
}
