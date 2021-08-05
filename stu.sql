
CREATE TABLE Dept
(
	dept_cd              CHAR(18) NOT NULL ,
	dept_nm              CHAR(18) NULL 
);

CREATE UNIQUE INDEX XPKDept ON Dept
(dept_cd   ASC);

ALTER TABLE Dept
	ADD CONSTRAINT  XPKDept PRIMARY KEY (dept_cd);

CREATE TABLE hear
(
	st_no                CHAR(18) NOT NULL ,
	hear_hakgi           CHAR(18) NULL 
);

CREATE UNIQUE INDEX XPKhear ON hear
(st_no   ASC);

ALTER TABLE hear
	ADD CONSTRAINT  XPKhear PRIMARY KEY (st_no);

CREATE TABLE Reg
(
	hakgi                CHAR(18) NULL ,
	st_no                CHAR(18) NOT NULL 
);

CREATE UNIQUE INDEX XPKReg ON Reg
(st_no   ASC);

ALTER TABLE Reg
	ADD CONSTRAINT  XPKReg PRIMARY KEY (st_no);

CREATE TABLE Stu
(
	st_no                CHAR(18) NOT NULL ,
	st_nm                CHAR(18) NULL ,
	st_tel               CHAR(18) NULL ,
	st_addr              CHAR(18) NULL ,
	st_db                CHAR(18) NULL ,
	dept_cd              CHAR(18) NULL 
);

CREATE UNIQUE INDEX XPKStu ON Stu
(st_no   ASC);

ALTER TABLE Stu
	ADD CONSTRAINT  XPKStu PRIMARY KEY (st_no);

ALTER TABLE hear
	ADD (FOREIGN KEY (st_no) REFERENCES Stu(st_no) ON DELETE CASCADE);

ALTER TABLE Reg
	ADD (FOREIGN KEY (st_no) REFERENCES Stu(st_no) ON DELETE CASCADE);

ALTER TABLE Stu
	ADD (CONSTRAINT R_2 FOREIGN KEY (dept_cd) REFERENCES Dept (dept_cd) ON DELETE SET NULL);

CREATE  TRIGGER  tD_Dept AFTER DELETE ON Dept for each row
-- ERwin Builtin Trigger
-- DELETE trigger on Dept 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Trigger */
    /* Dept  Stu on parent delete set null */
    /* ERWIN_RELATION:CHECKSUM="00009c81", PARENT_OWNER="", PARENT_TABLE="Dept"
    CHILD_OWNER="", CHILD_TABLE="Stu"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="dept_cd" */
    UPDATE Stu
      SET
        /* %SetFK(Stu,NULL) */
        Stu.dept_cd = NULL
      WHERE
        /* %JoinFKPK(Stu,:%Old," = "," AND") */
        Stu.dept_cd = :old.dept_cd;


-- ERwin Builtin Trigger
END;
/

CREATE  TRIGGER tU_Dept AFTER UPDATE ON Dept for each row
-- ERwin Builtin Trigger
-- UPDATE trigger on Dept 
DECLARE NUMROWS INTEGER;
BEGIN
  /* Dept  Stu on parent update set null */
  /* ERWIN_RELATION:CHECKSUM="0000c0ac", PARENT_OWNER="", PARENT_TABLE="Dept"
    CHILD_OWNER="", CHILD_TABLE="Stu"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="dept_cd" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.dept_cd <> :new.dept_cd
  THEN
    UPDATE Stu
      SET
        /* %SetFK(Stu,NULL) */
        Stu.dept_cd = NULL
      WHERE
        /* %JoinFKPK(Stu,:%Old," = ",",") */
        Stu.dept_cd = :old.dept_cd;
  END IF;


-- ERwin Builtin Trigger
END;
/


CREATE  TRIGGER tI_hear BEFORE INSERT ON hear for each row
-- ERwin Builtin Trigger
-- INSERT trigger on hear 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Trigger */
    /* Stu  hear on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="0000d877", PARENT_OWNER="", PARENT_TABLE="Stu"
    CHILD_OWNER="", CHILD_TABLE="hear"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="is_a", FK_COLUMNS="st_no" */
    SELECT count(*) INTO NUMROWS
      FROM Stu
      WHERE
        /* %JoinFKPK(:%New,Stu," = "," AND") */
        :new.st_no = Stu.st_no;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert hear because Stu does not exist.'
      );
    END IF;


-- ERwin Builtin Trigger
END;
/

CREATE  TRIGGER tU_hear AFTER UPDATE ON hear for each row
-- ERwin Builtin Trigger
-- UPDATE trigger on hear 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Trigger */
  /* Stu  hear on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="0000d9d4", PARENT_OWNER="", PARENT_TABLE="Stu"
    CHILD_OWNER="", CHILD_TABLE="hear"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="is_a", FK_COLUMNS="st_no" */
  SELECT count(*) INTO NUMROWS
    FROM Stu
    WHERE
      /* %JoinFKPK(:%New,Stu," = "," AND") */
      :new.st_no = Stu.st_no;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update hear because Stu does not exist.'
    );
  END IF;


-- ERwin Builtin Trigger
END;
/


CREATE  TRIGGER tI_Reg BEFORE INSERT ON Reg for each row
-- ERwin Builtin Trigger
-- INSERT trigger on Reg 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Trigger */
    /* Stu  Reg on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="0000d783", PARENT_OWNER="", PARENT_TABLE="Stu"
    CHILD_OWNER="", CHILD_TABLE="Reg"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="is_a", FK_COLUMNS="st_no" */
    SELECT count(*) INTO NUMROWS
      FROM Stu
      WHERE
        /* %JoinFKPK(:%New,Stu," = "," AND") */
        :new.st_no = Stu.st_no;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert Reg because Stu does not exist.'
      );
    END IF;


-- ERwin Builtin Trigger
END;
/

CREATE  TRIGGER tU_Reg AFTER UPDATE ON Reg for each row
-- ERwin Builtin Trigger
-- UPDATE trigger on Reg 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Trigger */
  /* Stu  Reg on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="0000d50d", PARENT_OWNER="", PARENT_TABLE="Stu"
    CHILD_OWNER="", CHILD_TABLE="Reg"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="is_a", FK_COLUMNS="st_no" */
  SELECT count(*) INTO NUMROWS
    FROM Stu
    WHERE
      /* %JoinFKPK(:%New,Stu," = "," AND") */
      :new.st_no = Stu.st_no;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update Reg because Stu does not exist.'
    );
  END IF;


-- ERwin Builtin Trigger
END;
/


CREATE  TRIGGER  tD_Stu AFTER DELETE ON Stu for each row
-- ERwin Builtin Trigger
-- DELETE trigger on Stu 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Trigger */
    /* Stu  hear on parent delete cascade */
    /* ERWIN_RELATION:CHECKSUM="00011c5e", PARENT_OWNER="", PARENT_TABLE="Stu"
    CHILD_OWNER="", CHILD_TABLE="hear"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="is_a", FK_COLUMNS="st_no" */
    DELETE FROM hear
      WHERE
        /*  %JoinFKPK(hear,:%Old," = "," AND") */
        hear.st_no = :old.st_no;

    /* ERwin Builtin Trigger */
    /* Stu  Reg on parent delete cascade */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Stu"
    CHILD_OWNER="", CHILD_TABLE="Reg"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="is_a", FK_COLUMNS="st_no" */
    DELETE FROM Reg
      WHERE
        /*  %JoinFKPK(Reg,:%Old," = "," AND") */
        Reg.st_no = :old.st_no;


-- ERwin Builtin Trigger
END;
/

CREATE  TRIGGER tI_Stu BEFORE INSERT ON Stu for each row
-- ERwin Builtin Trigger
-- INSERT trigger on Stu 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Trigger */
    /* Dept  Stu on child insert set null */
    /* ERWIN_RELATION:CHECKSUM="0000d5df", PARENT_OWNER="", PARENT_TABLE="Dept"
    CHILD_OWNER="", CHILD_TABLE="Stu"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="dept_cd" */
    UPDATE Stu
      SET
        /* %SetFK(Stu,NULL) */
        Stu.dept_cd = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM Dept
            WHERE
              /* %JoinFKPK(:%New,Dept," = "," AND") */
              :new.dept_cd = Dept.dept_cd
        ) 
        /* %JoinPKPK(Stu,:%New," = "," AND") */
         and Stu.st_no = :new.st_no;


-- ERwin Builtin Trigger
END;
/

CREATE  TRIGGER tU_Stu AFTER UPDATE ON Stu for each row
-- ERwin Builtin Trigger
-- UPDATE trigger on Stu 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Trigger */
  /* Stu  hear on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00029099", PARENT_OWNER="", PARENT_TABLE="Stu"
    CHILD_OWNER="", CHILD_TABLE="hear"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="is_a", FK_COLUMNS="st_no" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.st_no <> :new.st_no
  THEN
    UPDATE hear
      SET
        /*  %JoinFKPK(hear,:%New," = ",",") */
        hear.st_no = :new.st_no
      WHERE
        /*  %JoinFKPK(hear,:%Old," = "," AND") */
        hear.st_no = :old.st_no;
  END IF;

  /* ERwin Builtin Trigger */
  /* Stu  Reg on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Stu"
    CHILD_OWNER="", CHILD_TABLE="Reg"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="is_a", FK_COLUMNS="st_no" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.st_no <> :new.st_no
  THEN
    UPDATE Reg
      SET
        /*  %JoinFKPK(Reg,:%New," = ",",") */
        Reg.st_no = :new.st_no
      WHERE
        /*  %JoinFKPK(Reg,:%Old," = "," AND") */
        Reg.st_no = :old.st_no;
  END IF;

  /* ERwin Builtin Trigger */
  /* Dept  Stu on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Dept"
    CHILD_OWNER="", CHILD_TABLE="Stu"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="dept_cd" */
  SELECT count(*) INTO NUMROWS
    FROM Dept
    WHERE
      /* %JoinFKPK(:%New,Dept," = "," AND") */
      :new.dept_cd = Dept.dept_cd;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    :new.dept_cd IS NOT NULL AND
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update Stu because Dept does not exist.'
    );
  END IF;


-- ERwin Builtin Trigger
END;
/

