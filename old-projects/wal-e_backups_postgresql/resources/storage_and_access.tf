module "private_s3_bucket" {
    source = "../../../modules/private_s3_bucket"

    bucket_name = "govuk-wal-e-backups-postgresql"
    environment = "${var.environment}"
    team        = "Infrastructure"
    username    = "govuk-wal-e-backups-postgresql"
    lifecycle   = "true"
}
