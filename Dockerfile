FROM python:3.10-slim-bookworm

WORKDIR /app

# Copy requirements first to improve build caching
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Install system dependencies and AWS CLI v2
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        unzip \
        ca-certificates && \
    curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf aws awscliv2.zip && \
    rm -rf /var/lib/apt/lists/*

# Copy application files
COPY . /app

# Start the application
CMD ["python3", "app.py"]