@Library('jenkins_shared_library') _
pipeline{
    agent any
    parameters{
        choice(name: 'action', choices: 'Create\nDelete', description: 'Create or Delete')
        string(name: 'cred', defaultValue: '', description: '')
        choice(name: 'repository', choices: 'ECR\nDocker', description: 'ECR or Docker hub')
        string(name: 'uname', defaultValue: '', description: 'ECR - Account ID \n DockerHub- Repo name')
        string(name: 'repo', defaultValue: '', description: 'Enter the repository')
        string(name: 'region', defaultValue: '', description: 'Enter if the repo is ECR')
        string(name: 'tag', defaultValue: "Appv${BUILD_NUMBER + 1}", description: 'You can use the build number or use your custom version')
        

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
            when{ expression { params.action == 'Creat'} }
            steps{
                    script{
                        mvnTest()
                    }
                
            }

        }
            stage('Integration testing'){
            when{ expression { params.action == 'Creat'} }
            steps{
                    script{
                        mvnIntegrationtest()
                    }
                
            }

        }
        stage('Sonar Quality check'){
            when{ expression { params.action == 'Creat'} }
            steps{
                script{
                        def token = "${params.cred}"
                        codeQualitycheck(token)
                    }
                }
        }
        stage('Quality Gate status cofirmation'){
            when{ expression { params.action == 'Creat'} }
            steps{
                script{
                        def token = "${params.cred}"
                        codeQualitycheck(token)
                    }
                }
        }
        stage('Maven Build'){
            when{ expression { params.action == 'Creat'} }
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
                   
                       dockerBuild("${params.uname}","${params.repo}","${params.tag}","${params.repository}","${params.region}")
                   
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
        stage('Pushing image to repo'){
            when{ expression { params.action == 'Create' } }
            steps{
                script{
                    if ( params.repostiory == 'Docker'){
                       imagePushDocker("${params.uname}","${params.repo}","${params.tag}" )
                    }
                    else{
                       imagePushECR("${params.uname}","${params.repo}","${params.tag}","${params.region}" )
                    }
                    }
                }
        }
         stage('Image cleanup'){
            when{ expression { params.action == 'Create'} }
            steps{
                script{
                       imageCleanup("${params.uname}","${params.repo}","${params.tag}" )
                    }
                }
        }
    }
}