# Get the certificate from AWS ACM
data "aws_acm_certificate" "issued" {
  domain   = var.certificate_domain_name
  statuses = ["ISSUED"]
}
#enabled: Indicates whether the CloudFront distribution is enabled. In this case, it's set to true.
#aliases: Specifies additional domain names (CNAMEs) that you want to associate with the CloudFront distribution. It takes the value from the variable var.additional_domain_name.
#creating Cloudfront distribution :
resource "aws_cloudfront_distribution" "my_distribution" {
  enabled             = true
  aliases             =  [var.additional_domain_name]
#   origin: Specifies the origin (in this case, an Application Load Balancer) for the CloudFront distribution.
# domain_name: The DNS domain name of the origin.
# origin_id: A unique identifier for the origin.
# custom_origin_config: Configures settings for the custom origin (the ALB in this case).
# http_port: The HTTP port the origin listens on (typically 80 for HTTP).
# https_port: The HTTPS port the origin listens on (typically 443 for HTTPS).
# origin_protocol_policy: Specifies which protocols CloudFront uses to connect to the origin (http-only in this case).
# origin_ssl_protocols: The SSL/TLS protocols that the CloudFront distribution uses when connecting to the origin (TLSv1.2)
  origin {
    domain_name = var.alb_domain_name
    origin_id   = var.alb_domain_name
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }
#   default_cache_behavior: Specifies the default cache behavior for the CloudFront distribution.
# allowed_methods: HTTP methods CloudFront processes and forwards to the origin.
# cached_methods: HTTP methods CloudFront caches.
# target_origin_id: The unique identifier defined for the origin.
# viewer_protocol_policy: The protocol policy for viewers (clients).
# forwarded_values: Configures how CloudFront forwards headers, query strings, and cookies.
  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    target_origin_id       = var.alb_domain_name
    viewer_protocol_policy = "redirect-to-https"
    forwarded_values {
      headers      = []
      query_string = true
      cookies {
        forward = "all"
      }
    }
  }
#   restrictions: Specifies restrictions on who can access your content based on geographic location.
# geo_restriction: Configures geographic restriction settings.
# restriction_type: Specifies whether to blacklist or whitelist locations.
# locations: List of locations to be included or excluded based on the restriction_type.
  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["IN", "US", "CA"]
    }
  }
  tags = {
    Name = var.project_name
  }
#   viewer_certificate: Specifies the SSL/TLS certificate to use for HTTPS connections.
# acm_certificate_arn: The Amazon Resource Name (ARN) of the ACM certificate.
# ssl_support_method: The SSL method CloudFront uses to communicate with the origin (sni-only).
# minimum_protocol_version: The minimum version of the SSL/TLS protocol that you want CloudFront to use for HTTPS connections (TLSv1.2_2018).
  viewer_certificate {
    acm_certificate_arn      = data.aws_acm_certificate.issued.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2018"
  }
}