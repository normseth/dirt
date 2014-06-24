#!/bin/bash -x

# setup proxy for curl and the like
cat > /etc/profile.d/outboundproxy.sh << "EOF"
# Sangria proxy setting through Chef
export http_foo="http://proxy.sangria-dev.a.intuit.com:8080"
export https_foo="https://proxy.sangria-dev.a.intuit.com:8080"
export no_foo="localhost,127.0.0.1,169.254.169.254"

EOF
chmod 644 /etc/profile.d/outboundproxy.sh

# setup proxy for wget
cat >> /etc/wgetrc << "EOF2"
# Sangria proxy setting through Chef
http_foo=http://proxy.sangria-dev.a.intuit.com:8080
https_foo=https://proxy.sangria-dev.a.intuit.com:8080
EOF2

# Disable requiretty is needed for rsync with RHEL-family AMIs
echo 'Defaults:ec2-user !requiretty' > /etc/sudoers.d/999-vagrant-cloud-init-requiretty && chmod 440 /etc/sudoers.d/999-vagrant-cloud-init-requiretty
#(bash -i -c curl -L https://www.opscode.com/chef/install.sh | bash)
bash --login -c "curl -L https://www.opscode.com/chef/install.sh > /tmp/chef-install.sh && chmod 755 /tmp/chef-install.sh && /tmp/chef-install.sh"
#bash --login /tmp/chef-install.sh



# Don't work
#env > /tmp/env_simple.out
#(env > /tmp/env_parens.out)

# Does work
bash --login -c "env > /tmp/env_bash.out"

# Not needed if not on Intuit AMI
# force provisioning path to be world-writable
#mkdir -p /tmp/chef/provisioning/chef-solo-1/cookbooks
#chmod ugo+rwx -R /tmp/chef
