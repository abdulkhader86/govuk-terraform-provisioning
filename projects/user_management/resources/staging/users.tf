#
# New users should be added here.
#   In alphabetical order.
#

resource "aws_iam_user" "anafernandez" {
    name = "anafernandez"
    path = "/users/"
}

resource "aws_iam_user" "samcook" {
    name = "samcook"
    path = "/users/"
}
