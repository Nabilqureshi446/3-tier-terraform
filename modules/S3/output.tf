 output "website_endpoint" {
  value       = aws_s3_bucket.nabil_bucket.website_endpoint
  description = "The URL to access the static website"
 }