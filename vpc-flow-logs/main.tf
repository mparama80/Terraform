##############################################################################
## Provisioning S3 bucket
##############################################################################
resource "aws_s3_bucket" "flow_logs" {
   bucket = "flow-logs-bucketvpc07457e1-cn-northwest-1"
}

##############################################################################
## Provisioning VPC Flow log for cn-northwest-1
##############################################################################
resource "aws_flow_log" "cn-northwest-infra-vpc" {
   log_destination      = aws_s3_bucket.flow_logs.arn
   traffic_type         = "ALL"
   vpc_id               = "vpc-0e8908e9ac9b278ea"
   log_destination_type = "s3"
}

resource "aws_s3_bucket_policy" "vpc_flow_logs_policy" {
    bucket = aws_s3_bucket.flow_logs.id

    policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
            {
                Effect = "Allow",
                Principal = {
                    Service = "vpc-flow-logs.amazonaws.com"
                },
                Action = "s3:PutObject",
                Resource = "arn:aws:s3:::flow-logs-bucketvpc07457e1-cn-northwest-1/AWSLogs/*"
            },
            {
                Effect = "Deny",
                Principal = "*",
                Action = [
                    "s3:DeleteObject",
                    "s3:DeleteObjectVersion"
                ],
                Resource = "arn:aws:s3:::flow-logs-bucketvpc07457e1-cn-northwest-1/AWSLogs/*"
            },
            {
                Effect = "Allow",
                Principal = {
                    AWS = [
                        "arn:aws:iam::024848447104:user/paramasivam"
                    ]
                },
                Action = [
                    "s3:PutObjectAcl",
                    "s3:PutObjectVersionAcl",
                    "s3:PutObjectTagging",
                    "s3:PutObjectVersionTagging"
                ],
                Resource = "arn:aws:s3:::flow-logs-bucketvpc07457e1-cn-northwest-1/AWSLogs/*"
            }
        ]
    })
}