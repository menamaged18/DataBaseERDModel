class Branch:
  def __init__(self,BRANCHNUMBER , BRANCHADDRESS,BANKCODE ):
    self.BRANCHNUMBER = BRANCHNUMBER
    self.BRANCHADDRESS = BRANCHADDRESS
    self.BANKCODE = BANKCODE


    

import sqlite3
myDB = sqlite3.connect("MYDATABASE.db")
cursor = myDB.cursor()
def new_Branch():
  id = input("Enter Branch BranchNumber: ")
  cursor.execute(f"select * from Branch where id = {id}")
  if(len(cursor.fetchall())==1):
   print("This id Exist!!")
   new_Branch()  
   
  address = input("Enter Branch Address: ")
  cursor.execute(f"select * from Bank where address ='{address}'")
  if(len(cursor.fetchall())==1):
    print("This address Exist!!")
    new_Branch()
  code = input("Enter Bank id: ")
  cursor.execute(f"select * from Bank where ssn ={code}")
  if(len(cursor.fetchall())!=1):
    print("this bank not exist!!")
    new_Branch()
  NewObj = Branch(id,address,code)
  cursor.execute(f"insert into Branch values({NewObj.BRANCHNUMBER},{NewObj.BANKCODE},'{NewObj.BRANCHADDRESS}')")
  print("operation done successfull")
  myDB.commit() 

