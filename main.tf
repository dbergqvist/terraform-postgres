/*
Copyright 2020 Google Inc. All Rights Reserved.
Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
 
http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
This is not an official Google product
*/

provider "google" {
  version = "3.10.0"
  credentials = file(var.credentials_file)

  project = var.project
  region = var.region
  zone = var.zone
}

resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "google_sql_database_instance" "postgres" {
  name = "postgres-instance-${random_id.db_name_suffix.hex}"
  database_version = "POSTGRES_11"

  settings{
    tier = "db-f1-micro"
    user_labels = {
      "environment" = "development"
    }
    maintenance_window {
      day  = "1"
      hour = "4"
    }
    backup_configuration {
      enabled = true
      start_time = "04:30"
    }
  }
}

resource "google_sql_user" "users" {
  name     = "janedoe"
  instance = google_sql_database_instance.postgres.name
  password = "changeme"
}

resource "google_sql_database" "database" {
  name     = "my-database"
  instance = google_sql_database_instance.postgres.name
}
