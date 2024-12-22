terraform {
  backend "s3" {
    bucket = "meu-bucket-terraform-estado"
    key    = "terraform.tfstate"
    region = "us-east-1"
    
    # Recomendado para ambiente de produção
    encrypt = true
    dynamodb_table = "terraform-lock"
  }
}