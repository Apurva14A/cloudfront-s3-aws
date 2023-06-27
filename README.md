# Deploy a static website on AWS

The cloud is perfect for hosting **static websites** that only include **HTML, CSS, and JavaScript files** that **require no server-side processing**. In this project, you will deploy a static website to AWS. First, you will **create an S3 bucket, configure the bucket for website hosting, and secure it using IAM policies**. Next, you will **upload the website files to your bucket and speed up content delivery using AWS’s content distribution network service, CloudFront**. Lastly, you will **access** your **website** in a browser **using** the **unique S3 endpoint**.


 ## Architecture Diagram for static website hosting on AWS (using the following services - S3, CDN, Route 53)

![images](https://github.com/Apurva14A/static-website-aws-S3/blob/8a5f32736ecbd1052f977fbed9a46c8ab9f89e93/images/static-website-aws-S3-architecture.png)


## Steps to create S3 bucket using AWS console:
  - Search for S3 services in AWS serach bar click on "S3" Look below screenshot

 ![images](https://github.com/Apurva14A/static-website-aws-S3/blob/8a5f32736ecbd1052f977fbed9a46c8ab9f89e93/images/aws-s3-1.png)


  - It will open up S3 console like this:

   ![images](https://github.com/Apurva14A/static-website-aws-S3/blob/8a5f32736ecbd1052f977fbed9a46c8ab9f89e93/images/aws-s3.png)


  - Now, select on "Create bucket" on the console, it will open up new window like below:

     ![images](https://github.com/Apurva14A/static-website-aws-S3/blob/8a5f32736ecbd1052f977fbed9a46c8ab9f89e93/images/aws-s3--2.png)

    Here fill out the below list out required details to host a static webiste :

     - Bucket Name
     - Uncheck "Block Public Access for this bucket"
     - Check " I acknowlegde ........"
     - Then, select create button at last

     New window will open like this:

      ![images](https://github.com/Apurva14A/static-website-aws-S3/blob/8a5f32736ecbd1052f977fbed9a46c8ab9f89e93/images/aws-s3-3.png)

  - After, bucket gets created then go to "properties" inside that go to "Static website hosting" and change the settings to "enable" and mention the index.html file there.

    ![images](images\aws-s3-5.png)

  - Now, Go to Permissions and edit the bucket policy then copy and paste the below bucket policy.

   ![images](images\aws-s3-6.png)
   

 - Now, create CDN endpoint by going to Cloudfront console. Click on Create a Cloudfront distribution

   ![images](images\aws-s3-7.png)


  - And then fill out the values such as :
   - origin 
   - choose Redirect http to https
   - choose no WAF
   - then click on create distribution

  ![images](images\aws-s3-8.png)


  - wait for 4-5 min to be get the endpoint created. You will see below message.

  ![images](images\cdn-1.png)

  - After endpoint gets created go to browser and open the endpoint. It will open your hosted website.

   -Put /index.html  at last to access your website
