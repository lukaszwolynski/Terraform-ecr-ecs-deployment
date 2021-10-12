import os
import re

os.system("terraform init")
os.system("terraform apply -auto-approve")
repository_link = os.popen("terraform output repository_url").read()
repository_link = re.search('"(.*)"', repository_link)
repository_link = repository_link.group(1)

os.chdir('app')
os.system("aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin {}".format(repository_link))
os.system("docker build -f Dockerfile -t lwolynski-repository .")
os.system("docker tag lwolynski-repository:latest {}:latest".format(repository_link))
os.system("docker push {}:latest".format(repository_link))

os.chdir('../rest')
os.system("terraform init")
os.system('terraform apply -var imageRepository="{}:latest" -auto-approve'.format(repository_link))
