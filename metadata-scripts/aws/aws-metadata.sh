########## SHOW zone
zone=`curl -s 169.254.169.254/latest/meta-data/placement/availability-zone`
printf "printing AWS zone\n"
echo $zone

########## SHOW instance ID
instance_id=`curl -s 169.254.169.254/latest/meta-data/instance-id`
printf "\nprinting AWS instance ID\n"
echo $instance_id
