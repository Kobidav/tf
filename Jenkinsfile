pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'
    }

    stages {
        // stage('Checkout') {
        //     steps {
        //         git url: 'https://github.com/Kobidav/tf.git', branch: 'main'
        //     }
        // }

        stage('Terraform Init') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws'
                ]]) {
                    sh '''
                        export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
                        export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
                        terraform init
                    '''
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws'
                ]]) {
                    sh '''
                        export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
                        export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
                        terraform apply -auto-approve
                    '''
                }
            }
            sh '''
                echo "Terraform apply completed successfully."
            '''  
            sh '''
                echo "or not."
            '''   
            sh '''
                echo "who knows"
            '''        
        }
    }
}
