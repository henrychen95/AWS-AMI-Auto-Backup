AWS-AMI-Auto-Backup
===================

Shell Script to auto make AMI backup and delete old backups.

Pre-request
You need install AWS tools at your system.

Scripts vairables
1. region: Reference http://docs.aws.amazon.com/general/latest/gr/rande.html
2. instanceID: You can find your instance ID at AWS Manage Console
3. amiNamePrefix: Your prefer AMI name prefix
4. amiDescription: Your prefer AMI description
5. routine: If you want to keep 7 days AMI backups, please set this variable true otherwise set it false.

** If you set routine false, this script will delete all your exist AMIs and Snapshots.
** If you set routine true, AMI name will be $amiNamePrefix+Mon $amiNamePrefix+Tue,etc.
