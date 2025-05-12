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
