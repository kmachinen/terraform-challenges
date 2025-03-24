resource "docker_container" "php-httpd" {
  name     = "webserver"
  hostname = "php-httpd"
  image    = "php-httpd:challenge"

  networks_advanced {
    name = docker_network.private_network.name
  }

  ports {
    ip       = "0.0.0.0"
    internal = 80
    external = 80
  }

  labels {
    label = "challenge"
    value = "second"
  }

  volumes {
    host_path      = abspath("${path.module}/lamp_stack/website_content/")
    container_path = "/var/www/html"
  }

  depends_on = [
    docker_network.private_network,
    docker_image.php-httpd-image
  ]
}
