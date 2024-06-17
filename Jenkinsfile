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
		stage('Pull & build postgres docker image')
		{
			steps {
				script {
					// docker.image('postgres:latest').pull()
					sh 'mkdir -p ./postgres && cp postgres_Dockerfile ./postgres/Dockerfile'
					docker.build('my-postgres-image', './postgres/')
				}
			}
        	}
		stage('Pull & build redis docker image')
		{
			steps {
				script {
					// docker.image('redis:latest').pull()
					sh 'mkdir -p ./redis && cp redis_Dockerfile ./redis/Dockerfile'
					docker.build('my-redis-image', './redis/')
				}
			}
        	}
		stage('Pull & build mongo docker image')
		{
			steps {
				script {
					// docker.image('mongo:latest').pull()
					sh 'mkdir -p ./mongo && cp mongo_Dockerfile ./mongo/Dockerfile'
					docker.build('my-mongo-image', './mongo/')
				}
			}
        	}
		stage('Pull & build mongo-express docker image')
		{
			steps {
				script {
					// docker.image('mongo-express:latest').pull()
					sh 'mkdir -p ./mongo-express && cp mongo-express_Dockerfile ./mongo-express/Dockerfile'
					docker.build('my-mongo-express-image', './mongo-express/')
				}
			}
        	}
		stage('Create local docker registry')
		{
			steps {
				script {
					sh 'docker run -d -p 5000:5000 --name my-local-registry --restart=always registry:2'
				}
			}
		}
		stage('Pushing built container images to my-local-registry')
		{
			steps {
				script {
					sh 'echo "Pushing postgres image to local registry"'
					sh 'docker tag my-postgres-image localhost:5000/my-postgres-image'
					sh 'docker push localhost:5000/my-postgres-image'
					sh 'echo "postgres Docker image pushed to my-local-registry"'

					sh 'echo "Pushing redis image to local registry"'
					sh 'docker tag my-redis-image localhost:5000/my-redis-image'
					sh 'docker push localhost:5000/my-redis-image'
					sh 'echo "redis Docker image pushed to my-local-registry"'

					sh 'echo "Pushing mongo image to local registry"'
					sh 'docker tag my-mongo-image localhost:5000/my-mongo-image'
					sh 'docker push localhost:5000/my-mongo-image'
					sh 'echo "mongo Docker image pushed to my-local-registry"'

					sh 'echo "Pushing mongo-express image to local registry"'
					sh 'docker tag my-mongo-express-image localhost:5000/my-mongo-express-image'
					sh 'docker push localhost:5000/my-mongo-express-image'
					sh 'echo "mongo-express Docker image pushed to my-local-registry"'
				}
			}
		}
		stage('Connecting mongo-express frontent with mongo')
		{
			steps {
				script {
					sh 'docker network rm -f mongo-network'
					sh 'docker network create mongo-network'
					sh 'docker run -d -p 27017:27017 -e MONGO_INITDB_ROOT_USERNAME=ati -e MONGO_INITDB_ROOT_PASSWORD=ati13579 --name my-mongo-image --net mongo-network my-mongo-image'
					sh 'docker run -d -p 8081:8081 -e ME_CONFIG_MONGODB_ADMINUSERNAME=ati -e ME_CONFIG_MONGODB_ADMINPASSWORD=ati13579 -e ME_CONFIG_MONGODB_SERVER=my-mongo-image --name my-mongo-express-image --net mongo-network my-mongo-express-image'
				}
			}
		}
	}
}
