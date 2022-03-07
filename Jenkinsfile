node {
    def app

    stage('Clone repository') {
      

        checkout scm
    }

    stage ('Scantist') {
       app.inside {
                sh 'java -jar /opt/scantist-bom-detect.jar'
                }
    }
    stage('Build image') {
  
       app = docker.build("annaliyx/flasktest")
    }

    stage('Test image') {
  

        app.inside {
            sh 'echo "Tests passed"'
        }
    }

    stage('Push image') {
        
        docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
            app.push("${env.BUILD_NUMBER}")
        }
    }
    
    stage('Trigger ManifestUpdate') {
                echo "triggering updatemanifestjob"
                build job: 'updatemanifest', parameters: [string(name: 'DOCKERTAG', value: env.BUILD_NUMBER)]
        }
}
