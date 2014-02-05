mysql-version-control
=====================

A Simple bash shell script to keep a series of migration logs for all changes made to a MySQL database schema

This script requires the Perl based mysqldiff tool in order to work properly.

mysqldiff
---------
http://search.cpan.org/dist/MySQL-Diff/bin/mysqldiff


Usage
-----

Place the script in a directory off your project root (e.g. mysql_version) and configure the database access variables at the top of the script.

Have your build tool (or manually) call the script before each commit.

The script will create two sub-directories.

./logs which will hold a history of all mysql schema dumps

./migrations which will hold a numbered series of schema updates required to move the database through each set of changes.

Running the script when no changes have been made to the database schema will result in no log or migration files being generated.



