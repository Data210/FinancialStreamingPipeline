resource "google_compute_disk" "cassandra-disk" {
  name = "cassandra-${var.project_id}"
  type = "pd-standard"
  zone = var.zone
  size = 1
  labels = {
    environment = "dev"
  }
  project = var.project_id
}


resource "kubernetes_persistent_volume" "cassandra-db-volume" {
  metadata {
    name = "cassandra-${var.project_id}"
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    capacity = {
      storage = var.cassandra_disk_size
    }
    persistent_volume_source {
      gce_persistent_disk {
        pd_name = google_compute_disk.cassandra-disk.name
        fs_type = "ext4"
      }
    }
    storage_class_name = "standard"
  }
}

resource "kubernetes_persistent_volume_claim" "cassandra-db-volume-claim" {
  metadata {
    name = "cassandra-${var.project_id}"
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = var.cassandra_disk_size
      }
    }
    volume_name = kubernetes_persistent_volume.cassandra-db-volume.metadata.0.name
    storage_class_name = "standard"
  }
}

resource "google_compute_disk" "kafka-disk" {
  name = "kafka-${var.project_id}"
  type = "pd-standard"
  zone = var.zone
  size = 1
  labels = {
    environment = "dev"
  }
  project = var.project_id
}


resource "kubernetes_persistent_volume" "kafka-db-volume" {
  metadata {
    name = "kafka-${var.project_id}"
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    capacity = {
      storage = var.kafka_disk_size
    }
    persistent_volume_source {
      gce_persistent_disk {
        pd_name = google_compute_disk.kafka-disk.name
        fs_type = "ext4"
      }
    }
    storage_class_name = "standard"
  }
}

resource "kubernetes_persistent_volume_claim" "kafka-db-volume-claim" {
  metadata {
    name = "kafka-${var.project_id}"
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = var.kafka_disk_size
      }
    }
    volume_name = kubernetes_persistent_volume.kafka-db-volume.metadata.0.name
    storage_class_name = "standard"
  }
}