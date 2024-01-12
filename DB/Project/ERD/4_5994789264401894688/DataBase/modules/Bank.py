class Bank:
  def init(self,BANKCODE,BANKNAME,BANKADDRESS):
    self.BANKCODE = BANKCODE
    self.BANKNAME = BANKNAME
    self.BANKADDRESS = BANKADDRESS


import sqlite3
myDB = sqlite3.connect("MYDATABASE.db")
cursor = myDB.cursor()
def new_Bank():
  name =input("Enter Bank Name: ")
  cursor.execute(f"select * from BANK where BANKNAME ='{name}'")
  if(len(cursor.fetchall())==1):
   print("This Name Exist!!")
   new_Bank()
  ssn= input("Enter bank CODE: ")
  cursor.execute(f"select * from Bank where BANKCODE ={ssn}")
  if(len(cursor.fetchall())==1):
    print("This CODE Exist!!")
    new_Bank()
  address = input("Enter Bank Address: ")
  cursor.execute(f"select * from Bank where BANKADDRESS ='{address}'")
  if(len(cursor.fetchall())==1):
    print("This address Exist!!")
    new_Bank()
  NewObj=Bank(ssn,name,address)
  cursor.execute(f"insert into BANK values({NewObj.BANKCODE},'{NewObj.BANKNAME}','{NewObj.BANKADDRESS}')")
  print("operation done successfull") 
  myDB.commit()