# Environment variables used by the application

There are several environment variables the application expects to be present
to function. These are listed in `.env.development.example` and `.env.test.example` and described
below.

- DATABASE_URL – The URL where the application database exists
- AWS_ACCESS_KEY_ID/AWS_SECRET_ACCESS_KEY/AWS_S3_REGION/AWS_S3_BUCKET – The
AWS credentials for accessing various AWS services, including S3 and CloudWatch
- API_ROOT – the url to the API application
- GOOGLE_TAG_MANAGER_ID – the Google Tag manager ID to use with the app, also drives Google Analytics
- SECRET_KEY_BASE – Rails encryption key, generate with `rake secret`
- AUTH0_JWT_PUBLIC_KEY - used to validate the signed JWT token, to ensure it
hasn't been tampered with


