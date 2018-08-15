###############################################################
# VARIABLES - accepted via command line args
###############################################################

variable "aws_profile" {
	default = "personal"
}
variable "private_key_path" {}
variable "key_name" {
	default = "id_rsa"
}

###############################################################
# RESOURCES
###############################################################

provider "aws" {
	region = "us-east-2"
	profile = "${var.aws_profile}"
}

resource "aws_instance" "nginx" {
	ami = "ami-40142d25" # image
	instance_type = "t2.micro"
	key_name = "${var.key_name}"
	availability_zone = "us-east-2a"

	connection {
		private_key = "${file(var.private_key_path)}"
		user = "ec2-user"
	}

	provisioner "remote-exec" {
		inline = [
		  "sudo yum install nginx -y",
		  "sudo service nginx start"
		]
	}
}

###############################################################
# OUTPUT
###############################################################

output "aws_instance_public_dns" {
	value = "${aws_instance.nginx.public_dns}"
}
