import requests

# The API endpoint
#url = "http://localhost:10000/values"

key = 'a441a1c4-4771-4584-b14b-069dce30d0e7'
url = f"https://192.168.100.104:49098/values/mapper/bf?key={key}"

# A GET request to the API
response = requests.get(url)

## Print the response
#response_json = response.json()
#print(response.request.url)
#print(response.request.body)
#print(response.request.headers)
print( repr(response.content) )
#print(response_json)
