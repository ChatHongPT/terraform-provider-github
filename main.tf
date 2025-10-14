resource "github_issue_label" "test_label" {
  repository  = var.repository
  name        = "tf-test"
  color       = "0e8a16"
  description = "created by terraform for testing"
}


