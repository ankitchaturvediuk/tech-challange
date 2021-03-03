########### SHOW zone  
zone=`curl -s http://metadata.google.internal/computeMetadata/v1/instance/zone -H "Metadata-Flavor: Google"`
printf "printing GCP Zone \n"
echo $zone

####### SHOW service account using variable
service_account=`curl -s http://metadata.google.internal/computeMetadata/v1/instance/?recursive=true -H "Metadata-Flavor: Google" | jq '.serviceAccounts'`
printf " \n \nprinting GCP service account attached\n"
echo $service_account | jq