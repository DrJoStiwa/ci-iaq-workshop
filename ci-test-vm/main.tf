# Configure the Hetzner Cloud Provider
provider "hcloud" {
  token = var.hcloud_token
}

# Create a new SSH key
resource "hcloud_ssh_key" "ansible-test-ssh-key" {
  name = "Johann Test VM SSH Key"
  public_key = file(var.ssh_key)
}

# Create a server
resource "hcloud_server" "ansible-test-johann" {
  name = "ansible-test-johann"
  image = "ubuntu-20.04"
  server_type = "cx11"
  location = "nbg1"
  ssh_keys = [
    "Johann Test VM SSH Key"
  ]

  provisioner "local-exec" {
    command = "sleep 20; ssh-keygen -R ${hcloud_server.ansible-test-johann.ipv4_address}; ssh-keyscan -t rsa -H ${hcloud_server.ansible-test-johann.ipv4_address} >> ~/.ssh/known_hosts"
  }
  depends_on = [
    hcloud_ssh_key.ansible-test-ssh-key
  ]
}

output "public_ip_address" {
  value = "${hcloud_server.ansible-test-johann.ipv4_address}"
}
