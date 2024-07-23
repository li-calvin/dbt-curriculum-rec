# Learning Equality - Curriculum Recommendation
https://www.kaggle.com/competitions/learning-equality-curriculum-recommendations/data

## Folder Structure
Folder structure 
dbt-curriculum-rec
```
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
│   │       ├── _kaggle__docs.md
│   │       ├── _kaggle__models.yml
│   │       ├── _kaggle__sources.yml
│   │       ├── stg_kaggle__topic.sql
│   │       ├── stg_kaggle__content.sql
│   │       └── stg_kaggle__correl.sql
│   ├── intermediate 
│   │   ├── education 
│   │       ├── int_topic_generate_hierarchy.sql 
│   │       ├── int_content_copyright_holder_count.sql
│   │       └── int_content_copyright_kind_count.sql
│   ├── marts
│   │   ├── education 
│   │       ├── content.sql 
│   │       ├── topic.sql 
├── packages.yml
├── snapshots
├── visualization.ipynb
├── preprocessing.ipynb
└── images 
    ├── DAG.png
    ├── topic_hierarchy_c_000425df0161.png
    └── content_distribution_t_efaa6755bf62.png
```

## Thoughts 
According to https://docs.getdbt.com/docs/build/seeds, one poor use-case of dbt seeds is loading raw data that has been exported to CSVs. Therefore, it isn't best practice to use seeds in our case. Base models aren't necessary since we aren't joining in separate base tables or unioning disparate but symmetrical sources. 

I uploaded and created the tables in dataset in BigQuery. There were issues because of unclean data. To circumvent these issues I used nltk and regex to help clean up appropriate columns. I then uploaded these cleaned csv files to bigquery where I was then able to define a source and call them in the staging layer. https://stackoverflow.com/questions/64120410/defining-big-query-dbt-sources-with-characters-in-table-name. Type casting, basic computations aren't necessary. Renaming and possibly categorization will be important (case when statements). Standardization and encoding is unnecesssary for the correlation staging table so renaming is the only thing done. Renaming conventions follow https://www.emilyriederer.com/post/column-name-contracts/. 

Unlike a typical scenario where there may be marts on based on business domains such as finance and marketing, this example is unconventional. In our case, we are trying to learn what content aligns with a specific topic. This can bolster educational inititatives by enriching the content that can be created in the future. 
Therefore, the content and topic mart both fall under this education domain. Many topics don't have content. To help supplement the missing content, we could draw insights from subtopics and supertopics. Once we understand the copyright holder kind of content distributions, we could make a more informed decision on what to add to a curriculum for a specific topic. 

One feature that I realized wasn't necessary was a macro. I thought that creating a macro was needed to generate a hierarchy for each topic. Macros should be used when you are applying the same function to several models. In this case it was only applied to one model, ultimately, nullifying its use. Instead I opted to create an intermediate layer that would simply contain all of the original topic ids and its respective hierarchy. https://docs.getdbt.com/docs/build/jinja-macros

I chose to use python to display the distribution of content kinds and copyright holders for a specific topic using pie charts. I also utilized networkx to help visualize the topic hierarchy for a piece of content. Content can belong to many topics (origin topics), and the other topics are the super and subtopics. 

dbt docs generate, and dbt docs serve was used to generate the lineage graph in DAG.png

## Directed Acyclic Graph
![alt text](https://github.com/li-calvin/dbt-curriculum-rec/blob/main/images/DAG.png?raw=true)

## Visualizations 
# Pie Chart
![alt text](https://github.com/li-calvin/dbt-curriculum-rec/blob/main/images/content_distribution_t_efaa6755bf62.png?raw=true)

*Figure 1: Given a topic id find, it shows the percentage breakdown of the kind of content and copyright holder*

# Hierarchy Tree 
![alt text](https://github.com/li-calvin/dbt-curriculum-rec/blob/main/images/topic_hierarchy_c_000425df0161.png?raw=true)

*Figure 2: Given a content id it will find the hierarchy of all topics correlated to the content*