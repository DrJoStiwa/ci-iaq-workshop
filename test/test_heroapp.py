def test_docker_is_installed(host):
    # testen, ob das Paket "docker-ce" installiert ist
    dockerce = host.package("docker-ce")
    assert dockerce.is_installed

def test_docker_service_is_running(host):
    # testen, ob der Service "docker" läuft und verfügbar ist
    docker = host.service("docker")
    assert docker.is_running
    assert docker.is_enabled

def test_heroapp_container_is_running(host):
    # testen, ob der container mit dem Namen "my-hero-app" läuft
    myheroapp = host.docker("my-hero-app")
    assert myheroapp.is_running

def test_heroapp_is_available_on_port_80(host):
    # testen, ob auf tcp://0.0.0.0:80 gehorcht wird
    myheroapp = host.socket("tcp://0.0.0.0:80")
    assert myheroapp.is_listening
