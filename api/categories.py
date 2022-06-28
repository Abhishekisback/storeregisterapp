from mongodb import categories
def addCategory(category_name,category_images):
    category_exists = categories.find_one({"category_name":category_name})
    if category_exists:
        result = {
            "success":False,
            "message":"Category with this name already exists!"
        }
    else:
        category_id = categories.insert_one({"category_name":category_name,"category_images":category_images}).inserted_id
        if category_id:
            result = {
                "success":True,
                "message":"Product Category Added Successfully!",
        }
        else:
            result = {
                "success":False,
                "message":"There was an issue with the server, Please try again"
         }
    return result

# GET ALL CATEGORIES

def getallcategories():
    category_result = []
    categories_list = categories.find()
    for category in categories_list:
        category['_id'] = str(category['_id'])
        category_result.append(category)
    print(category_result)
    return category_result