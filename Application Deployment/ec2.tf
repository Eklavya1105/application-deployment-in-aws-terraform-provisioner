resource "aws_instance" "server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name      = aws_key_pair.example.key_name
  vpc_security_group_ids = [aws_security_group.webSg.id]
  subnet_id              = aws_subnet.sub1.id

  connection {
    type        = "ssh"
    user        = "ubuntu"  
    private_key = file("/c/Users/Eklavya/.ssh/id_rsa")
    host        = self.public_ip
   }

   
   provisioner "file" {
    source      = "../Flask Application/app.py" 
    destination = "/home/ubuntu/app.py"  
   }

   provisioner "remote-exec" {
    inline = [
      "echo 'Hello from the remote instance'",
      "sudo apt update -y",  
      "sudo apt-get install -y python3-pip",  
      "cd /home/ubuntu",
      "sudo pip3 install flask",
      "sudo python3 app.py",
    ]
   }
}
