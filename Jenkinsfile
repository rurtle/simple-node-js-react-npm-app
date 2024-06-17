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
/*
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
		stage('Build PostgreSQL') {
			agent {
				docker {
					image 'postgres:latest'
					reuseNode true
				}
			}
			steps {
				sh 'cp postgres_Dockerfile Dockerfile'
				sh 'docker build -t mypostgres .'
				sh 'rm -f Dockerfile'
			}
		}
*/
		stage('Pull Postgres Image')
		{
			steps {
				script {
					docker.image('postgres:latest').pull()
					sh 'mkdir -p ./postgres && cp postgres_Dockerfile ./postgres/Dockerfile'
					docker.build('my-postgres-image', './postgres/')
				}
			}
        	}
/*
		stage('Pull Postgres Image') {
			steps {
				script {
					docker.image('postgres:latest').pull()
				}
			}
		}
		stage('Pull Redis Image') {
			steps {
				script {
					docker.image('redis:latest').pull()
				}
			}
		}
		stage('Pull Mongo Express Image') {
			steps {
				script {
					docker.image('mongo-express:latest').pull()
				}
			}
		}
		stage('Pull Mongo DB Image') {
			steps {
				script {
					docker.image('mongo:latest').pull()
				}
			}
		}
		stage('Build Docker Containers Locally') {
			steps {
				script {
					docker.build('my-postgres-image', 'postgres:latest')
					docker.build('my-redis-image', 'redis:latest')
					docker.build('my-mongo-express-image', 'mongo-express:latest')
					docker.build('my-mongo-db-image', 'mongo:latest')
				}
			}
		}
*/
	}
}
