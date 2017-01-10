#
# New groups should be added here.
#   In alphabetical order.
#

resource "aws_iam_group" "custom_formats" {
    name = "custom_formats"
    path = "/groups/"
}

resource "aws_iam_group" "publishing_platform" {
    name = "publishing_platform"
    path = "/groups/"
}

resource "aws_iam_group" "infrastructure_team" {
    name = "infrastructure_team"
    path = "/groups/"
}

resource "aws_iam_policy_attachment" "base-user-console-access_user_attachment" {
    name = "base-user-console-access_user_attachment_policy"
    groups = [
      "${aws_iam_group.custom_formats.name}",
      "${aws_iam_group.publishing_platform.name}"
    ]
    policy_arn = "${aws_iam_policy.base-user-console-access.arn}"
}

resource "aws_iam_policy" "infrastructure_team_policy" {
    name = "infrastructure_team_policy"
    description = "Admin policy: full access"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "*",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "infrastructure_team_attachment" {
    name = "infrastructure_team_policy_attachment"
    groups = ["${aws_iam_group.infrastructure_team.name}"]
    policy_arn = "${aws_iam_policy.infrastructure_team_policy.arn}"
}


# get the current aws account_id
data "aws_caller_identity" "current" { }


data "template_file" "base-user-console-access" {
  # FIXME: use less fixed paths
  template = "${file("projects/user_management/resources/templates/base-user-console-access.tpl")}"

  vars {
    account_id  = "${data.aws_caller_identity.current.account_id}"
    environment = "${var.environment}"
  }
}

resource "aws_iam_policy" "base-user-console-access" {
    name = "base-user-console-access_user_policy"
    description = "base-user-console-access allows standard user tasks like create access key"
    policy = "${data.template_file.base-user-console-access.rendered}"
}
