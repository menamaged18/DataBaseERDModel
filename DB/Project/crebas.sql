/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2005                    */
/* Created on:     5/18/2023 1:14:17 AM                         */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('ACCOUNT') and o.name = 'FK_ACCOUNT_OWN_CUSTOMER')
alter table ACCOUNT
   drop constraint FK_ACCOUNT_OWN_CUSTOMER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('BRANCH') and o.name = 'FK_BRANCH_HAS_BANK')
alter table BRANCH
   drop constraint FK_BRANCH_HAS_BANK
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CUSTOMER') and o.name = 'FK_CUSTOMER_CONTAIN_BRANCH')
alter table CUSTOMER
   drop constraint FK_CUSTOMER_CONTAIN_BRANCH
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('LAONS') and o.name = 'FK_LAONS_OFFER_BRANCH')
alter table LAONS
   drop constraint FK_LAONS_OFFER_BRANCH
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('TAKE') and o.name = 'FK_TAKE_TAKE_CUSTOMER')
alter table TAKE
   drop constraint FK_TAKE_TAKE_CUSTOMER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('TAKE') and o.name = 'FK_TAKE_TAKE2_LAONS')
alter table TAKE
   drop constraint FK_TAKE_TAKE2_LAONS
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('ACCOUNT')
            and   name  = 'OWN_FK'
            and   indid > 0
            and   indid < 255)
   drop index ACCOUNT.OWN_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ACCOUNT')
            and   type = 'U')
   drop table ACCOUNT
go

if exists (select 1
            from  sysobjects
           where  id = object_id('BANK')
            and   type = 'U')
   drop table BANK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('BRANCH')
            and   name  = 'HAS_FK'
            and   indid > 0
            and   indid < 255)
   drop index BRANCH.HAS_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('BRANCH')
            and   type = 'U')
   drop table BRANCH
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CUSTOMER')
            and   name  = 'CONTAIN_FK'
            and   indid > 0
            and   indid < 255)
   drop index CUSTOMER.CONTAIN_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CUSTOMER')
            and   type = 'U')
   drop table CUSTOMER
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('LAONS')
            and   name  = 'OFFER_FK'
            and   indid > 0
            and   indid < 255)
   drop index LAONS.OFFER_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('LAONS')
            and   type = 'U')
   drop table LAONS
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('TAKE')
            and   name  = 'TAKE2_FK'
            and   indid > 0
            and   indid < 255)
   drop index TAKE.TAKE2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('TAKE')
            and   name  = 'TAKE_FK'
            and   indid > 0
            and   indid < 255)
   drop index TAKE.TAKE_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TAKE')
            and   type = 'U')
   drop table TAKE
go

/*==============================================================*/
/* Table: ACCOUNT                                               */
/*==============================================================*/
create table ACCOUNT (
   SSN                  int                  not null,
   ACCOUNTNUMBER        int                  not null,
   ACCOUNTTYPE          varchar(50)          not null,
   BALANCE              double precision     not null,
   constraint PK_ACCOUNT primary key nonclustered (SSN, ACCOUNTNUMBER)
)
go

/*==============================================================*/
/* Index: OWN_FK                                                */
/*==============================================================*/
create index OWN_FK on ACCOUNT (
SSN ASC
)
go

/*==============================================================*/
/* Table: BANK                                                  */
/*==============================================================*/
create table BANK (
   BANKCODE             int                  not null,
   BANKNAME             varchar(50)          not null,
   BANKADDRESS          varchar(50)          null,
   constraint PK_BANK primary key nonclustered (BANKCODE)
)
go

/*==============================================================*/
/* Table: BRANCH                                                */
/*==============================================================*/
create table BRANCH (
   BRANCHNUMBER         int                  not null,
   BANKCODE             int                  null,
   BRANCHADDRESS        varchar(50)          not null,
   constraint PK_BRANCH primary key nonclustered (BRANCHNUMBER)
)
go

/*==============================================================*/
/* Index: HAS_FK                                                */
/*==============================================================*/
create index HAS_FK on BRANCH (
BANKCODE ASC
)
go

/*==============================================================*/
/* Table: CUSTOMER                                              */
/*==============================================================*/
create table CUSTOMER (
   SSN                  int                  not null,
   BRANCHNUMBER         int                  null,
   CUSTOMERNAME         varchar(50)          not null,
   CUSTOMERPHONE        varchar(50)          not null,
   CUSTOMERADDRESS      varchar(50)          not null,
   CTYPE                varchar(50)          not null,
   constraint PK_CUSTOMER primary key nonclustered (SSN)
)
go

/*==============================================================*/
/* Index: CONTAIN_FK                                            */
/*==============================================================*/
create index CONTAIN_FK on CUSTOMER (
BRANCHNUMBER ASC
)
go

/*==============================================================*/
/* Table: LAONS                                                 */
/*==============================================================*/
create table LAONS (
   LOANNUMBER           int                  not null,
   BRANCHNUMBER         int                  null,
   LAONTYPE             varchar(50)          not null,
   LOANAMOUNT           double precision     not null,
   constraint PK_LAONS primary key nonclustered (LOANNUMBER)
)
go

/*==============================================================*/
/* Index: OFFER_FK                                              */
/*==============================================================*/
create index OFFER_FK on LAONS (
BRANCHNUMBER ASC
)
go

/*==============================================================*/
/* Table: TAKE                                                  */
/*==============================================================*/
create table TAKE (
   SSN                  int                  not null,
   LOANNUMBER           int                  not null,
   constraint PK_TAKE primary key (SSN, LOANNUMBER)
)
go

/*==============================================================*/
/* Index: TAKE_FK                                               */
/*==============================================================*/
create index TAKE_FK on TAKE (
SSN ASC
)
go

/*==============================================================*/
/* Index: TAKE2_FK                                              */
/*==============================================================*/
create index TAKE2_FK on TAKE (
LOANNUMBER ASC
)
go

alter table ACCOUNT
   add constraint FK_ACCOUNT_OWN_CUSTOMER foreign key (SSN)
      references CUSTOMER (SSN)
go

alter table BRANCH
   add constraint FK_BRANCH_HAS_BANK foreign key (BANKCODE)
      references BANK (BANKCODE)
go

alter table CUSTOMER
   add constraint FK_CUSTOMER_CONTAIN_BRANCH foreign key (BRANCHNUMBER)
      references BRANCH (BRANCHNUMBER)
go

alter table LAONS
   add constraint FK_LAONS_OFFER_BRANCH foreign key (BRANCHNUMBER)
      references BRANCH (BRANCHNUMBER)
go

alter table TAKE
   add constraint FK_TAKE_TAKE_CUSTOMER foreign key (SSN)
      references CUSTOMER (SSN)
go

alter table TAKE
   add constraint FK_TAKE_TAKE2_LAONS foreign key (LOANNUMBER)
      references LAONS (LOANNUMBER)
go

