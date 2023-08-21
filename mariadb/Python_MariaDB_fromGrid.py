# Purpose: Demonstrate how to connect to and interact with
#          the MariaDB database on the compute grid.
# Authors: Ista Zahn
# Updated: March 25th 2020

# Load libraries of interest (install if needed)
import sqlalchemy as db
import os
import pandas as pd

####################################################################
# Connect to a database using connection info specified in .my.cnf #
####################################################################

# Specify the location of your .my.cnf file.
# See https://grid.rcs.hbs.org/db-configuration-files for details.
myfile = os.path.expanduser("~/.my.cnf")  # "~/" means "Home directory"

# Specify the mysql group to use. For example, "mysql" corresponds
# to the '[mysql]' group in .my.cnf
mygroup = 'mysql'

engine = db.create_engine(
    'mysql+pymysql://',
    connect_args={'read_default_file': myfile,
                  'read_default_group': mygroup
                  #  , database = "" # specify database here if not in my.cnf
                  })

# As an alternative to putting connection information in a .my.cnf file
# you can hard code your connection information.
# engine = db.create_engine('mysql+pymysql://user:password@host/dbname'))

# See https://docs.sqlalchemy.org/en/13/core/engines.html
# for database connection details and
# https://pymysql.readthedocs.io/en/latest/modules/connections.html
# for arguments you can pass via `connect_args`.


######################################################
# List tables, read and write data using DBI package #
######################################################

# List available databases and tables.
dbnames = engine.execute('SHOW DATABASES').fetchall()
print(dbnames)
engine.execute('SHOW TABLES').fetchall()

# Write data to table 
df = pd.read_csv("datasets/mtcars.csv")
# (commented for safety, will create table in connected database)
# df.to_sql('sample_mtcars_table2', con = engine)

# List fields in a table.
engine.execute('DESCRIBE sample_mtcars_table2').fetchall()

# Read an entire table.
df1 = pd.read_sql_table('sample_mtcars_table', engine)
all(df1 == df)

# Read arbitrary SQL queries
df2 = pd.read_sql_query('SELECT * FROM sample_mtcars_table WHERE am = 1 LIMIT 5',
                        engine)

# Much more complex database interaction is possible using SQLAlchemy.
# See https://www.sqlalchemy.org for details.
