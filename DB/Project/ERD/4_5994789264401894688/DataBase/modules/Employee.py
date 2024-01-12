class Employee:
 def __init__(self,EMPLOYEEID ,BRANCHNUMBER,EMPLOYEENAME,EMPLOYEEADDRESS,EMPLOYEEPHONE,POSITION):
    self.EMPLOYEEID = EMPLOYEEID
    self.BRANCHNUMBER = BRANCHNUMBER
    self.EMPLOYEENAME=EMPLOYEENAME
    self.EMPLOYEEADDRESS = EMPLOYEEADDRESS
    self.EMPLOYEEPHONE = EMPLOYEEPHONE
    self.POSITION = POSITION

import sqlite3
myDB = sqlite3.connect("MYDATABASE.db")
cursor = myDB.cursor()
def new_Employee():
  id = input("Enter Employee ID: ")
  cursor.execute(f"select * from EMPLOYEE where EMPLOYEEID ={id}")
  if(len(cursor.fetchall())==1):
   print("This id Exist!!")
   new_Employee()  
   
  BranchNumber = input("Enter Branch Number: ")
  cursor.execute(f"select * from BRANCH where BRANCHNUMBER = {BranchNumber}")
  if(len(cursor.fetchall())==1):
   print("This id Exist!!")
   new_Employee()   
  name = input("Enter Employee Name: ")
  cursor.execute(f"select * from EMPLOYEE where EMPLOYEENAME ='{name}'")
  if(len(cursor.fetchall())==1):
   print("This Name Exist!!")
   new_Employee()  
  address = input("Enter your Address: ")
  cursor.execute(f"select * from EMPLOYEE where EMPLOYEEADDRESS ='{address}'")
  if(len(cursor.fetchall())==1):
    print("This address Exist!!")
    new_Employee()
  phone = input("Enter your phone: ")
  cursor.execute(f"select * from EMPLOYEE where EMPLOYEEPHONE ='{phone}'")
  if(len(cursor.fetchall())==1):
    print("This phone Exist!!")
    new_Employee()
  Position = input("Enter Emoloyee Position: ")
  NewObj = Employee(id,BranchNumber,name ,address,phone,Position)
  cursor.execute(f"insert into customer values({NewObj.EMPLOYEEID},{NewObj.BRANCHNUMBER},'{NewObj.EMPLOYEENAME}','{NewObj.EMPLOYEEADDRESS}','{NewObj.EMPLOYEEPHONE}','{NewObj.Branch_id}')")
  print("operation done successfull")
  myDB.commit() 