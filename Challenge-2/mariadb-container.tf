resource "docker_container" "mariadb" {
  name     = "db"
  image    = "mariadb:challenge"
  hostname = "db"

  networks_advanced {
    name = docker_network.private_network.name
  }

  ports {
    ip       = "0.0.0.0"
    internal = 3306
    external = 3306
  }

  labels {
    label = "challenge"
    value = "second"
  }

  env = [
    "MYSQL_ROOT_PASSWORD=1234",
    "MYSQL_DATABASE=simple-website"
  ]

  volumes {
    volume_name    = docker_volume.mariadb_volume.name
    container_path = "/var/lib/mysql"
  }

  depends_on = [
    docker_network.private_network,
    docker_volume.mariadb_volume,
    docker_image.mariadb-image
  ]
}
