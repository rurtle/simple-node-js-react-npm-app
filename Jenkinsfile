pipeline {
	agent {
		label 'docker'
	}
	stages {
		stage('Docker node test') {
			agent {
				docker {
					label 'docker'
					image 'node:lts-buster-slim'
					args '-p 4000:4000'
				}
			}
			steps {
				sh 'node --version'
			}
		}
		stage('Build') { 
			steps {
				sh 'npm install' 
			}
		}
        	stage('Test') {
        		steps {
				sh 'node --version'
        	        	sh './jenkins/scripts/test.sh'
        	    	}
        	}
		stage('Deliver') {
			steps {
				sh './jenkins/scripts/deliver.sh'
				input message: 'Finished using the web site? (Click "Proceed" to continue)'
				sh './jenkins/scripts/kill.sh'
			}
		}
	}
}
