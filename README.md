# Collaborative Research Review

This repository contains code, notebooks, and derived datasets for the manuscript **Siloed Canadian Patient Data Constrain AI Collaboration for Precision Public Health: A Scoping Review** (under review).

The project maps patient level data sharing architectures in multicenter medical AI studies that include at least one Canadian affiliated author, with records retrieved from PubMed, IEEE Xplore, ACM Digital Library, Scopus, and Web of Science (2018 to Feb 2025).

![Figure 1. Workflow of the human in the loop screening and extraction process](process.jpg)

**Figure 1.** Workflow of the human in the loop screening and extraction process. The diagram shows the division of labor between human reviewers and automated steps across protocol design, database search, filtering, screening, full text eligibility, and full text data extraction.

## Repository layout

- `main.ipynb`  
  Primary notebook for running the end to end workflow and generating core outputs

- `helper_pmid_pdfs.ipynb`  
  Utilities for working with PubMed IDs and full text PDFs when access is available

- `data/`  
  Intermediate and final datasets produced by the pipeline

- `validation/`  
  Manual validation materials and checks

- `clustering/`  
  Clustering analyses used for modality by domain summaries

- `external_validation_countries/`  
  Country level summaries and external validation helpers

- `html-viz/`  
  HTML based visualizations for interactive exploration

- `sql-paper-2024/`  
  SQL and related scripts used for structured analysis and paper tables

- `pg.ipynb` and `pg_data.ipynb`  
  PostgreSQL oriented workflow for storing and querying extracted features

## Tutorial

### 1) Set up

Clone the repository and create a clean Python environment.

```bash
git clone https://github.com/HIVE-UofT/Collaborative_Research_Review.git
cd Collaborative_Research_Review

python -m venv .venv
source .venv/bin/activate

pip install -U pip
pip install jupyter pandas numpy matplotlib scikit-learn
