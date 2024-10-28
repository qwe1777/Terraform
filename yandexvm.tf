data "yandex_compute_image" "ubuntu_image" {
  family = "ubuntu-2004-lts"
}

resource "yandex_compute_instance" "vm-test1" {
  name = "test1"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_image.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_terraform.id
    nat       = true
  }

  metadata = {
    user-data = "${file("./meta.yml")}"
  }

 connection {
    type        = "ssh"
    user        = "qwe"
    private_key = file("./key")
    host        = self.network_interface[0].nat_ip_address
  }

provisioner "file" {
    source      = "Dockerfile"
    destination = "/home/qwe/Dockerfile"
  }


  provisioner "remote-exec" {
  inline = [
"sudo apt update",
"sudo apt install docker.io -y",
"sudo docker build -t boxfuse .",
"sudo docker login --username qwe1277777@gmail.com --password ghjrhecn24777",
"sudo docker tag boxfuse qwe1777/boxfuse",
"sudo docker push qwe1777/boxfuse"
    ]
  }

}


resource "yandex_vpc_network" "network_terraform" {
  name = "net_terraform"
}

resource "yandex_vpc_subnet" "subnet_terraform" {
  name           = "sub_terraform"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network_terraform.id
  v4_cidr_blocks = ["192.168.15.0/24"]
}


data "yandex_compute_image" "ubuntu_image2" {
  family = "ubuntu-2004-lts"
}

resource "yandex_compute_instance" "vm-test2" {
  name = "test2"

  resources {
    cores  = 4
    memory = 8
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_image.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_terraform.id
    nat       = true
  }

  metadata = {
    user-data = "${file("./meta.yml")}"
  }

 connection {
    type        = "ssh"
    user        = "qwe"
    private_key = file("./key")
    host        = self.network_interface[0].nat_ip_address
  }


  provisioner "remote-exec" {
  inline = [
"sudo apt install docker.io -y",
"sudo docker login --username qwe1277777@gmail.com --password ghjrhecn24777",
"sudo docker pull qwe1777/boxfuse",
"sudo docker run -p 8080:8080 qwe1777/boxfuse"
    ]
  }

}


resource "yandex_vpc_network" "network_terraform2" {
  name = "net_terraform2"
}

resource "yandex_vpc_subnet" "subnet_terraform2" {
  name           = "sub_terraform2"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network_terraform.id
  v4_cidr_blocks = ["192.168.17.0/24"]
