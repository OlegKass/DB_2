import psycopg2
import csv
import os
import re

def create(connection):
    query = '''
            CREATE TABLE zno(
                        OUTID VARCHAR(36) NOT NULL,
                        Birth INT2 NOT NULL,
                        SEXTYPENAME VARCHAR(15) NOT NULL,
                        REGNAME VARCHAR(50) NOT NULL,
                        AREANAME VARCHAR(50) NOT NULL,
                        TERNAME VARCHAR(50) NOT NULL,
                        REGTYPENAME VARCHAR(100) NOT NULL,
                        TerTypeName VARCHAR(40) NOT NULL,
                        ClassProfileNAME VARCHAR(50),
                        ClassLangName VARCHAR(20),
                        EONAME TEXT,
                        EOTYPENAME VARCHAR(80),
                        EORegName VARCHAR(50),
                        EOAreaName VARCHAR(50),
                        EOTerName VARCHAR(50),
                        EOParent TEXT,
                        UkrTest VARCHAR(40),
                        UkrTestStatus VARCHAR(30),
                        UkrBall100 NUMERIC(10, 2),
                        UkrBall12 INT2,
                        UkrBall INT2,
                        UkrAdaptScale INT2,
                        UkrPTName TEXT,
                        UkrPTRegName VARCHAR(50),
                        UkrPTAreaName VARCHAR(50),
                        UkrPTTerName VARCHAR(50),
                        histTest VARCHAR(30),
                        HistLang VARCHAR(20),
                        histTestStatus VARCHAR(30),
                        histBall100 NUMERIC(10, 2),
                        histBall12 INT2,
                        histBall INT2,
                        histPTName TEXT,
                        histPTRegName VARCHAR(80),
                        histPTAreaName VARCHAR(50),
                        histPTTerName VARCHAR(50),
                        mathTest VARCHAR(40),
                        mathLang VARCHAR(20),
                        mathTestStatus VARCHAR(30),
                        mathBall100 NUMERIC(10, 2),
                        mathBall12 INT2,
                        mathBall INT2,
                        mathPTName TEXT,
                        mathPTRegName VARCHAR(50),
                        mathPTAreaName VARCHAR(50),
                        mathPTTerName VARCHAR(50),
                        physTest VARCHAR(40),
                        physLang VARCHAR(20),
                        physTestStatus VARCHAR(30),
                        physBall100 NUMERIC(10, 2),
                        physBall12 INT2,
                        physBall INT2,
                        physPTName TEXT,
                        physPTRegName VARCHAR(50),
                        physPTAreaName VARCHAR(50),
                        physPTTerName VARCHAR(50),
                        chemTest VARCHAR(40),
                        chemLang VARCHAR(20),
                        chemTestStatus VARCHAR(30),
                        chemBall100 NUMERIC(10, 2),
                        chemBall12 INT2,
                        chemBall INT2,
                        chemPTName TEXT,
                        chemPTRegName VARCHAR(50),
                        chemPTAreaName VARCHAR(50),
                        chemPTTerName VARCHAR(50),
                        bioTest VARCHAR(40),
                        bioLang VARCHAR(20),
                        bioTestStatus VARCHAR(30),
                        bioBall100 NUMERIC(10, 2),
                        bioBall12 INT2,
                        bioBall INT2,
                        bioPTName TEXT,
                        bioPTRegName VARCHAR(50),
                        bioPTAreaName VARCHAR(50),
                        bioPTTerName VARCHAR(50),
                        geoTest VARCHAR(40),
                        geoLang VARCHAR(20),
                        geoTestStatus VARCHAR(30),
                        geoBall100 NUMERIC(10, 2),
                        geoBall12 INT2,
                        geoBall INT2,
                        geoPTName TEXT,
                        geoPTRegName VARCHAR(50),
                        geoPTAreaName VARCHAR(50),
                        geoPTTerName VARCHAR(50),
                        engTest VARCHAR(40),
                        engTestStatus VARCHAR(30),
                        engBall100 NUMERIC(10, 2),
                        engBall12 INT2,
                        engDPALevel VARCHAR(30),
                        engBall INT2,
                        engPTName TEXT,
                        engPTRegName VARCHAR(50),
                        engPTAreaName VARCHAR(50),
                        engPTTerName VARCHAR(50),
                        fraTest VARCHAR(40),
                        fraTestStatus VARCHAR(30),
                        fraBall100 NUMERIC(10, 2),
                        fraBall12 INT2,
                        fraDPALevel VARCHAR(30),
                        fraBall INT2,
                        fraPTName TEXT,
                        fraPTRegName VARCHAR(50),
                        fraPTAreaName VARCHAR(50),
                        fraPTTerName VARCHAR(50),
                        deuTest VARCHAR(40),
                        deuTestStatus VARCHAR(30),
                        deuBall100 NUMERIC(10, 2),
                        deuBall12 INT2,
                        deuDPALevel VARCHAR(30),
                        deuBall INT2,
                        deuPTName TEXT,
                        deuPTRegName VARCHAR(50),
                        deuPTAreaName VARCHAR(50),
                        deuPTTerName VARCHAR(50),
                        spaTest VARCHAR(40),
                        spaTestStatus VARCHAR(30),
                        spaBall100 NUMERIC(10, 2),
                        spaBall12 INT2,
                        spaDPALevel VARCHAR(30),
                        spaBall INT2,
                        spaPTName TEXT,
                        spaPTRegName VARCHAR(50),
                        spaPTAreaName VARCHAR(50),
                        spaPTTerName VARCHAR(50),
                        ZNOYear INT2
            )'''
    conn = psycopg2.connect(**connection)
    cursor = conn.cursor()
    cursor.execute("DROP TABLE IF EXISTS zno")

    cursor.execute(query)
    cursor.close()
    conn.commit()

def populate(file, connection):
    conn = psycopg2.connect(**connection)
    cursor = conn.cursor()
    try:
        os.remove('temporary.csv')
    except OSError:
        pass

    with open(file, 'r', encoding='windows-1251') as data:
        csv_reader = csv.reader(data, delimiter=';', quoting=csv.QUOTE_ALL)
        year = re.findall(r'Odata(\d{4})File.csv', file)

        next(csv_reader)
        count = 0

        with open("temporary.csv", "w+") as buf:
            buf.seek(0, 0)
            buf.truncate(0)
            for line in csv_reader:
                for i in range(len(line)):
                    if re.match('^\\d+,\\d+$', line[i]):
                        line[i] = line[i].replace(',', '.')

                line = ';'.join(line)
                line = line + ';' + year[0] + '\n'

                buf.write(line)
                count += 1
                if count == 100:
                    buf.seek(0, 0)
                    cursor.copy_from(buf, 'zno', sep=';', null='null')
                    conn.commit()
                    buf.seek(0, 0)
                    buf.truncate(0)
                    count = 0


            if count > 0:
                buf.seek(0, 0)
                cursor.copy_from(buf, 'zno', sep=';', null='null')
                conn.commit()


if __name__ == '__main__':
    connection = {
        "database": "postgres",
        "user": "postgres",
        "password": "postgres",
        "host": "localhost",
        "port": 5432,
    }
    create(connection)
    populate("Odata2019File.csv", connection)
    populate("Odata2020File.csv", connection)