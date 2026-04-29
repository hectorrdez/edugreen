pipeline {
    agent any

    environment {
        // Asegúrate de que este nombre sea el que configuraste en 'System'
        SONAR_SERVER = 'sonarqube'
    }

    stages {
        stage('Checkout') {
            steps {
                git credentialsId: 'github-auth',
                    url: 'https://github.com/hectorrdez/auto_transcriptor.git',
                    branch: 'main'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                script {
                    // 'sonar-scanner' debe coincidir con el campo 'Name' de tu imagen
                    def scannerHome = tool 'sonar-scanner'

                    withSonarQubeEnv("${SONAR_SERVER}") {
                        sh "${scannerHome}/bin/sonar-scanner \
                            -Dsonar.projectKey=auto_transcriptor \
                            -Dsonar.sources=. \
                            -Dsonar.host.url=http://192.168.50.200:9000"
                    }
                }
            }
        }

        stage('Quality Gate') {
            steps {
                timeout(time: 5, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }
    }
}
