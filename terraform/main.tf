terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = ">= 3.0.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_image" "moncv_image" {
  name         = "manardarghouthi/moncv:latest"
  keep_locally = false
}

resource "docker_container" "moncv" {
  name  = "moncv"
  image = docker_image.moncv_image.name  # <-- ici on remplace "latest" par "name"
  ports {
    internal = 80
    external = 8586
  }
  restart = "always"
}

