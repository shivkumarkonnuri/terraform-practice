# Simple file Automation with code

resource "local_file" "my_file" {
  filename        = "demo-automated-file.txt"
  content         = "hello dosto"
  file_permission = "0600"
}
