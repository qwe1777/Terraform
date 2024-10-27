terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
    token     = "secure_token"
    cloud_id  = "secure_id"
    folder_id = "secure_id"
    zone = "ru-central1-a"
}
