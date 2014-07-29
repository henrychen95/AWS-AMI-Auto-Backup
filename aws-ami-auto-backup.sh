#!/bin/bash
PATH=/sbin:/bin:/usr/sbin:/usr/bin:/opt/aws/bin

# Please use env | grep EC2_HOME to find out your system's setting
EC2_HOME=/opt/aws/apitools/ec2

# Please use env | grep JAVA_HOME to find out your system's setting
JAVA_HOME=/usr/lib/jvm/jre

export EC2_HOME JAVA_HOME

# Regions reference: http://docs.aws.amazon.com/general/latest/gr/rande.html
region="ap-northeast-1"

# You can find your instance ID at AWS Manage Console
instanceID="YOUR-INSTANCE-ID"

# Your prefer AMI Name prefix
amiNamePrefix="AMI_"

# Your prefer AMI Description
amiDescription="Daily AMI backup"

# If you want to keep 7 days AMI backups, please set routine true otherwise set it false
routine=true

# Variable for routine is true
weekday=$(date +%a)

if [ $routine = true ]; then
    # Setup AMI Name
    amiName=$amiNamePrefix$weekday

    # Get AMI ID
    amiIDs=$(ec2-describe-images --region $region | grep 'ami-[a-z0-9]' | grep "$amiName" |cut -f 2)

    # Get Snapshot ID
    if [[ ! -z $amiIDs ]]; then
        snapshotIDs=$(ec2-describe-snapshots --region $region | grep $amiIDs | cut -f 2)
    fi
else
    # Setup AMI Name
    amiName=$amiNamePrefix

    # Get AMI ID
    amiIDs=$(ec2-describe-images --region $region | grep 'ami-[a-z0-9]' | cut -f 2)

    # Get Snapshot ID
    if [[ ! -z $amiIDs ]]; then
        snapshotIDs=$(ec2-describe-snapshots --region $region | cut -f 2)
    fi
fi

if [[ ! -z $amiIDs ]]; then
    # Deregister AMI
    for amiID in $amiIDs
    do
        ec2-deregister --region $region $amiID
    done

    # Delete snapshot
    for snapshotID in $snapshotIDs
    do
        ec2-delete-snapshot --region $region $snapshotID
    done
fi

# Create AMI
ec2-create-image $instanceID --region $region --name "$amiName" -d "$amiDescription" --no-reboot
