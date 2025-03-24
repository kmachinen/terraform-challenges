resource "docker_container" "phpmyadmin" {
  name     = "db_dashboard"
  image    = "phpmyadmin/phpmyadmin"
  hostname = "phpmyadmin"

  networks_advanced {
    name = docker_network.private_network.name
  }

  ports {
    ip       = "0.0.0.0"
    internal = 80
    external = 8081
  }

  labels {
    label = "challenge"
    value = "second"
  }

  depends_on = [
    docker_container.mariadb
  ]
}
