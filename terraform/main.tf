hcl
resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = var.instance_type
  key_name      = "your-key"
  tags = {
    Name = "WebServer"
  }
}
