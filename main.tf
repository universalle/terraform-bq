resource "google_bigquery_dataset" "udf_data_frame" {
  dataset_id                  = "udf_data_frame"
  friendly_name               = "udf"
  description                 = "This is a description of udf_data_frame"
  project                     = var.project
  location                    = "US"
  default_table_expiration_ms = 3600000
}

resource "google_bigquery_table" "card_table" {
  dataset_id = google_bigquery_dataset.udf_data_frame.dataset_id
  table_id = "card_table"
  project = var.project
  external_data_configuration {
    autodetect    = true
    /*
    csv_options {
    quote     = ""
    encoding  = "UTF-8"
    allow_quoted_newlines = true
    }
    */
    source_format = "CSV"
    source_uris = ["gs://mlt_bucket/electronic-card-transactions-november-2019-csv.csv",]
    }
}
resource "null_resource" "udf_query" {
  depends_on = ["google_bigquery_table.card_table"] #wait for the table to be ready
  provisioner "local-exec" {
    command = "bq query < udf.sql --nouse_legacy_sql"
  }
}