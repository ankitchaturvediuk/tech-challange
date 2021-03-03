#!/bin/bash
#### convert yml file to text
mv kube-deployment-updated-images.yml kube-deployment-updated-images.txt
#### Assign the filename
filename="kube-deployment-updated-images.txt"

#### Take the replace string
read -p "Enter the replace string: " replace

#### replace the strings in file
if [[ tech-challange-305619 != "" && $replace != "" ]]; then
sed -i "s/tech-challange-305619/$replace/" $filename
fi

#### convert updated txt file to yml
mv kube-deployment-updated-images.txt kube-deployment-updated-images.yml
