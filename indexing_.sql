USE PittGroupMe

CREATE INDEX cproj_noppl
ON project (c_proj_flag,no_ppl);

CREATE INDEX poster_projectid
ON project (pittid,project_id);

CREATE INDEX poster_cid
ON project (pittid,cid);

CREATE INDEX projectid_enddate
ON project (pittid,end_date);

CREATE INDEX projectid_startdate
ON project (pittid,s_date);

CREATE INDEX projid_noppl
ON project (project_id,no_ppl);

CREATE INDEX tot_students
ON sign_up (stu_flag,pittid);

