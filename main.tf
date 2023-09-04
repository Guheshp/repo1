provider "aws" {
  region = "ap-south-1"

}

resource "aws_instance" "namaste" {
  ami           = "ami-06f621d90fa29f6d0"
  instance_type = "t2.micro"
}



output "instance_id" {
  value = aws_instance.namaste.id


}
