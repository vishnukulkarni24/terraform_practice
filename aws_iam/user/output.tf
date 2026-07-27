output "access_key_id" {
  value = aws_iam_access_key.tf_user_acces_key.id
}


# tf output secreat_key        # use this command for the view secreat acces key
# tf output secreat_key > secrt.txt   # to store screat acces key in the  secrt.txt file 
 # tf output secreat_key | tee sec.txt 
output "secreat_key" {
  value = aws_iam_access_key.tf_user_acces_key.secret
  sensitive = true
}