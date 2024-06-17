pipeline {
	agent any
	stages {
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
		stage('Build PostGreSQL') {
			agent {
				docker {
					image	'gradle:8.2.0-jdk17-alpine'
					reuseNode true
				}
			}
			steps {
				sh 'gradle --version'
			}
		}
	}
}
