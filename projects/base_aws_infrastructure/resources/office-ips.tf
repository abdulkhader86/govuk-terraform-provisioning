# variables defined here are available to every environment.

## Office IP Addresses
## When adding an ip please also add a comment explaining what it covers
# 80.194.77.{90,100} - Aviation house office IPs.
# 85.133.67.244 - DR site.
# https://sites.google.com/a/digital.cabinet-office.gov.uk/gds-internal-it/news/aviationhouse-sourceipaddresses for details.
variable "office_cidrs" {
  description = "CSV of CIDR addresses for our office"
  default = "80.194.77.90/32,80.194.77.100/32,85.133.67.244/32"
}
