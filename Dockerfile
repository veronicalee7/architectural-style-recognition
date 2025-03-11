FROM python:3.9-slim-buster

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    python3-dev \
    gcc \
    build-essential \
    libopenblas-dev \
    liblapack-dev \
    libatlas-base-dev \
    gfortran \
    libfreetype6-dev \
    libpng-dev \
    pkg-config \
    libjpeg-dev \
    zlib1g-dev \
    libffi-dev \
    libssl-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip
RUN pip install --upgrade pip

# Install numpy separately from pre-built wheel
RUN pip install numpy==1.19.5 --prefer-binary --no-cache-dir

# Install remaining Python dependencies
COPY requirements.txt .
RUN pip install --prefer-binary --no-cache-dir -r requirements.txt

# Copy application files
COPY app app/

# Expose port
EXPOSE 5000

# Start the server
CMD ["python", "app/server.py", "serve"]
