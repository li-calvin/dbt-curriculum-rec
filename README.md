# Learning Equality - Curriculum Recs 
### Prerequisites 


### High Level Overview 
Folder structure 
dbt-curriculum-rec
├── README.md
├── analyses
├── seeds
├── dbt_project.yml
├── macros
├── raw_data
│   ├── content.csv 
│   ├── correlations.csv 
│   └── topics.csv 
├── models
│   ├── staging
│   │   ├── kaggle
│   │   │   ├── _kaggle__docs.md
│   │   │   ├── _kaggle__models.yml
│   │   │   ├── _kaggle__sources.yml
│   │   │   ├── stg_kaggle__topics.sql
│   │   │   ├── stg_kaggle__content.sql
│   │   │   └── stg_kaggle__correl.sql
├── packages.yml
├── snapshots
└── tests
    └── 

# High Level Overview 
According to https://docs.getdbt.com/docs/build/seeds, one poor use-case of dbt seeds is
loading raw data that has been exported to CSVs. Therefore, it isn't best practice to use seeds in our case. Base models aren't necessary since we aren't joining in separate base tables or unioning disparate but symmetrical sources. 

I tried uploading and creating the tables in a new dataset in BigQuery, but there were many issues with the data. Examples include: Missing close quote character (").; line_number: 3368 byte_offset_to_start_of_line: 608979 column_index: 2 column_name: "string_field_2" column_type: STRING value: "\320\232\320\260\320\272\321\202\320\276 \321\211\320\265 \320...",Error while reading data, error message: Data between close quote character (") and field separator.; line_number: 1980 byte_offset_to_start_of_line: 363416 column_index: 1 column_name: "string_field_1" column_type: STRING value: "". 

To circumvent these issues I used nltk and regex to help clean up appropriate columns. I then uploaded these cleaned csv files to bigquery where I was then able to define a source and call them in the staging layer. 




