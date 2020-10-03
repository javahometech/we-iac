{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "Stmt1601175220752",
        "Action": [
          "s3:GetObject",
          "s3:PutObject"
        ],
        "Effect": "Allow",
        "Resource": "${bucket_name}"
      }
    ]
  }