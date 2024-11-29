# Solution

To start, read through the [README](README.md) in its entirety as it has a ton
of helpful information.

Starting off, the first thing to notice is that the website uses JSON Web
Tokens for authentication. More Details on how JWT works
[here](https://jwt.io/introduction).

An important detail of JWT is that auth tokens are cached entirely on the
client side in your browser's local storage, and automatically inserted into
every http request. This means that our goal will be to find an elevated JWT.

In order to generate our own JWT, we will need the secret key which the website
uses to validate hashes. A quick search in the `security/` folder exposes the
file [JWTService.java](src/main/java/io/github/nandandesai/pico/security/JwtService.java),and following the trail to [SecretGenerator.java](src/main/java/io/github/nandandesai/pico/security/SecretGenerator.java)
reveals that if the secret key file does not exist (which we can presume that
it doesn't), then the file will be created with a secret_key of "1234".

First, let's get our own JWT, which we will modify. To do this, we will login
with the credentials provided by the prompt. From now on, any http request we
make will be authenticated with the token, and it can be found in our Local
Storage under the key `auth-token`, alongside the base-64 decoded payload under
the key `token-payload`.


This is my user JWT and base-64 decoded payload.
```
eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiRnJlZSIsImlzcyI6ImJvb2tzaGVsZiIsImV4cCI6MTczMzQ1NjU2NiwiaWF0IjoxNzMyODUxNzY2LCJ1c2VySWQiOjEsImVtYWlsIjoidXNlciJ9.gLogwQ-24uPDQyl6GBIhiMprFzybaJn3KyGAdT_yCrI
{"role":"Free","iss":"bookshelf","exp":1733456566,"iat":1732851766,"userId":1,"email":"user"}
```

I found a very helpful [JWT Debugger](https://jwt.io/#debugger-io)/editor, which we will be using to modify 
our token directly. The relevant fields we need to edit are:
* role
* userid
* email

For the role, [data.sql](src/main/resources/data.sql) tells us the name of each of the Roles in the SQL table.

For the userid, [Role.java](src/main/java/io/github/nandandesai/pico/models/Role.java) tells us that a higher number is better, and 
combined with data.sql gives us an associated userid.

For the email, [BookShelfConfig.java](src/main/java/io/github/nandandesai/pico/configs/BookShelfConfig.java) gives the email of the initial users.

After editing the payload, regenerating the hash with the secret key, and
storing the new Token in local storage, all that's left is to reload the page
and access the flag.
