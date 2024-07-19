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
│   │   │   ├── stg_kaggle__topic.sql
│   │   │   ├── stg_kaggle__content.sql
│   │   │   └── stg_kaggle__correl.sql
│   ├── intermediate 
│   │   ├── education 
│   │   │   ├── int_topic_generate_hierarchy.sql 
│   ├── marts
│   │   ├── education 
│   │   │   ├── content.sql 
│   │   │   ├── topic.sql 
├── packages.yml
├── snapshots
└── tests
    └── 

# Thoughts 
According to https://docs.getdbt.com/docs/build/seeds, one poor use-case of dbt seeds is loading raw data that has been exported to CSVs. Therefore, it isn't best practice to use seeds in our case. Base models aren't necessary since we aren't joining in separate base tables or unioning disparate but symmetrical sources. 

I tried uploading and creating the tables in a new dataset in BigQuery, but there were many issues with the data. Examples include: Missing close quote character (").; line_number: 3368 byte_offset_to_start_of_line: 608979 column_index: 2 column_name: "string_field_2" column_type: STRING value: "\320\232\320\260\320\272\321\202\320\276 \321\211\320\265 \320...". 

To circumvent these issues I used nltk and regex to help clean up appropriate columns. I then uploaded these cleaned csv files to bigquery where I was then able to define a source and call them in the staging layer. https://stackoverflow.com/questions/64120410/defining-big-query-dbt-sources-with-characters-in-table-name. Type casting, basic computations aren't necessary. Renaming and possibly categorization will be important (case when statements). Standardization and encoding is unnecesssary for the correlation staging table so renaming is the only thing done. Renaming conventions follow https://www.emilyriederer.com/post/column-name-contracts/. 

Unlike a typical scenario where there may be marts on based on business domains such as finance and marketing, this example is unconventional. In our case, we are trying to learn what content aligns with a specific topic. This can bolster educational inititatives by enriching the content that can be created in the future. 
Therefore, the content and topic mart both fall under this education innovation domain. Many topics don't have content and drawing insights from subtopics and supertopics and the content respectively used, it might can inform what content would be best to use. 
- Count for content type/ counting proprtion 
- Understanding the copyright_holder and distribution of content 
- Understanding the hierarchy and tree of topics 
- Content that falls under many categories? 

One useful feature that I realized wasn't necessary was a macro. I thought that creating a macro was needed to generate a hierarchy for each topic. Macros should be used when you are applying the same function to several models. In this case it was only applied to one model to transform the data, ultimately, nullifying its use. Instead I opted to create an intermediate layer that would simply contain all of the original topic ids and its respective hierarchy. 
https://docs.getdbt.com/docs/build/jinja-macros








