terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
    token     = "y0_AgAAAABo35ylAATuwQAAAAEQsN8NAABcigeFbSZKnYJAxKcaa8ecoLeicQ"
    cloud_id  = "b1g47p1ljv9b9kh90sob"
    folder_id = "b1gfqmh6715rdfi6qlkj"
    zone = "ru-central1-a"
}
