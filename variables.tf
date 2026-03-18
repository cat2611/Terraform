variable "flow" {
  type    = string
  default = "24-01"
}

variable "cloud_id" {
  type    = string
  default = "b1gifv6fgqorh4muqddr"
}
variable "folder_id" {
  type    = string
  default = "b1gsnrbk2s9h2154hjha"
}

variable "test" {
  type = map(number)
  default = {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }
}

