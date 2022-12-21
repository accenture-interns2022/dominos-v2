variable "card" {
  type = map(any)
  default = {
    number = "123456789101112"
    cvv    = "1314"
    date   = "15/16",
    zip    = "18192"
  }
}

variable "address" {
  type = map(any)
  default = {
    street = "6199 NE Alber st"
    city   = "Hillsboro"
    state  = "OR"
    zip    = "97124"
  }
}

variable "client" {
  type = map(string)
  default = {
    first_name    = "My"
    last_name     = "Name"
    email_address = "my@name.com"
    phone_number  = "15555555555"
  }
}
