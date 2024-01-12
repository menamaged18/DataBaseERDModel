class customer:
  def __init__(self,id ,name , address,phone,Branch_id):
    self.id = id
    self.name = name
    self.address = address
    self.phone=phone
    self.Branch_id = Branch_id



import sqlite3
myDB = sqlite3.connect("app.db")
cursor = myDB.cursor()
def new_Customer():
  id =input("Enter your id: ")
  cursor.execute(f"select * from customer where id ='{id}'")
  if(len(cursor.fetchall())==1):
   print("This id Exist!!")
   new_Customer()  
   
  name =input("Enter your Name: ")
  cursor.execute(f"select * from customer where name ='{name}'")
  if(len(cursor.fetchall())==1):
   print("This Name Exist!!")
   new_Customer()  
  address = input("Enter your Address: ")
  cursor.execute(f"select * from customer where address ='{address}'")
  if(len(cursor.fetchall())==1):
    print("This address Exist!!")
    new_Customer()
  phone = input("Enter your phone: ")
  cursor.execute(f"select * from customer where phone ='{phone}'")
  if(len(cursor.fetchall())==1):
    print("This phone Exist!!")
    new_Customer()
  code = input("Enter Branch id: ")
  cursor.execute(f"select * from Branch where id ={code}")
  if(len(cursor.fetchall())!=1):
    print("this Branch not exist!!")
    new_Customer()
  NewObj = customer(id,name ,address,phone,code)
  cursor.execute(f"insert into customer values({NewObj.id},'{NewObj.name}','{NewObj.address}','{NewObj.phone}',{NewObj.Branch_id})")
  print("operation done successfull")
  myDB.commit() 

