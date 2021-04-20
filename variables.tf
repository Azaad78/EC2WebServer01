variable "region" {
  type        = string
  description = "aws region used for this project. eg:ap-southeast-1"
  default     = "ap-southeast-1"
}
variable "bucketname" {
    type        = string
    description = "Bucket's name must be all lower case"
    default     = "mysolotestbucket"
}
variable "projectname" {
    type        = string
    description = "A web-site to display Tomyum Adventure picture"
    default     = "tomyumadv"
}