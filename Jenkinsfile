pipeline{
    agent any
    
    parameters{
        choice(name:'action' , choices:'create\ndelete' ,description:'Select create or destroy.')
    }
    
    environment {
        SCANNER_HOME = tool 'sonar-scanner'
    }
    
    stages{
        stage('Clean Workspace'){
            steps{
                cleanWs()
            }
        }
        
        stage('Git Checkout'){
            steps{
                git branch: 'main', credentialsId: 'GitHub', url: 'https://github.com/Khaushik-P/DevopsworkHUB.git'
            }
        }
        stage("Sonarqube Analysis") {
            when { expression { params.action == 'create'}}  
            steps {
                withSonarQubeEnv('sonar-server') {
                    sh '''$SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=DevopsWorkHub -Dsonar.projectKey=DevopsWorkHub'''
                }
            }
        }
        stage('TRIVY FS SCAN') {
            when { expression { params.action == 'create'}}
            steps {
                sh "trivy fs . > trivyfs.txt"
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    sh 'docker build -t DevopsWorkForceHub:latest .'
                }
            }
        }
    }
}