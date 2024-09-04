#!/bin/sh -e

BACKUPS_DIR=/etc/backups
AWS_S3_STORAGE_CLASS=INTELLIGENT_TIERING

# Usage function
function usage {
    echo "Usage: $0 [-d DIRECTORY] [-b BUCKET] [-a ACCESS_KEY] [-s SECRET_KEY] [-n BACKUP_NAME] [-r REGION]"
    echo "  -d DIRECTORY      Directory to backup"
    echo "  -b BUCKET         S3 bucket name"
    echo "  -a ACCESS_KEY     AWS access key"
    echo "  -s SECRET_KEY     AWS secret key"
    echo "  -n BACKUP_NAME    Name for the backup file"
    echo "  -r REGION         AWS region"
    exit 1
}

# Check for the correct number of arguments
if [ "$#" -lt 12 ]; then
    usage
fi

# Parse arguments
while getopts "d:b:a:s:n:r:" opt; do
    case $opt in
        d) DIRECTORY_TO_BACKUP=$OPTARG ;;
        b) AWS_S3_BUCKET_NAME=$OPTARG ;;
        a) AWS_ACCESS_KEY_ID=$OPTARG ;;
        s) AWS_SECRET_ACCESS_KEY=$OPTARG ;;
        n) BACKUP_NAME=$OPTARG ;;
        r) AWS_REGION=$OPTARG ;;
        *) usage ;;
    esac
done

# Make sure backups directory exists
mkdir -p $BACKUPS_DIR

# Create a tarball of the directory
tar -czvf "${BACKUPS_DIR}/${BACKUP_NAME}" -C $DIRECTORY_TO_BACKUP .

# Upload the tarball to S3 using curl
curl -v \
    --user "${AWS_ACCESS_KEY_ID}":"${AWS_SECRET_ACCESS_KEY}" \
    --aws-sigv4 "aws:amz:${AWS_REGION}:s3" \
    --upload-file "${BACKUPS_DIR}/${BACKUP_NAME}" \
    -H "x-amz-storage-class: $AWS_S3_STORAGE_CLASS" \
    https://${AWS_S3_BUCKET_NAME}.s3.${AWS_REGION}.amazonaws.com

# Check if the upload was successful
if [ $? -eq 0 ]; then
    echo "Backup was successfully uploaded to S3."
else
    echo "There was an error uploading the backup to S3."
fi