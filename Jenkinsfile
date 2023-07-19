@Library('jenkins_shared_library') _
pipeline{
    agent any
    stages{
        stage('Git checkout'){
            steps{
                    gitCheckout(
                        branch: "main",
                        url: "https://github.com/Ranjith-kumar533/CICD.git"
            )
                
            }

        }
    }
}