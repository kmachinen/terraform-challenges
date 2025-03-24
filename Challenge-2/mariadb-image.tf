resource "docker_image" "mariadb-image" {
  name = "mariadb:challenge"
  build {
    path       = "${path.module}/lamp_stack/custom_db"
    dockerfile = "Dockerfile"
    tag        = ["mariadb:challenge"]
    label = {
      "challenge" = "second"
    }
  }
}
