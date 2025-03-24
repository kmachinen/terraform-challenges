resource "kubernetes_namespace" "webapp" {
  metadata {
    name = "webapp"
  }
}

resource "kubernetes_deployment" "frontend" {
  metadata {
    name      = "frontend"
    namespace = kubernetes_namespace.webapp.metadata.0.name
    labels = {
      name = "frontend"
    }
  }
  spec {
    replicas = 4
    selector {
      match_labels = {
        name = "webapp"
      }
    }
    template {
      metadata {
        labels = {
          name = "webapp"
        }
      }
      spec {
        container {
          image = "kodekloud/webapp-color:v1"
          name  = "simple-webapp"
          port {
            container_port = 8080
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "webapp-service" {
  metadata {
    name      = "webapp-service"
    namespace = kubernetes_namespace.webapp.metadata.0.name
  }
  spec {
    selector = {
      name = "webapp"
    }
    port {
      port        = 8080
      target_port = 8080
      node_port   = 30080
    }
    type = "NodePort"
  }
}
