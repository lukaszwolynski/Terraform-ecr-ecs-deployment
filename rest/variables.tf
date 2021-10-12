variable "appPort" {
  type    = number
  default = 5000
}

variable "imageRepository" {
  type    = string
  default = "347012026804.dkr.ecr.eu-central-1.amazonaws.com/lwolynski-repository:latest"
}

variable "prefix" {
  type    = string
  default = "lwolynski"
}

variable "vpc_id" {
  type    = string
  default = "vpc-fe442194"
}

variable "subnets_id" {
  type    = list(any)
  default = ["subnet-02941a4e", "subnet-f9dd9093", "subnet-e9eb5095"]

}
