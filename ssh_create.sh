echo 'Email address:'
read email
ssh-keygen -t rsa -b 4096 -C $email
pbcopy < ~/.ssh/id_rsa.pub
