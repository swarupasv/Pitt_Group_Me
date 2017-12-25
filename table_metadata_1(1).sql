BEGIN TRAN
--Table creation scripts for all main relations
USE PittGroupMe
CREATE TABLE sign_up 
( pittid VARCHAR(10) NOT NULL , fname VARCHAR(25) NOT NULL , 
Lname VARCHAR(25) NOT NULL , pitt_email VARCHAR(25) NOT NULL , 
stu_flag bit NOT NULL, password_hash BINARY(20) NOT NULL, PRIMARY KEY (pittid));

CREATE TABLE pgm_maj_info (pgm_maj_code VARCHAR(25) NOT NULL, pgm VARCHAR(50) NOT NULL, 
major VARCHAR(50) NOT NULL,
PRIMARY KEY (pgm_maj_code));

CREATE TABLE student_info ( pittid VARCHAR(10) NOT NULL , pgm_maj_code VARCHAR(25) NOT NULL DEFAULT 'Not Available', 
about_me VARCHAR(100) , proj_desc VARCHAR(200) ,
PRIMARY KEY (pittid),
FOREIGN KEY (pittid) REFERENCES sign_up ON DELETE CASCADE,
FOREIGN KEY (pgm_maj_code) REFERENCES pgm_maj_info ON DELETE SET DEFAULT); 

CREATE TABLE desig_school_info (desig_sch_code VARCHAR(25) NOT NULL, desig VARCHAR(50) NOT NULL, 
school VARCHAR(50) NOT NULL,
PRIMARY KEY (desig_sch_code));

CREATE TABLE faculty_info ( pittid VARCHAR(10) NOT NULL , desig_sch_code VARCHAR(25) NOT NULL DEFAULT 'Not Available', 
about_me VARCHAR(100) , proj_desc VARCHAR(200) ,
PRIMARY KEY (pittid),
FOREIGN KEY (pittid) REFERENCES sign_up ON DELETE CASCADE,
FOREIGN KEY (desig_sch_code) REFERENCES desig_school_info ON DELETE SET DEFAULT);

CREATE TABLE skills (pittid VARCHAR(10) NOT NULL, skills VARCHAR(50) NOT NULL, 
PRIMARY KEY (pittid,skills),
FOREIGN KEY (pittid) REFERENCES sign_up ON DELETE CASCADE);

CREATE TABLE interest (pittid VARCHAR(10) NOT NULL, interest VARCHAR(50) NOT NULL, 
PRIMARY KEY (pittid,interest),
FOREIGN KEY (pittid) REFERENCES sign_up ON DELETE CASCADE);

CREATE TABLE course (cid VARCHAR(10) NOT NULL, cname VARCHAR(50) NOT NULL, 
PRIMARY KEY (cid));

CREATE TABLE project(c_proj_flag BIT NOT NULL,
pittid VARCHAR(10) FOREIGN KEY REFERENCES sign_up ON DELETE CASCADE NOT NULL,
project_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
descrip VARCHAR (200) DEFAULT 'Not Specified',
cid VARCHAR(10) FOREIGN KEY REFERENCES course ON DELETE CASCADE DEFAULT '000',
no_ppl INT, s_date DATE NOT NULL, end_date DATE NOT NULL);

CREATE TABLE proj_skills (project_id int NOT NULL FOREIGN KEY REFERENCES project ON DELETE CASCADE,
skills VARCHAR(50) NOT NULL, 
PRIMARY KEY (project_id, skills));

CREATE TABLE request (p_pittid VARCHAR(10),	--p_pittid is project poster's PittID
s_pittid VARCHAR(10) NOT NULL,	--s_pittid is request sender's PittID
project_id int FOREIGN KEY REFERENCES project,
req_status CHAR NOT NULL,
PRIMARY KEY (s_pittid, project_id), 
CONSTRAINT req_status_val CHECK (req_status in ('C','A','D','E')));	--C=Currently active, A=Accepted, D=Declined, E=Expired

ROLLBACK

