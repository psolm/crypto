# Use an official Python runtime as a base image
FROM python:3.11-slim-bullseye
WORKDIR /Exchange

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install system dependencies including PostgreSQL client and build tools
RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    python3-dev \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip
RUN pip install --upgrade pip

# Copy the Django project and install dependencies
COPY requirements.txt /Exchange/

# run this command to install all dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the Django project to the container
COPY . /Exchange

# Expose the Django port
EXPOSE 8000

# Run Django’s development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
