##First create the required resources s3 bucket and Dynamodb table with hashkey "LockID" and then initialize the
##remote backend configuration.
# resource "aws_s3_bucket" "example" {
#   bucket = "tfstate-satyam-1326"
# }
# ##hash key i.e. partion key should always be LockID then only dynamodb will identify it as storaghe for state backend.
# resource "aws_dynamodb_table" "terraform_locks" {
#   name         = "remote-backend"
#   billing_mode = "PAY_PER_REQUEST"
#   hash_key     = "LockID"
#   attribute {
#     name = "LockID"
#     type = "S"
#   }
# }
## key is path to store state file insiode bucket
## backend configuration i.e. terraform block does not support variable so we have hard coded region
# terraform {
#   backend "s3" {
#     bucket = "tfstate-satyam-1326"
#     key    = "backend/terraform-2-tier.tfstate" 
#     region = "us-east-1" 
#     dynamodb_table = "remote-backend"
#   }
# }