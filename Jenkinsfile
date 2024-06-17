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
		stage('Pull Postgres Image')
		{
			steps {
				script {
					// docker.image('postgres:latest').pull()
					sh 'mkdir -p ./postgres && cp postgres_Dockerfile ./postgres/Dockerfile'
					docker.build('my-postgres-image', './postgres/')
				}
			}
        	}
		stage('Pull redis Image')
		{
			steps {
				script {
					// docker.image('redis:latest').pull()
					sh 'mkdir -p ./redis && cp redis_Dockerfile ./redis/Dockerfile'
					docker.build('my-redis-image', './redis/')
				}
			}
        	}
		stage('Pull mongo Image')
		{
			steps {
				script {
					// docker.image('mongo:latest').pull()
					sh 'mkdir -p ./mongo && cp mongo_Dockerfile ./mongo/Dockerfile'
					docker.build('my-mongo-image', './mongo/')
				}
			}
        	}
		stage('Pull mongo-express Image')
		{
			steps {
				script {
					// docker.image('mongo-express:latest').pull()
					sh 'mkdir -p ./mongo-express && cp mongo-express_Dockerfile ./mongo-express/Dockerfile'
					docker.build('my-mongo-express-image', './mongo-express/')
				}
			}
        	}
	}
}
