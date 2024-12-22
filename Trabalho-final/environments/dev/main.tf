module "webserver" {
  source = "../../modules/webserver"
  
  instance_count = 2
}