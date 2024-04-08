Each folder [cordis](/cordis), [sdss](/sdss), [oncomx](/oncomx) holds the relevant files (i.e. seed data, synth data, and dev data) for each of the datasets. Additionally each file contains a file tables.json which contains a json structure of the database schema including table names, column names, column data types and primary/foreign key relationships. 

The following is an example of the file structure: 
- dev.json --> the manually generated development dataset 
- seed.json --> the manually generated seed dataset 
- synth.json --> the synthetically generated dataset using the seed query templates
- tables.json --> a json representation of the schema containing:
  - the database name ("db_id"),
  - free text table names for NLP pipelines ("table_names") e.g. "Stellar spectral line indices" vs "spplines"
  - original table names ("table_names_original") i.e. the table names as they are in the database
  - free text column names for NLP pipelines ("column_names") 
  - original column names ("column_names_original") i.e. the column names as they are in the database
  - column data types ("column_types"):  time, text or number
  - foreign key relationships("foreign_keys")
  - primary keys ("primary_keys")

The PostgreSQL databases for each of the 3 databases used for this benchmark can be found at the following links: 
[CORDIS](https://drive.google.com/uc?export=download&id=1-YXF9mPN7GmK4ApBz2aZjAoJkdpPE6JF)
[SDSS](https://drive.google.com/uc?export=download&id=1JEeSq9OXhR1G7hyJFLmlvF7wcvL38X3Q)
[OncoMX](https://drive.google.com/uc?export=download&id=1Y02tXXzaWaYwSKQtnWbYPe7dKk0T5Xmp)

PostgreSQL specification:  DBMS: PostgreSQL (ver. 9.5.20) Case sensitivity: plain=lower, delimited=exact Driver: PostgreSQL JDBC Driver (ver. 42.5.0, JDBC4.2) 
