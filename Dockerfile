# Use an official Python runtime as a base image
FROM python:3.11-slim-bullseye

# Set working directory
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

# Copy requirements first (for better caching)
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy ALL project files (including manage.py)
COPY . .

# Make entrypoint script executable
RUN chmod 777 entrypoint.sh

# Use entrypoint script
ENTRYPOINT ["./entrypoint.sh"]

# Expose the Django port
EXPOSE 8000

# Run Django’s development server
CMD ["python", "Exchange/manage.py", "runserver", "0.0.0.0:8000"]
