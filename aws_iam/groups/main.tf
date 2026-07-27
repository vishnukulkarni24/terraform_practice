resource "aws_iam_group" "developers" {
  name = "developers"
  path = "/users/"
}

resource "aws_iam_group_policy_attachment" "test-attach" {
  group      = aws_iam_group.developers.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

resource "aws_iam_group_membership" "team" {
  name = "tf-testing-group-membership"

  users = [
   "terraform_user_exlearn"
  ]

  group = aws_iam_group.developers.name
}