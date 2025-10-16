resource "github_issue_label" "test_label" {
  repository  = var.repository
  name        = "tf-test"
  color       = "0e8a16"
  description = "created by terraform for testing"
}

resource "github_issue_label" "test_label_2" {
  repository  = var.repository
  name        = "tf-test-2"
  color       = "ff6b6b"
  description = "second test label created by terraform"
}


