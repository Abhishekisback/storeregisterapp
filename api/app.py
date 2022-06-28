import os
from bson import ObjectId
from flask import Flask, render_template ,session,request,jsonify
from hyperlink import URL
from categories import getallcategories
from categories import addCategory
from stores import get_nearby_stores
from  mongodb import *
from authentication import *
from werkzeug.utils import secure_filename
from flask_cors import CORS
import boto3
app = Flask(__name__)
CORS(app)
app.secret_key = "shoappsecretkey1234567890987654321"
s3 = boto3.client('s3',
                    aws_access_key_id='AKIA6L54FCA54WHDHFMS',
                    aws_secret_access_key= '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',
                   # aws_session_token=keys.AWS_SESSION_TOKEN
                     )

BUCKET_NAME='shopapp-bucket'
# Customer registration 
@app.route( '/customers/register', methods=['GET', 'POST'])
def create_user():
    email = request.get_json()['email']
    password = generate_password_hash(request.get_json()['password'], method='sha256')
    result = register_customer(email,password)
    print(result)
    if result['success']== True:
        #sendregistermail(email)
        return jsonify( {
            "message": result['message'],
            'user_id' : result['user_id'],
            'email':result['email']
        }), 200
        
    else:
        return jsonify({
            "message":result['message']
        }),400

# Customer Login Endpoint Implementation
@app.route('/customers/login',methods=['GET','POST'])
def login():
    if 'user_id' in session:
        return jsonify({
            "message":"Already Logged In!"        })
    email = request.get_json()['email']
    password = request.get_json()['password']
    result = sign_in_customer(email,password)
    if result['success'] == True:
        return jsonify({
            "message":result['message'],
            "user": result['user']

        }),200
    else:
        return jsonify({
            "message" : result['message']
        }),400

# USER LOGOUT ENDPOINT
@app.route('/customers/logout',methods=['GET','POST'])
def logout_user():
    result = logout_customer()
    if result["success"] == True:
        return jsonify({
            "message":result['message'],
            
        }),200
    else:
        return jsonify({
            "message": result["message"]
        }),400


# Password Reset Endpoint (will be implemented later)
# @app.route('/reset', methods=["GET", "POST"])
# def reset():
#     req_data = request.get_json()
#     email = req_data.get("email")
#     reset = resetPassword(email)
#     if result['success'] == True:
#         return jsonify({
#             "message" : result['message']
#         }),200
#     else:
#         return jsonify({
#             "message" : result['message']
#         }),400

# @app.route(docroot + '/reset/<token>', methods=["GET", "POST"])
# def reset_with_token(token):
#     try:
#         password_reset_serializer = URLSafeTimedSerializer(
#             app.config['SECRET_KEY'])
#         email = password_reset_serializer.loads(
#             token, salt='password-reset-salt', max_age=3600)
#     except:
#         flash('The password reset link is invalid or has expired.')
#     if request.method == 'POST':
#         password = request.form['password']
#         hashed_password = generate_password_hash(password, method='sha256')
#         try:
#             user = users.find_one({"email":email})
#         except:
#             flash('Invalid email address!')
#         users.update_one({'email':email},{"$set":{'password':hashed_password}})
#         flash('Your password has been updated!')
#     return render_template('newpassword_form.html', token=token)


# Store registration 
@app.route( '/store/register', methods=['GET', 'POST'])
def create_store():
    email = request.get_json()['email']
    password = generate_password_hash(request.get_json()['password'], method='sha256')
    name = request.get_json()['name']
    addressname = request.get_json()['addressname']
    latitude = request.get_json()['latitude']
    longitude = request.get_json()['longitude']
    storename = request.get_json()['store_name']
    phone = request.get_json()['phone']
    result = register_store(email,password,name,phone,storename,addressname,latitude,longitude)
    print(result)
    if result['success']== True:
        #sendregistermail(email)
        return jsonify( {
            "message": result['message'],
            'store_id' : result['store_id'],
            'email':result['email']
        }), 200
        
    else:
        return jsonify({
            "message":result['message']
        }),400

# Store Login Endpoint Implementation
@app.route('/store/login',methods=['GET','POST'])
def login_store():
    if 'store_id' in session:
        return jsonify({
            "message":"Already Logged In!"        })
    email = request.get_json()['email']
    password = request.get_json()['password']
    result = sign_in_store(email,password)
    if result['success'] == True:
        return jsonify({
            "message":result['message'],
            "store_user": result['store_user']

        }),200
    else:
        return jsonify({
            "message" : result['message']
        }),400

# STORE LOGOUT ENDPOINT
@app.route('/store/logout',methods=['GET','POST'])
def logout_store():
    result = logout_store()
    if result["success"] == True:
        return jsonify({
            "message":result['message'],
            
        }),200
    else:
        return jsonify({
            "message": result["message"]
        }),400


#----------------------------Products endpoints ------------------------------------#
@app.route('/uploadproducts',methods=['POST'])
def uploadproducts():
    APP_ROOT = os.path.dirname(os.path.abspath(__file__))
    data = request.form
   # print(data)
    product_name = data['product_name']
    print(product_name)
    product_description = data['product_description']
    price = data['price']
    quantity = data['quantity']
    category_name = data['category_name']
    print(category_name)
    find_category_id = '123'
    #find_category_id = categories.find_one({"category_name":category_name},{"category_id":1})
    category_id = str(find_category_id['_id'])
    store_id = str(data['store_id'])
    print( request.files.getlist('product_images'))
    product_urls = [] 
    imagefile = request.files['product_images']
    filename = werkzeug.utils.secure_filename(imagefile.filename)
    print("\nReceived image File name : " + imagefile.filename)
    imagefile.save("./uploadedimages/" + filename)
    # for image in request.files.getlist('product_images'):
    #     filename = secure_filename(image.filename)
    #     print(filename)
    #     if image:
    #         image.save(filename)
    #         s3.upload_file(filename,BUCKET_NAME, '%s/%s' % ('products',filename))
    #         product_url = f"https://{BUCKET_NAME}.s3.{'ap-south-1'}.amazonaws.com/products/{filename}"
    #         product_urls.append(product_url)
    # print(product_urls)
    product_id = products.insert_one({'product_name':product_name,'product_description':product_description,'price':price,'quantity':quantity,'category_id':category_id,'store_id':store_id,'product_images':product_urls}).inserted_id
    if product_id:
        return jsonify({
            "message":"product uploaded successfully",
            "product_id":str(product_id)
        }),200
    else:
        return jsonify({
        "message":"Error Occurred!"
        }),404

# --------------------   Get products by category name -----------------------------#
@app.route('/getproductsbycategory',methods=['POST','GET'])
def get_products():
    category_name = request.get_json()['category_name']
    user_lat  = request.get_json()['user_lat']
    user_long = request.get_json()['user_long']
    stores = get_nearby_stores(user_lat,user_long)
    stores_list = []
    store_ids = []
    for i in stores:
        i['_id'] = str(i['_id']) # This does the trick!
        stores_list.append(i)
        store_ids.append(i['_id'])
    find_category_id = categories.find_one({"category_name":category_name},{"category_id":1})
    category_id = find_category_id['_id']
    productquery = {"category_id": ObjectId(category_id) ,"store_id": { "$in": store_ids}} 
    product = products.find(productquery)
    for x in product:
        return jsonify({
        "product_name":x['product_name'],
        "product_description":x['product_description'],
        "price":x['price'],
        "quantity" : x['quantity'],
        "store_lists": stores_list,
        "product_images":x["product_images"]
    }),200
    else:
        return jsonify({
            "message":"No products found!"
        })

# ---------------------------- Get Products by Store -------------------------#
@app.route('/productbystore',methods=['GET','POST'])
def productbystore():
    store_id = request.get_json()['store_id']
    result_products = []
    result = products.find({"store_id":store_id})
    for product in result:
        product['_id'] = str(product['_id']) # This does the trick!
        result_products.append(product)
        print(result_products)
    return jsonify({
        "products":result_products
    })


@app.route('/productsearch',methods=['GET','POST'])
def search_product():
    product_name = request.get_json()['product_name']
    user_lat  = request.get_json()['user_lat']
    user_long = request.get_json()['user_long']
    stores = get_nearby_stores(user_lat,user_long)
    stores_list = []
    store_ids = []
    for i in stores:
        i['_id'] = str(i['_id']) # This does the trick!
        stores_list.append(i)
        store_ids.append(i['_id'])
    productquery = {"product_name": product_name ,"store_id": { "$in": store_ids}} 
    product = products.find(productquery)
    for x in product:
        print(x['product_images'])
        return jsonify({
        "product_name":x['product_name'],
        "product_description":x['product_description'],
        "price":x['price'],
        "quantity" : x['quantity'],
        "store_lists": stores_list,
        "product_images":x["product_images"]
    }),200
    else:
        return jsonify({
            "message":"No products found!"
        })





# -------------------------------- Nearby Stores -----------------------------#
@app.route('/getnearbystores',methods=['GET','POST'])
def nearby():
    user_lat = request.get_json()['user_lat']
    user_lon = request.get_json()['user_long']
    stores_list =[]
    result = get_nearby_stores(user_lat,user_lon)
    for x in result:
        x['_id'] = str(x['_id']) # This does the trick!
        stores_list.append(x)
    return jsonify({
        "store_lists":stores_list
    })


# -------------------------------- Categories Endpoints ---------------------------#
# -------------------------------- Add category -----------------------------------#
@app.route('/addcategory',methods=['GET','POST'])
def addnewcategory():
    category_name = request.form['category_name']
    category_urls = []
    for image in request.files.getlist('category_images'):
        filename = secure_filename(image.filename)
        if image:
            image.save(filename)
            s3.upload_file(filename,BUCKET_NAME, '%s/%s' % ('categories',filename))
            category_url = f"https://{BUCKET_NAME}.s3.{'ap-south-1'}.amazonaws.com/categories/{filename}"
            category_urls.append(category_url)
    print(category_urls)
    result = addCategory(category_name,category_urls)
    if result["success"] == True:
        return jsonify({
        "message":result['message']
        }),200
    else:
        return jsonify({
            "message":result['message']
        }),400

# ---------------------------  GET ALL CATEGORIES ---------------------------------#
@app.route("/getallcategories",methods=['GET','POST'])
def get_all_categories():
    result = getallcategories()
    categories_list =[]
    if result:
        return jsonify({
        "categories": result
    }),200
    else:
        return jsonify({
            "message" : "Error reaching server , Please try again!"
        }),400

if __name__ == '__main__':
    app.run(debug=True)