import psycopg2
import os
import csv
query = '''
    SELECT 
        Year, 
        Reg_name,
        avg(Ball100)
    from migration.exam_results
    JOIN migration.Exam_person
        ON Exam_results.Person_id=Exam_person.Person_id
    JOIN migration.Region
        ON Region.Region_id=Exam_person.Reg_id
    WHERE migration.Exam_results.Test_status='Зараховано' AND migration.Exam_results.Test_type='Історія України'
    GROUP BY migration.Exam_results.Year, migration.Region.Reg_Name
'''
connection = {
        "database": "postgres",
        "user": "postgres",
        "password": "postgres",
        "host": "localhost",
        "port": 5432,
    }
conn = psycopg2.connect(**connection)
cursor = conn.cursor()
cursor.execute(query)
try:
	os.remove("temporary.csv")
except OSError:
	pass
with open('Results.csv','w',encoding="utf-8") as res:
			csv_writer = csv.writer(res, lineterminator='\n')
			csv_writer.writerow(['Область', 'Рік', 'Середній бал з Історії України'])
			for row in cursor:
				csv_writer.writerow(row)