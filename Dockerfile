# Use an official Python runtime as the base image
FROM python:3.11.0-slim

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt requirements.txt

# Upgrade pip and install system dependencies
RUN pip install --upgrade pip && \
    apt-get update && apt-get install -y \
    libpq-dev \
    python3-dev \
    build-essential \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies from the requirements file
RUN pip install -r requirements.txt

# Copy the rest of the application code into the container
COPY . .

# Expose the port the app runs on
EXPOSE 8080

# Command to run the Flask app using Gunicorn
CMD ["gunicorn", "-b", "0.0.0.0:8080", "app:app"]
