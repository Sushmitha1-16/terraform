resource "local_file" "pet" {
filename = "pets.txt"
content = "we love pets!"
}
resource "random_pet" "mypet" {
prefix = "MISS"
separator = "."
length = "1"
}