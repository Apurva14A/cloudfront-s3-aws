locals {
  create_bucket = var.create_bucket

  # attach_policy = var.attach_require_latest_tls_policy || var.attach_elb_log_delivery_policy || var.attach_lb_log_delivery_policy || var.attach_deny_insecure_transport_policy || var.attach_inventory_destination_policy || var.attach_deny_incorrect_encryption_headers || var.attach_deny_incorrect_kms_key_sse || var.attach_deny_unencrypted_object_uploads || var.attach_policy

  # Variables with type `any` should be jsonencode()'d when value is coming from Terragrunt
  grants = try(jsondecode(var.grant), var.grant)

}


# S3 Bucket Config

resource "aws_s3_bucket" "s3_static_website" {
  count = local.create_bucket ? 1 : 0

  bucket        = var.bucket
  bucket_prefix = var.bucket_prefix

  force_destroy       = var.force_destroy
  object_lock_enabled = var.object_lock_enabled
  tags                = module.common_tags
}

resource "aws_s3_bucket_public_access_block" "static_website_public_access" {
  count = local.create_bucket && var.attach_public_policy ? 1 : 0

  bucket = aws_s3_bucket.s3_static_website[0].id


  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

resource "aws_s3_bucket_acl" "static_website_acl" {
  count = local.create_bucket && ((var.acl != null && var.acl != "null") || length(local.grants) > 0) ? 1 : 0

  bucket                = aws_s3_bucket.s3_static_website[0].id
  expected_bucket_owner = var.expected_bucket_owner

  # hack when `null` value can't be used (eg, from terragrunt, https://github.com/gruntwork-io/terragrunt/pull/1367)
  acl = var.acl == "null" ? null : var.acl

  dynamic "access_control_policy" {
    for_each = length(local.grants) > 0 ? [true] : []

    content {
      dynamic "grant" {
        for_each = local.grants

        content {
          permission = grant.value.permission

          grantee {
            type          = grant.value.type
            id            = try(grant.value.id, null)
            uri           = try(grant.value.uri, null)
            email_address = try(grant.value.email, null)
          }
        }
      }

      owner {
        id           = try(var.owner["id"], data.aws_canonical_user_id.this.id)
        display_name = try(var.owner["display_name"], null)
      }
    }
  }
}

resource "aws_s3_bucket_website_configuration" "static_website_config" {
  count = local.create_bucket && length(keys(var.website)) > 0 ? 1 : 0

  bucket                = aws_s3_bucket.s3_static_website[0].id
  expected_bucket_owner = var.expected_bucket_owner

  dynamic "index_document" {
    for_each = try([var.website["index_document"]], [])

    content {
      suffix = index_document.value
    }
  }

  dynamic "error_document" {
    for_each = try([var.website["error_document"]], [])

    content {
      key = error_document.value
    }
  }

  #   dynamic "redirect_all_requests_to" {
  #     for_each = try([var.website["redirect_all_requests_to"]], [])

  #     content {
  #       host_name = redirect_all_requests_to.value.host_name
  #       protocol  = try(redirect_all_requests_to.value.protocol, null)
  #     }
  #   }

  #   dynamic "routing_rule" {
  #     for_each = try(flatten([var.website["routing_rules"]]), [])

  #     content {
  #       dynamic "condition" {
  #         for_each = [try([routing_rule.value.condition], [])]

  #         content {
  #           http_error_code_returned_equals = try(routing_rule.value.condition["http_error_code_returned_equals"], null)
  #           key_prefix_equals               = try(routing_rule.value.condition["key_prefix_equals"], null)
  #         }
  #       }

  #       redirect {
  #         host_name               = try(routing_rule.value.redirect["host_name"], null)
  #         http_redirect_code      = try(routing_rule.value.redirect["http_redirect_code"], null)
  #         protocol                = try(routing_rule.value.redirect["protocol"], null)
  #         replace_key_prefix_with = try(routing_rule.value.redirect["replace_key_prefix_with"], null)
  #         replace_key_with        = try(routing_rule.value.redirect["replace_key_with"], null)
  #       }
  #     }
  #   }
}

module "common_tags" {
  source = "../modules/aws-common-tags"

}