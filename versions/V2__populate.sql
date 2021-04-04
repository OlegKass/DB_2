INSERT INTO Region (Reg_name, Area_Name, Ter_Name, Ter_type_name)
SELECT DISTINCT REGNAME, AREANAME, TERNAME, TerTypeName
FROM zno;


INSERT INTO Region (Reg_name, Area_Name, Ter_Name)
SELECT DISTINCT EORegName, EOAreaName, EOTerName
FROM zno
WHERE EORegName IS NOT NULL AND EOAreaName IS NOT NULL AND EOTerName IS NOT NULL
EXCEPT
SELECT Reg_name, Area_Name, Ter_Name
FROM Region;


INSERT INTO Establishment (School_name, Type, Parent, Reg_id)
SELECT DISTINCT on (zno.EONAME) zno.EONAME, zno.EOTYPENAME, zno.EOParent, Region.Region_id
FROM zno
LEFT JOIN Region
ON zno.EORegName = Region.Reg_name AND zno.AreaName = Region.Area_Name AND zno.EOTerName = Region.Ter_Name
WHERE zno.EONAME IS NOT NULL;


INSERT INTO Establishment (School_name, Reg_id)
SELECT DISTINCT ON (zno.UkrPTName) zno.UkrPTName, Region.Region_id
FROM zno
LEFT JOIN Region
ON zno.UkrPTRegName = Region.Reg_Name AND zno.UkrPTAreaName = Region.Area_Name AND zno.UkrPTTerName = Region.Ter_Name
WHERE zno.UkrPTName NOT IN (
SELECT School_name
FROM Establishment
) AND zno.UkrPTName IS NOT NULL;


INSERT INTO Establishment (School_name, Reg_id)
SELECT DISTINCT ON (zno.histPTName) zno.histPTName, Region.Region_id
FROM zno
LEFT JOIN Region
ON zno.histPTRegName = Region.Reg_Name AND zno.histPTAreaName = Region.Area_Name  AND zno.histPTTerName = Region.Ter_Name
WHERE zno.histPTName NOT IN (
SELECT School_name
FROM Establishment
) AND zno.histPTName IS NOT NULL;

INSERT INTO Establishment (School_name, Reg_id)
SELECT DISTINCT ON (zno.mathPTName) zno.mathPTName, Region.Region_id
FROM zno
LEFT JOIN Region
ON zno.mathPTRegName = Region.Reg_Name AND zno.mathPTAreaName = Region.Area_Name AND zno.mathPTTerName = Region.Ter_Name
WHERE zno.mathPTName NOT IN (
SELECT School_name
FROM Establishment
) AND zno.mathPTName IS NOT NULL;

INSERT INTO Establishment (School_name, Reg_id)
SELECT DISTINCT ON (zno.histPTName) zno.physPTName, Region.Region_id
FROM zno
LEFT JOIN Region
ON zno.physPTRegName = Region.Reg_Name AND zno.physPTAreaName = Region.Area_Name AND zno.physPTTerName = Region.Ter_Name
WHERE zno.physPTName NOT IN (
SELECT School_name
FROM Establishment
) AND zno.physPTName IS NOT NULL;

INSERT INTO Establishment (School_name, Reg_id)
SELECT DISTINCT ON (zno.chemPTName) zno.chemPTName, Region.Region_id
FROM zno
LEFT JOIN Region
ON zno.chemPTRegName = Region.Reg_Name AND zno.chemPTAreaName = Region.Area_Name AND zno.chemPTTerName = Region.Ter_Name
WHERE zno.chemPTName NOT IN (
SELECT School_name
FROM Establishment
) AND zno.chemPTName IS NOT NULL;


INSERT INTO Establishment (School_name, Reg_id)
SELECT DISTINCT ON (zno.bioPTName) zno.bioPTName, Region.Region_id
FROM zno
LEFT JOIN Region
ON zno.bioPTRegName = Region.Reg_Name AND zno.bioPTAreaName = Region.Area_Name AND zno.bioPTTerName = Region.Ter_Name
WHERE zno.bioPTName NOT IN (
SELECT School_name
FROM Establishment
) AND zno.bioPTName IS NOT NULL;


INSERT INTO Establishment (School_name, Reg_id)
SELECT DISTINCT ON (zno.geoPTName) zno.geoPTName, Region.Region_id
FROM zno
LEFT JOIN Region
ON zno.geoPTRegName = Region.Reg_Name AND zno.geoPTAreaName = Region.Area_Name AND zno.geoPTTerName = Region.Ter_Name
WHERE zno.geoPTName NOT IN (
SELECT School_name
FROM Establishment
) AND zno.geoPTName IS NOT NULL;


INSERT INTO Establishment (School_name, Reg_id)
SELECT DISTINCT ON (zno.engPTName) zno.engPTName, Region.Region_id
FROM zno
LEFT JOIN Region
ON zno.engPTRegName = Region.Reg_Name AND zno.engPTAreaName = Region.Area_Name AND zno.engPTTerName = Region.Ter_Name
WHERE zno.engPTName NOT IN (
SELECT School_name
FROM Establishment
) AND zno.engPTName IS NOT NULL;


INSERT INTO Establishment (School_name, Reg_id)
SELECT DISTINCT ON (zno.engPTName) zno.fraPTName, Region.Region_id
FROM zno
LEFT JOIN Region
ON zno.fraPTRegName = Region.Reg_Name AND zno.fraPTAreaName = Region.Area_Name AND zno.fraPTTerName = Region.Ter_Name
WHERE zno.fraPTName NOT IN (
SELECT School_name
FROM Establishment
) AND zno.fraPTName IS NOT NULL;

INSERT INTO Establishment (School_name, Reg_id)
SELECT DISTINCT ON (zno.deuPTName) zno.deuPTName, Region.Region_id
FROM zno
LEFT JOIN Region
ON zno.deuPTRegName = Region.Reg_Name AND zno.deuPTAreaName = Region.Area_Name AND zno.deuPTTerName = Region.Ter_Name
WHERE zno.deuPTName NOT IN (
SELECT School_name
FROM Establishment
) AND zno.deuPTName IS NOT NULL;


INSERT INTO Establishment (School_name, Reg_id)
SELECT DISTINCT ON (zno.spaPTName) zno.spaPTName, Region.Region_id
FROM zno
LEFT JOIN Region
ON zno.spaPTRegName = Region.Reg_Name AND zno.spaPTAreaName = Region.Area_Name AND zno.spaPTTerName = Region.Ter_Name
WHERE zno.spaPTName NOT IN (
SELECT School_name
FROM Establishment
) AND zno.spaPTName IS NOT NULL;




INSERT INTO Exam_person (Person_id, Birth, Reg_id, Reg_type, Class_name, School_name)
SELECT zno.OUTID, zno.Birth, Region.Region_id, zno.REGTYPENAME, zno.ClassProfileNAME, Establishment.School_name
FROM zno
LEFT JOIN Region
ON zno.REGNAME = Region.Reg_Name AND zno.AREANAME = Region.Area_Name AND zno.TERNAME = Region.Ter_Name
LEFT JOIN Establishment
ON zno.EONAME = Establishment.School_name;



INSERT INTO Exam_results (Person_id, Test_type, Year, Test_status, Ball100, Ball12, Ball, Parent_name)
SELECT outID, UkrTest, ZNOYear, UkrTestStatus, UkrBall100, UkrBall12, UkrBall,  UkrPTName
FROM zno
WHERE zno.UkrTest IS NOT NULL;



INSERT INTO Exam_results (Person_id, Test_type, Year, Test_status, Ball100, Ball12, Ball, Parent_name)
SELECT outID, histTest, ZNOYear, histTestStatus, histBall100, histBall12, histBall, histPTName
FROM zno
WHERE zno.histTest IS NOT NULL;



INSERT INTO Exam_results (Person_id, Test_type, Year, Test_status, Ball100, Ball12, Ball, Parent_name)
SELECT outID, mathTest, ZNOYear, mathTestStatus, mathBall100, mathBall12, mathBall, mathPTName
FROM zno
WHERE zno.mathTest IS NOT NULL;


INSERT INTO Exam_results (Person_id, Test_type, Year, Test_status, Ball100, Ball12, Ball, Parent_name)
SELECT outID, physTest, ZNOYear, physTestStatus, physBall100, physBall12, physBall, physPTName
FROM zno
WHERE zno.physTest IS NOT NULL;


INSERT INTO Exam_results (Person_id, Test_type, Year, Test_status, Ball100, Ball12, Ball, Parent_name)
SELECT outID, chemTest, ZNOYear, chemTestStatus, chemBall100, chemBall12, chemBall, chemPTName
FROM zno
WHERE zno.chemTest IS NOT NULL;



INSERT INTO Exam_results (Person_id, Test_type, Year, Test_status, Ball100, Ball12, Ball, Parent_name)
SELECT outID, bioTest, ZNOYear, bioTestStatus, bioBall100, bioBall12, bioBall, bioPTName
FROM zno
WHERE zno.bioTest IS NOT NULL;



INSERT INTO Exam_results (Person_id, Test_type, Year, Test_status, Ball100, Ball12, Ball, Parent_name)
SELECT outID, geoTest, ZNOYear, geoTestStatus, geoBall100, geoBall12, geoBall, geoPTName
FROM zno
WHERE zno.geoTest IS NOT NULL;


INSERT INTO Exam_results (Person_id, Test_type, Year, Test_status, Ball100, Ball12, Ball, Parent_name)
SELECT outID, engTest, ZNOYear, engTestStatus, engBall100, engBall12, engBall, engPTName
FROM zno
WHERE zno.engTest IS NOT NULL;


INSERT INTO Exam_results (Person_id, Test_type, Year, Test_status, Ball100, Ball12, Ball, Parent_name)
SELECT outID, fraTest, ZNOYear, fraTestStatus, fraBall100, fraBall12, fraBall, fraPTName
FROM zno
WHERE zno.fraTest IS NOT NULL;



INSERT INTO Exam_results (Person_id, Test_type, Year, Test_status, Ball100, Ball12, Ball, Parent_name)
SELECT outID, deuTest, ZNOYear, deuTestStatus, deuBall100, deuBall12, deuBall, deuPTName
FROM zno
WHERE zno.deuTest IS NOT NULL;



INSERT INTO Exam_results (Person_id, Test_type, Year, Test_status, Ball100, Ball12, Ball, Parent_name)
SELECT outID, spaTest, ZNOYear, spaTestStatus, spaBall100, spaBall12, spaBall, spaPTName
FROM zno
WHERE zno.spaTest IS NOT NULL;