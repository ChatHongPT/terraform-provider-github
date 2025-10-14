variable "github_token" {
  type      = string
  sensitive = true
}

variable "repository" {
  type        = string
  description = "대상 리포지토리 이름"
  default     = "terraform-provider-github"
}


