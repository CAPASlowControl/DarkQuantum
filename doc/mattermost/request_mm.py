import requests
import sys

# The API endpoint
#url = "http://localhost:10000/values"

url = 'https://mattermost.web.cern.ch/hooks/fpekko6jwibfzfchck6by89mdo'
#url = 'http://localhost:10000'

data =  {"text": sys.argv[1]}

# A GET request to the API
response = requests.post(url,json=data)


## Print the response
print( response.content.decode('utf-8') )

#print(response.request.url)
#print(response.request.body)
#print(response.request.headers)

