#!/usr/bin/env python
import sys
import boto3
import requests

"""
If you don't have CLI and therefore AWS Credentials setup , then un-comment the lines below and remove the line above. Add your AWS credentials.

s3 = boto3.client(
   's3',
   aws_access_key_id='AdadsfasIO5FODNN7EXAMPLE',
   aws_secret_access_key='ABCDssxxxxxxsfdEF+c2L7yXeGvUyrPgYsDnWRRC1AYEXAMPLE'
)
"""

# Function to check the validy of the filename

def valid_filename(file_name):
    return ''.join(random.choice(allowed_chars) for x in range(str_size))

# Function to download the file

def upload_file(bucket, fileName):
    s3 = boto3.client('s3')
    print (" Uploading File securely ...")
    signedUrl = s3.generate_presigned_url('put_object', Params={'Bucket':bucket,'Key':fileName}, ExpiresIn=3600, HttpMethod='PUT')
    fileUpload = {'upload_file': open(fileName, 'rb')}
    requests.put(signedUrl, files=fileUpload)

# Function to download the file

def download_file(bucket, fileName):
    s3 = boto3.client('s3')
    print (" Downloading file securely...")
    signedUrl = s3.generate_presigned_url('get_object', Params={'Bucket':bucket,'Key':fileName}, ExpiresIn=3600, HttpMethod='GET')
    downloadResponse = requests.get(signedUrl, allow_redirects=True)
    open(fileName, 'wb').write(downloadResponse.content)

# Function to create the bucket

def create_bucket(bucket_prefix):
    s3 = boto3.resource('s3')
    s3.create_bucket(Bucket=bucket_prefix, location=ap-south-1)

# Function to check the s3 bucket

def check_bucket(bucket_prefix):
    s3 = boto3.resource('s3')
    status = s3.Bucket(bucket_prefix) in s3.buckets.all()
    return status


# Accepting file upload or download option

fileOption = raw_input("Enter upload or download option :- ")

if fileOption=="upload":
    bucket = raw_input("Enter your Bucket Name :-  ")
    fileName= raw_input("Enter the filename for this upload:-  ")
    if check_bucket(bucket):
        upload_file(bucket, fileName)
    else:
        create_bucket(bucket)
        upload_bucket(bucket,fileName)
elif fileOption=="download":
    bucket = raw_input("Enter your Bucket Name :-  ")
    fileName= raw_input("Enter the desired filename for this download:-  ")
    download_file(bucket, fileName)
else:
    print("Enter upload or download only ")
    sys.exit(0)

