import os
import re

os.system("terraform init")
os.system("terraform destroy -auto-approve")
os.chdir('rest')
os.system("terraform init")
os.system('terraform destroy -auto-approve')
