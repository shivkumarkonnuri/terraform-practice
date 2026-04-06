provider "aws" {

region = "ap-south-1"

}


resource "aws_s3_bucket" "my-first-terrabucket"{
   bucket = "my-first-tf-bucket-050420261826"
   
   tags = {
	Name = "My-TF-Bucket"
        Environment = "Dev"
   }
}
