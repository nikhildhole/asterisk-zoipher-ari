# Stop any running container
Write-Host "Stopping any running containers..."
$containers = docker ps -q --filter "ancestor=asterisk-setup"
if ($containers) {
    $containers | ForEach-Object { docker stop $_ }
}

# Remove the container(s)
Write-Host "Removing container(s)..."
$containers = docker ps -a -q --filter "ancestor=asterisk-setup"
if ($containers) {
    $containers | ForEach-Object { docker rm $_ }
}

# Remove the Docker image
Write-Host "Removing Docker image..."
docker rmi asterisk-setup

# Optional: Clean up unused images, containers, and volumes
Write-Host "Cleaning up unused Docker resources..."
docker system prune -f

Write-Host "Cleanup completed."
