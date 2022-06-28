from unittest import result
from mongodb import *
from datetime import datetime, timedelta
from werkzeug.security import generate_password_hash, check_password_hash
#from smail import send_password_reset_email ,sendregistermail
app = Flask(__name__)

def register_customer(email,password):
    date_created = datetime.utcnow()
    email_exists = customers.find_one({"email":email})
    if email_exists:
        result = {"message": 'User Already exists,Please go for login',"success":False}
    else:
        user_id  = customers.insert_one({'email' : email,'password' : password,'date_created': date_created}).inserted_id
        result = {"message":"User Registered Successfully" , 'user_id':str(user_id),'email':email,'success':True}
        
    return result 



SECRET_KEY = 'secret1a2b3c4d5e'


def sign_in_customer(email,password):
    user_exists = customers.find_one({"email":email})
    if not user_exists:
        result =  {"success": False,
                "message": "This email does not exist."}
        return result
    if not check_password_hash(user_exists['password'], password):
        result =  {"success": False,
                "message": "Wrong credentials."}
        return result
    user = {"email":user_exists['email'] , "user_id": str(user_exists['_id'])}
    session['user_id'] = str(user_exists['_id'])
    result =  {"success": True,
            "email":user_exists["email"],
            "message": "Login Successful",
            "user": user}
    return result


# Password reset
def resetPassword(email):
    try:
        user = customers.find_one({"email":email})
    except:
        result =  {"success": False,
                "message": "This email does not exist."}
        return result

    if user.email:
       # send_password_reset_email(email)
        result =  {
            "success" : True,
            "message" : "Mail sent successfully!"
        }
        return result
    else :
        result =  {
            "success" : False,
            "message" : "Error Occured!"
        }
        return result

# logout user 
def logout_customer():
    if 'user_id' in session:
        session.pop('user_id',None)
        result = {
            "success":True,
            'message':"Logged out successfully!"
        }
        return result 
    else:
        result = {
            "success":False,
            "message":"Error Occurred!"
        }
        return result




# Store registration

def register_store(email,password,name,phone,storename,addressname,latitude,longitude):
    date_created = datetime.utcnow()
    email_exists = stores.find_one({"email":email})
    if email_exists:
        result = {"message": 'User Already exists,Please go for login',"success":False}
    else:
        store_id  = stores.insert_one({'email' : email,'password' : password,'date_created': date_created,'name':name,'phone':phone,'storename':storename, 'location': {"type":"Point","coordinates":[latitude,longitude],'address' : [storename,addressname]}}).inserted_id
        result = {"message":"User Registered Successfully" , 'store_id':str(store_id),'email':email,'success':True}
        
    return result 



SECRET_KEY = 'secret1a2b3c4d5e'


def sign_in_store(email,password):
    store_exists = stores.find_one({"email":email})
    if not store_exists:
        result =  {"success": False,
                "message": "This email does not exist."}
        return result
    if not check_password_hash(store_exists['password'], password):
        result =  {"success": False,
                "message": "Wrong credentials."}
        return result
    store_user = {"email":store_exists['email'] , "store_id": str(store_exists['_id'])}
    session['store_id'] = str(store_exists['_id'])
    result =  {"success": True,
            "email":store_exists["email"],
            "message": "Login Successful",
            "store_user": store_user}
    return result


# Password reset
def resetPassword(email):
    try:
        store_user = stores.find_one({"email":email})
    except:
        result =  {"success": False,
                "message": "This email does not exist."}
        return result

    if store_user.email:
       # send_password_reset_email(email)
        result =  {
            "success" : True,
            "message" : "Mail sent successfully!"
        }
        return result
    else :
        result =  {
            "success" : False,
            "message" : "Error Occured!"
        }
        return result

# logout user 
def logout_store():
    if 'store_id' in session:
        session.pop('store_id',None)
        result = {
            "success":True,
            'message':"Logged out successfully!"
        }
        return result 
    else:
        result = {
            "success":False,
            "message":"Error Occurred!"
        }
        return result