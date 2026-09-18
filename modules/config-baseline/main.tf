# Baseline de AWS Config: recorder + delivery channel + regras gerenciadas
# para garantir tagueamento obrigatório e bloquear buckets S3 públicos em
# toda conta provisionada.

resource "aws_s3_bucket" "config_logs" {
  bucket_prefix = "aft-config-logs-"
}

resource "aws_iam_role" "config" {
  name = "aft-config-baseline-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "config.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "config" {
  role       = aws_iam_role.config.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWS_ConfigRole"
}

resource "aws_config_configuration_recorder" "this" {
  name     = "aft-baseline-recorder"
  role_arn = aws_iam_role.config.arn

  recording_group {
    all_supported = true
  }
}

resource "aws_config_delivery_channel" "this" {
  name           = "aft-baseline-delivery-channel"
  s3_bucket_name = aws_s3_bucket.config_logs.id

  depends_on = [aws_config_configuration_recorder.this]
}

resource "aws_config_configuration_recorder_status" "this" {
  name       = aws_config_configuration_recorder.this.name
  is_enabled = true

  depends_on = [aws_config_delivery_channel.this]
}

resource "aws_config_config_rule" "required_tags" {
  name = "aft-required-tags"

  source {
    owner             = "AWS"
    source_identifier = "REQUIRED_TAGS"
  }

  input_parameters = jsonencode({
    tag1Key = "ManagedBy"
    tag2Key = "Environment"
    tag3Key = "CostCenter"
  })

  depends_on = [aws_config_configuration_recorder.this]
}

resource "aws_config_config_rule" "s3_public_read_prohibited" {
  name = "aft-s3-bucket-public-read-prohibited"

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_PUBLIC_READ_PROHIBITED"
  }

  depends_on = [aws_config_configuration_recorder.this]
}

output "config_recorder_name" {
  value = aws_config_configuration_recorder.this.name
}

output "config_bucket" {
  value = aws_s3_bucket.config_logs.id
}

