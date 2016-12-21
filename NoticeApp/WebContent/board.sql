CREATE TABLE tblboard(
	b_num	number,
	b_name	varchar2(20),
	b_email	varchar2(50),
	b_hompage	varchar2(50),
	b_subject	varchar2(50),
	b_content	varchar2(4000),
	b_pass	varchar2(10),
	b_count	number,
	b_ip	varchar2(50),
	b_regdate	date,
	b_pos	number,
	b_depth	number,
	CONSTRAINT pk_num PRIMARY KEY(b_num)
);

CREATE SEQUENCE seq_num;

select*from tblboard;
