variable "bucket_name" {
  type    = string
  default = "ml-pipeline-bucket"
}

variable "region" {
  type    = string
  default = "us-central1"
}

output "status" {
  value = "storage module placeholder"
}
