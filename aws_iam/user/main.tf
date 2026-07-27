resource "aws_iam_user" "terraform_user" {
  name = "terraform_user_exlearn"
  
}

resource "aws_iam_user_policy_attachment" "terraform_user_policy_attachment" {
    user = aws_iam_user.terraform_user.name
    policy_arn =  "arn:aws:iam::aws:policy/AdministratorAccess"
}
resource "aws_iam_user_policy_attachment" "terraform_user_policy__ec2_read_attachment" {
    user = aws_iam_user.terraform_user.name
    policy_arn =  "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}


resource "aws_iam_access_key" "tf_user_acces_key" {
  user    = aws_iam_user.terraform_user.name
 
}