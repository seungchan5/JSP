create table member(
    id varchar2(10) primary key not null,
    pass varchar2(10) not null,
    name varchar2(30) not null,
    regidate date DEFAULT sysdate not null
);

create table board(
    num number primary key not null,
    title varchar2(200) not null,
    content varchar2(2000) not null,
    id varchar2(10) not null,
    postdate date default sysdate not null,
    visitcount number(6)
);
alter table board add constraint board_mem_fk foreign key(id) references member(id);

create sequence seq_board_num
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
    
insert into board (num, title, content, id, postdate, visitcount)
    values (seq_board_num.nextval, '����1�Դϴ�', '����1�Դϴ�', 'musthave',
sysdate, 0);
    
insert into member (id, pass, name) values ('musthave', '1234', '�ӽ�Ʈ�غ�');

commit;

comment on table board is '게시판';
comment on column board.num is '일련번호';
comment on column board.title is '제목';
comment on column board.content is '내용';
comment on column board.id is '작성자 아이디';
comment on column board.postdate is '작성일';
comment on column board.visitcount is '조회수';

comment on table member is '회원';
comment on column member.id is '아이디';
comment on column member.pass is '비밀번호';
comment on column member.name is '이름';
comment on column member.regidate is '생성일';
