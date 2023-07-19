@Library('jenkins_shared_library') _
pipeline{
    agent any
    parameters{
        choice(name: 'action', choices: 'Create\nDelete', description: 'Create or Delete')
        string(name: 'cred', defaultValue: '', description: '')
    }
    stages{
        stage('Git checkout'){
            when{ expression { params.action == 'Create'} }
            steps{
                    gitCheckout(
                        branch: "main",
                        url: "https://github.com/Ranjith-kumar533/CICD.git"
            )
                
            }
        }
            stage('Unit testing'){
            when{ expression { params.action == 'Create'} }
            steps{
                    script{
                        mvnTest()
                    }
                
            }

        }
            stage('Integration testing'){
            when{ expression { params.action == 'Create'} }
            steps{
                    script{
                        mvnIntegrationtest()
                    }
                
            }

        }
        stage('Sonar Quality check'){
            when{ expression { params.action == 'Create'} }
            steps{
                script{
                        def token = "${params.cred}"
                        codeQualitycheck(token)
                    }
                }
        }
        stage('Quality Gate status cofirmation'){
            when{ expression { params.action == 'Create'} }
            steps{
                script{
                        def token = "${params.cred}"
                        codeQualitycheck(token)
                    }
                }
        }
        stage('Maven Build'){
            when{ expression { params.action == 'Create'} }
            steps{
                script{
                       mvnBuild()
                    }
                }
        }
    }
}