pipeline {
    agent any

    environment {
        REMOTE_USER = 'user'
        REMOTE_IP = 'IP'
        REMOTE_SSH = 'SSH'
        REMOTE_WORKDIR = 'dir_name'
    }
    stages {
        stage('Terraform Init') {
            steps {
                sshagent([env.REMOTE_SSH]) {
                    sh """
                        ssh ${env.REMOTE_USER}@${env.REMOTE_IP} '
                        cd ${env.REMOTE_WORKDIR}
                        terraform init'
                    """
                }
            }
        }
        stage('Terraform Plan') {
            steps {
                sshagent([env.REMOTE_SSH]) {
                    sh """
                        ssh ${env.REMOTE_USER}@${env.REMOTE_IP} '
                        cd ${env.REMOTE_WORKDIR}
                        terraform plan'
                    """
                }
            }
        }
        stage('Terraform Apply') {
            steps {
                sshagent([env.REMOTE_SSH]) {
                    sh """
                        ssh ${env.REMOTE_USER}@${env.REMOTE_IP} '
                        cd ${env.REMOTE_WORKDIR}
                        terraform apply -auto-approve'
                    """
                }
            }
        }
        stage('Ansible aktualizacja systemu, instalacja pakietów') {
            steps {
                sshagent([env.REMOTE_SSH]) {
                    sh """
                        ssh ${env.REMOTE_USER}@${env.REMOTE_IP} '
                        cd ${env.REMOTE_WORKDIR}
                        terraform output -json > ../ansible/terraform_outputs.json
                        cd ../ansible
                        ansible-playbook playbook.yml
                        ansible-playbook playbook2.yml
                    """
                }
            }
        }
    }
    post {
        always {
            echo 'Zimbra zainstalowana'
        }
    }
}

