variable "REGISTRY" {
  type    = "string"
  default = "docker.io/rafaelbeecker"
}

variable "APP_RELEASE" {
  type    = "string"
  default = "develop"
}

groups "default" {
  targets = ["python"]
}

target "python" {
  name       = "python-${version}"
  context    = "."
  dockerfile = "./Dockerfile"
  tags = ["${REGISTRY}/bigfoot:python-${version}"]
  target     = "dev"
  matrix = {
    version = [APP_RELEASE]
  }
}