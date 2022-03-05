node {

 environment {
        DOCKERHUB_CREDENTIALS=credentials('dockerhub')
        def docker_img_name="annaliyx/flask-project"
    }
   try{
        stage('Clone') {
            steps{
                //clone source code
                checkout([$class: 'GitSCM', branches: [[name: "main"]], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '930fca3a-e165-4fd8-baef-7211f73713e8', url: 'https://github.com/dilligence1991/flask.git']]])
            }
        }
        stage ('Scantist') {
2            steps{
                 //scan code
3                sh '''
4                    curl -s https://download.scantist.io/scantist-bom-detect.jar --output scantist-bom-detect.jar
5                    java -jar scantist-bom-detect.jar
6                '''
7            }
8        }
        stage('Build') {
            steps{
                
                sh 'sudo docker build -t ${docker_img_name}:latest .'
            }
        }
        stage('Docker Build') {
            steps{
                //create and deploy image to docker hub
                
                sh "docker tag ${docker_img_name}:${env.BUILD_NUMBER} ${docker_img_name}:latest"
                withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'dockerPassword', usernameVariable: 'dockerUser')]) {
                sh "docker login -u ${dockerUser} -p ${dockerPassword} hub.docker.com"
                sh "docker push ${docker_img_name}:latest"
                }
            }
        }
        stage('Argocd Deploy') {
            steps{
                //
                //sh 'docker push ${docker_img_name}:latest'
            }
        }
    }catch(err) {
       always {
         echo 'end'
       }
    }
}
