# URL Shortener
Keep your tweets short and simple with URL Shortener.

## Installation

1. Install Ruby 2.3.3.
2. Install Ruby on Rails 5.1.5.
3. Install node 8.9.1.
4. Install yarn.
5. Install PostgreSQL locally.
6. Create an .env file in the project root folder. Define the local database username and password:
	```
	URL_SHORTENER_LOCAL_DATABASE_USERNAME
	URL_SHORTENER_LOCAL_DATABASE_PASSWORD
	```
7. Run `bundle install`
8. Create database and run migrations.
9. Run tests and rubocop code analysis using `rails urlShortener:test`
10. Code coverage information is available on `coverage/index.html`
11. Optional: Install the gem `foreman` to run webpack development server alongside with rails server.
11. Run server using `foreman start -f Procfile.dev -p 3000` or `rails s`
12. Enjoy!

## Contact
In case of issues please contact:

**José Hernández González**
*Full-Stack Developer*
gjhernandez@uninorte.edu.co
