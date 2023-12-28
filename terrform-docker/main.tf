terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
}

# Pulls the image
resource "docker_image" "node-js-app" {
  name = "alpine/docker-node-terraform-app"
  keep_locally = false
}


resource "docker_container" "node-js-app" {
  image = docker_image.node-js-app.image_id
  name  = "tutorial"
  ports {
    internal = 8080
    external = 49160
  }
}