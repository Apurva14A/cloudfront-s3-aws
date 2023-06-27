# Deploy a static website on AWS

The cloud is perfect for hosting **static websites** that only include **HTML, CSS, and JavaScript files** that **require no server-side processing**. In this project, you will deploy a static website to AWS. First, you will **create an S3 bucket, configure the bucket for website hosting, and secure it using IAM policies**. Next, you will **upload the website files to your bucket and speed up content delivery using AWS’s content distribution network service, CloudFront**. Lastly, you will **access** your **website** in a browser **using** the **unique S3 endpoint**.


 ## Architecture Diagram for static website hosting on AWS (using the following services - S3, CDN, Route 53)

![images](images\static-website-aws-S3-architecture.png)


## Steps to create S3 bucket using AWS console:
  - Search for S3 services in AWS serach bar click on "S3" Look below screenshot

 ![images](images\aws-s3-1.png)


  - It will open up S3 console like this:

   ![images](images\aws-s3.png)


  - Now, select on "Create bucket" on the console, it will open up new window like below:

     ![images](images\aws-s3--2.png)

    Here fill out the below list out required details to host a static webiste :

     - Bucket Name
     - Uncheck "Block Public Access for this bucket"
     - Check " I acknowlegde ........"
     - Then, select create button at last

     New window will open like this:

      ![images](images\aws-s3-3.png)