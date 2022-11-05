# ITMD536

The current configuration dependency requires you to create two AWS CLI profiles, default and application.

| AWS Profile Name | Account             |
| ---------------- | ------------------- |
| default          | DevOps Account      |
| application      | Application Account |



The AWS CLI profile is configured as follows.

This is for DevOps Account :   Please use own account AK/SK

```shell
$ aws configure 
AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE 
AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY 
Default region name [None]: ap-southeast-1 
Default output format [None]: json
```

This is for Application Account :  Please use own account AK/SK

```shell
$ aws configure --profile application
AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE 
AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY 
Default region name [None]: ap-southeast-1 
Default output format [None]: json
```

