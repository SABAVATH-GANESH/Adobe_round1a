FROM --platform=linux/amd64 python:3.9-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy source code
COPY src/ /app/src/
COPY main.py /app/

# Install Python dependencies
RUN pip install --no-cache-dir \
    PyMuPDF==1.23.14 \
    regex==2023.12.25

# Create input and output directories
RUN mkdir -p /app/input /app/output

# Make main.py executable
RUN chmod +x /app/main.py

# Set environment variables
ENV PYTHONPATH=/app
ENV PYTHONUNBUFFERED=1

# Run the application
CMD ["python", "/app/main.py"]
