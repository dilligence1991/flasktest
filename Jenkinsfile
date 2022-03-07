node {
    def app
    def dockerPath = tool 'docker' 
    env.PATH = "${dockerPath}/bin:${env.PATH}" 
    

    stage('Clone repository') {
      

        checkout scm
    }

    stage('Scantist') {
                sh 'cd ${WORKSPACE} && cp /Users/liyaxing/.jenkins/workspace/scantist-bom-detect.jar . && java -jar ${WORKSPACE}/scantist-bom-detect.jar'
                }
    stage('Build image') {
  
       app = docker.build("annaliyx/flasktest")
    }

   

    stage('Push image') {
        sh ' export PATH="$PATH:/usr/local/bin" '
        docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
            app.push("${env.BUILD_NUMBER}")
        }
    }
    
    stage('Trigger ManifestUpdate') {
                echo "triggering updatemanifestjob"
                build job: 'updatemanifest', parameters: [string(name: 'DOCKERTAG', value: env.BUILD_NUMBER)]
        }
}
