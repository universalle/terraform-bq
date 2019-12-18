#Privide your project name
variable "project" {
  default     = "mlt-stage"
  description = "Project ID"
  type        = string
}

#Privide your own correct link to .csv file
variable "source_file_uri" {
  default     = ["gs://mlt_bucket/electronic-card-transactions-november-2019-csv.csv"]
  description = "Link to the file .csv in bucket"
  type        = list(string)
}