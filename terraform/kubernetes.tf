locals {
  covr_port = 9001
}

resource "kubernetes_service" "covr" {
  metadata {
    name = "covr-service"
    annotations {
      "service.beta.kubernetes.io/aws-load-balancer-type" = "nlb"
    }
  }
  spec {
    external_traffic_policy = "Local"
    selector = {
      app = "covr"
    }
    port {
      name        = "grpc"
      port        = "${local.covr_port}"
      target_port = "backend-tcp"
      protocol    = "TCP"
    }
    type = "LoadBalancer"
  }
}

resource "kubernetes_deployment" "covr" {
  metadata {
    name = "covr-deployment"
    labels = {
      app = "covr"
    }
  }

  spec {
    replicas = 3
    selector {
      match_labels = {
        app = "covr"
      }
    }

    template {
      metadata {
        labels = {
          app = "covr"
        }
      }

      spec {
        container {
          image = "covrco/sre-grpc-exercise"
          name  = "covr"
          port = {
            container_port = "${local.covr_port}"
            name = "backend-tcp"
          }
        }
      }
    }
  }
}
