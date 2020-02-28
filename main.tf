provider "google" {
  credentials = file("bergqvist-sandbox-91e93ec936cb.json")

  project = "bergqvist-sandbox"
  region = "us-east1"
  zone = "us-east1-c"
}

resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "google_sql_database_instance" "postgres" {
  name = "postgres-instance-${random_id.db_name_suffix.hex}"
  database_version = "POSTGRES_11"

  settings{
    tier = "db-f1-micro"
  }
}

resource "google_sql_user" "users" {
  name     = "bergqvist"
  instance = google_sql_database_instance.postgres.name
  password = "changeme"
}

resource "google_sql_database" "database" {
  name     = "my-database"
  instance = google_sql_database_instance.postgres.name
}