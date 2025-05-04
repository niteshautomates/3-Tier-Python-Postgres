pipeline {
    agent {
        label 'linux'
    }
    environment {
        SONAR_SCANNER_HOME = tool 'SonarQube'
    }
    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'develop', credentialsId: 'b11bd624-4367-44c8-a639-27773270987a', url: 'https://github.com/niteshautomates/3-Tier-Python-Postgres.git'
            }
        }
        stage('Setup Virtual Environment') {
            steps {
                sh '''
                # Remove any existing virtual environments
                rm -rf venv
                # Create a new virtual environment
                python3 -m venv venv
                chmod -R 755 venv
                # Activate the virtual environment and install dependencies
                . venv/bin/activate && \
                pip install --upgrade pip && \
                pip install -r requirements.txt
                '''
            }
        }
        stage('Test') {
            steps {
                sh '''
                # Activate the virtual environment and run tests
                . venv/bin/activate && \
                pip install pytest && \
                pip install pytest-cov && \
                pytest --cov=app --cov-report=xml && \
                pytest --cov=app --cov-report=term-missing --disable-warnings
                '''
            }
        }
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh '''
                    /home/niteshops01/jenkins/tools/hudson.plugins.sonar.SonarRunnerInstallation/SonarQube/bin/sonar-scanner \
                        -Dsonar.projectKey=3-Tier-Python-Postgres \
                        -Dsonar.projectName=3-Tier-Python-Postgres \
                        -Dsonar.exclusions=venv/** \
                        -Dsonar.sources=. \
                        -Dsonar.python.coverage.reportPaths=coverage.xml
                    '''
                }
            }
        }
        stage("Quality Gate") {
            steps {
                script {
                    waitForQualityGate abortPipeline: false, credentialsId: 'sonar-token'
                }
            }
        }
        stage('Trivy File Scan') {
            steps {
                sh 'trivy fs --format table -o trivy_results.txt .'
            }
        }
    }
}