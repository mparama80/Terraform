 output "flow_log_id" {
   value = aws_flow_log.cn-northwest-infra-vpc.id
 }

 output "s3_bucket_arn" {
   value = aws_s3_bucket.flow_logs.arn
 }