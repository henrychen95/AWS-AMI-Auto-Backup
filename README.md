AWS-AMI-Auto-Backup
===================

Shell Script to auto make AMI backup and delete old backups.

Pre-request
-----------
1. You need install AWS tools at your system.<br />You can use yum install aws* to install all require packages.<br />And please make sure your AWS tools install path is same with this script path.<br />
2. Please use "env | grep EC2_HOME" to find out your system's setting.<br />
3. Please use "env | grep JAVA_HOME" to find out your system's setting.<br />
4. Please add IAM role with appropriate permissions and launch instance with this IAM Role.<br />If you are not familiar with IAM Role, you can create a admin IAM Role for quick use.

Shell Scripts vairables
------------------

1. region: Reference http://docs.aws.amazon.com/general/latest/gr/rande.html<br />
2. instanceID: You can find your instance ID at AWS Manage Console<br />
3. amiNamePrefix: Your prefer AMI name prefix<br />
4. amiDescription: Your prefer AMI description<br />
5. routine: If you want to keep 7 days AMI backups, please set this variable true otherwise set it false.<br />

About routine
-------------
1. If you set routine false, this script will delete all your exist AMIs and Snapshots.<br />
2. If you set routine true, AMI name will be $amiNamePrefix+$weekday.<br />for example, if you set $amiNamePrefix as "My AMI Backup " and set routine true.<br />then your AMI name will be "My AMI Backup Mon" (without quotation marks).

None Amazon Linux
-----------------
If you use none Amazon Linux, please visit: https://github.com/henrychen95/AWS-AMI-Auto-Backup-None-Amazon-Linux
