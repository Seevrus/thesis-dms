# Thesis-DMS

Thesis-DMS 

## Installation

Thesis-DMS has three components:  
1. Database: the db-backup/dms_demo.sql file contains the necessary tables and some mock data.
2. Back-end: api_utils, auth_utils, public/api, and vendor folders.
3. Front-end: fe_src

Place the whole application inside a fully fledged Apache-PHP-MySQL server (not necessarily under the root). Then, modify the document table markup in dms_demo.sql and amend the absolute paths of the mock documents accordingly (if you intend to use them).  
Modify the proxy in webpack.dev.js in order for the Front-end application to be able to reach the Back-end part properly.
Create a *db.ini* file in the root folder containing the credentials to access your database:

```ini
[db_credentials]
host = localhost
db = dms_demo
user = <Your user>
password = <Your password>
charset = utf8mb4
```

Create an email.ini file to be able to send emails to the users:

```ini
[email_credentials]
from_email = <sender address>
from_name = <sender name>
username = <smtp user>
password = <smtp password>
```
Feel free to edit emailer.php to configure the additional properties of the mailer as well.

Install the dependencies of the project:

```bash
composer install
npm install
```

## Usage

```bash
npm run start
```

## License
[CC BY-NC-ND 4.0](https://creativecommons.org/licenses/by-nc-nd/4.0/)
