# technical-test-bibit

1. this is simple architecture for that study case

![alt text](https://user-images.githubusercontent.com/68263390/207772835-f56e24f8-6bf2-406d-82b8-83edb56baa58.png)


2. Question No 2.

    A. tech stack are required by me for rest api there are
      - operating system and programming languages (apps) 
      - nginx (web server)
      - redis (data storage and caching)
      - Databases (data storage and querying)
      - server load balancing (load balancer)
      - monitoring and performance tools (analytics)
      
    B. setup database replication 
      - Establish performance baselines and tune replication if necessary
      - develop and test a backup and restore strategy
      - create threshold and alerts 
      - monitor the replication topology 
      - don’t forget to update database version and always backup before updating
      
    C. network subnet design 
      - in diagram we can see, we use private subnet, for security, and server can't access from outside, but the problem is we can't access too, how to solve it? maybe we can provide vpn for to access it, we can use openvpn or pritunl
      
    D. security groups beetween groupings
      - I already provide it in terraform, and will implement it to our autoscalling group 

3. I already put sample code for terraform, just to create and setup autoscalling group, target group, and alb (application load balancer) on aws
   check on folder terraform-test https://github.com/afsanarozan/technical-test-bibit/tree/master/terraform-test 
   
5. Actually I use gitlab-ci.yml just if there is special case on services, I more used to jenkins then gitlab-ci.yml, 
   here my sample gitlab-ci 
   https://github.com/afsanarozan/technical-test-bibit/blob/master/go-test/.gitlab-ci.yml
   and diagram flow design 
   
   ![alt_text](https://user-images.githubusercontent.com/68263390/207793695-b7ba2619-7baf-43ff-a7a6-fdd4f95879f1.png)
   
   Sory, I am not including terraform in cicd, because I think my terraform is'nt best practice implement on cicd, feel free if you have any suggestion.. 

5. Already setup 

6. if we need tools monitoring, we must install and setup on our server tools for scrapping data, such prometheus, fluentd, fluentbit, logstah, etc. 
   to make easily I have some sample diagram, like this : 
   
   ![alt_text](https://user-images.githubusercontent.com/68263390/207795228-425bdccb-c8ca-421b-b2fe-560ccf2a6795.png)
   
   because we implement terraform, we can use user data to provide it into our server, and then server will automaticly install all resources we need into server

   
