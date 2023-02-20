provider "aws" {
  profile = "default"
  region = "us-east-1"
}


###################################################################
# IAM user without pgp_key (IAM access secret will be unencrypted)
###################################################################
module "iam_user" {
  source = "../../modules/iam-user"

  count        = length(var.tko_users)
  name = var.tko_users[count.index].name

  create_iam_user_login_profile = false
  create_iam_access_key         = true
}

resource "aws_iam_user_group_membership" "example1" {
  count        = length(var.tko_users)
  user = var.tko_users[count.index].name

  groups = [
    "Splunk-CSE-Admin",
  ]
}
