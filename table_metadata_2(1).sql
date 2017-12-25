BEGIN TRAN
CREATE TABLE mssgs ( mssg_id int NOT NULL  IDENTITY(1,1),
mssg_desc varchar(100) NOT NULL);
ROLLBACK