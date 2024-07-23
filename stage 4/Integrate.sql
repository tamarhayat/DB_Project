drop table COURSE_TOOL  --delete the old relationship table

ALTER TABLE Tool
DROP CONSTRAINT SYS_C008014;


ALTER TABLE Tool ADD eID NUMBER(5)
ALTER TABLE Tool RENAME COLUMN tool_name TO ename
ALTER TABLE Tool ADD isMobile VARCHAR2(5) DEFAULT 'false' 
ALTER TABLE Tool ADD quantity INT
ALTER TABLE Tool ADD required_in_vehicle NUMBER(5) DEFAULT NULL
ALTER TABLE Tool ADD price NUMBER(7,2)


ALTER TABLE Equipment MODIFY ename VARCHAR2(55); --increase to the big size
ALTER TABLE Equipment ADD weight FLOAT
ALTER TABLE Equipment ADD made_in VARCHAR2(50)
ALTER TABLE Equipment ADD color VARCHAR2(15)

---create the relationship to tcategory from equipment
ALTER TABLE Equipment ADD category_name VARCHAR2(50)
ALTER TABLE Equipment add foreign key (CATEGORY_NAME) 
  references TCATEGORY (CATEGORY_NAME);

------------------------------------------------------------------------
---generate data in file "generateData.sql"-----------------------------
------------------------------------------------------------------------


ALTER TABLE Tool MODIFY eID NOT NULL;
ALTER TABLE Tool MODIFY ename NOT NULL;
ALTER TABLE Tool MODIFY isMobile NOT NULL;
ALTER TABLE Tool MODIFY quantity NOT NULL;
ALTER TABLE Tool MODIFY price NOT NULL;
ALTER TABLE Equipment MODIFY made_in NOT NULL;
ALTER TABLE Equipment MODIFY color NOT NULL;
ALTER TABLE Equipment MODIFY weight NOT NULL;


ALTER TABLE tool
DROP CONSTRAINT SYS_C008015; --delete the connect to tcategory
drop table tool;  --delete the table


--create the relationship table instead of the "course_tool" we delete
CREATE TABLE course_equip
(
  eID NUMBER(5),
  course_id NUMBER(5),
  PRIMARY KEY (eID, course_id),
  FOREIGN KEY (eID) REFERENCES Equipment(eID),
  FOREIGN KEY (course_id) REFERENCES Course(course_id)
);
