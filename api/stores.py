from mongodb import stores
def get_nearby_stores(latiude,longitude):
    result_stores = stores.find( {
    "location":
       { "$near":
          {
            "$geometry": { "type": "Point",  "coordinates": [ latiude,longitude] },
            "$minDistance": 0,
            "$maxDistance": 5000
          }
       }
   },
   {"storename":1,"location":1,"_id":1,"phone":1}
    )
    return result_stores
    

