@Library('jenkins_shared_library') _
pipeline{
    agent any
    parameters{
        choice(name: 'action', choices: 'Create\nDelete', description: 'Create or Delete')
        string(name: 'cred', defaultValue: '', description: '')
        string(name: 'uname', defaultValue: '', description: 'Enter the username')
        string(name: 'repo', defaultValue: '', description: 'Enter the repository')
        string(name: 'tag', defaultValue: "${BUILD_NUMBER}+1", description: 'You can use the build number or use your custom version')
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
        stage('Docker build'){
            when{ expression { params.action == 'Create'} }
            steps{
                script{
                       dockerBuild("${params.uname}","${params.repo}","${params.tag}" )
                    }
                }
        }
        stage('Trivy image scan'){
            when{ expression { params.action == 'Create'} }
            steps{
                script{
                       imageScan("${params.uname}","${params.repo}","${params.tag}" )
                    }
                }
        }
    }
}