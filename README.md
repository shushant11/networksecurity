# Network Security — Phishing Detection System

An end-to-end Machine Learning and MLOps project that automates data ingestion, validation, transformation, model training, experiment tracking, and deployment of a phishing-detection application using **Python, Scikit-learn, MongoDB, MLflow, DagsHub, Docker, GitHub Actions, and AWS**.

## Project Overview

The objective of this project is to build and deploy a machine learning application that analyzes network-security-related features and generates predictions to support phishing detection.

The project implements a modular ML pipeline for data processing and model training, tracks experiments using MLflow integrated with DagsHub, stores artifacts in AWS S3, and deploys a FastAPI application through a Docker-based CI/CD workflow.

The deployed application accepts a CSV file, processes its features using saved preprocessing and model artifacts, and presents predictions in an HTML table.

## Key Features

- Automated data ingestion from MongoDB.
- Schema validation and statistical data-drift analysis.
- Missing-value handling using K-Nearest Neighbors (KNN) imputation.
- Model training and hyperparameter tuning with Scikit-learn.
- Evaluation of multiple classification algorithms.
- Experiment tracking with MLflow and DagsHub.
- Model and preprocessing artifact serialization.
- AWS S3 synchronization for training artifacts and model files.
- FastAPI application for CSV-based predictions.
- Docker-based application packaging.
- GitHub Actions workflow for automated image building, publishing, and deployment.
- Amazon Elastic Container Registry (ECR) integration.

## Technology Stack

| Category | Technologies |
|---|---|
| Programming Language | Python |
| Data Processing | Pandas, NumPy |
| Machine Learning | Scikit-learn |
| Database | MongoDB |
| Statistical Analysis | SciPy |
| Configuration | YAML, Python-dotenv |
| Experiment Tracking | MLflow, DagsHub |
| Model Serialization | Pickle |
| API Framework | FastAPI |
| ASGI Server | Uvicorn |
| HTML Rendering | Jinja2 |
| Containerization | Docker |
| CI/CD | GitHub Actions |
| Cloud Storage | AWS S3 |
| Container Registry | Amazon ECR |
| Deployment | AWS environment with a self-hosted GitHub Actions runner |

## System Architecture

The project consists of two primary workflows.

### 1. Model Training Pipeline

```text
                  MongoDB
                     |
                     v
              Data Ingestion
                     |
                     v
              Data Validation
                     |
                     v
            Data Transformation
             (KNN Imputation)
                     |
                     v
               Model Trainer
                     |
                     v
          Model Evaluation and
           Hyperparameter Tuning
                     |
          +----------+----------+
          |                     |
          v                     v
    MLflow + DagsHub       Model Artifacts
                                |
                                v
                         AWS S3 Sync
```

### 2. Application Deployment and Prediction

```text
              Developer Push
                     |
                     v
              GitHub Repository
                     |
                     v
              GitHub Actions
                     |
                     v
               Docker Build
                     |
                     v
                Amazon ECR
                     |
                     v
            AWS Deployment Runner
                     |
                     v
             Docker Container
                     |
                     v
                FastAPI App
                     |
              CSV File Upload
                     |
                     v
             Saved Preprocessor
                     |
                     v
              Trained Classifier
                     |
                     v
             Prediction Results
                     |
                     v
                HTML Table
```

## Machine Learning Pipeline

### 1. Data Ingestion

The data-ingestion component retrieves records from MongoDB and converts them into a Pandas DataFrame.

It then creates a feature-store CSV file and splits the dataset into training and testing sets.

**Responsibilities:**
- Connect to MongoDB.
- Retrieve the network-security dataset.
- Prepare the feature-store dataset.
- Split data into training and testing sets.
- Save ingestion artifacts.

### 2. Data Validation

The validation component loads the configured schema and checks the number of columns in the training and testing datasets.

It also implements statistical drift analysis using the two-sample Kolmogorov–Smirnov (KS) test.

Validation reports are saved as YAML artifacts.

### 3. Data Transformation

The transformation component separates input features from the target column.

**Target column:** `Result`

The transformation stage:
- Maps target value `-1` to `0`.
- Applies `KNNImputer` to handle missing feature values.
- Fits the imputer on the training features.
- Uses the fitted imputer to transform the testing features.
- Saves transformed training and testing arrays as NumPy files.
- Serializes the preprocessing object for inference.

The imputer is configured with three neighbors and uniform weights.

### 4. Model Training

The training component evaluates the following classification algorithms:

- Random Forest Classifier
- Decision Tree Classifier
- Gradient Boosting Classifier
- Logistic Regression
- AdaBoost Classifier

Hyperparameter tuning is implemented using Scikit-learn's `GridSearchCV` with three-fold cross-validation.

The model-training component calculates the following classification metrics:

- F1-score
- Precision
- Recall

The selected classifier and preprocessing artifacts are saved for subsequent inference.

### 5. Experiment Tracking

MLflow is integrated with DagsHub to record model artifacts and classification metrics.

The tracking component logs:
- F1-score
- Precision
- Recall
- The trained classifier artifact

This integration provides a record of model-training experiments.

## Experiment Results

The following are the highest reported metrics among six experiment runs shared during project documentation.

| Metric | Reported Result |
|---|---:|
| F1-score | 99.17% |
| Precision | 98.95% |
| Recall | 99.39% |

These values correspond to the MLflow run `receptive-whale-503`.

**Note:** These are recorded experiment results, not independently verified production
