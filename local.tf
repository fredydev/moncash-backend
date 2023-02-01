locals {
  project = "moncash-payment"
  name    = local.project
  # bucket_name = "fileuploader-react-bucket"
  tags = {
    Name    = local.name
    Owner   = "var.email"
    Entity  = "Myself"
    Product = local.project
  }
}

