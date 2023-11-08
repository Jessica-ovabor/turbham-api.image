# Use an official Python runtime as a parent image
FROM python:3.10.11

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install pipenv
RUN pip install pipenv

# Install wait-for-it.sh
ADD https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh /wait-for-it.sh
RUN chmod +x /wait-for-it.sh

# Include your application files and configurations
COPY init-scripts/init.sql /docker-entrypoint-initdb.d/init.sql

# Install Python packages using pipenv
COPY Pipfile /app
COPY Pipfile.lock /app
RUN pipenv install --deploy --ignore-pipfile

# Expose port 5000
EXPOSE 5000

# Use an entrypoint script to run CLI commands
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set the entrypoint to execute the script
ENTRYPOINT ["/entrypoint.sh"]
