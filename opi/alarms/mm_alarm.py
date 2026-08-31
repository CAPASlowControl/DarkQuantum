import requests
import sys
import epics

# The API endpoint
#url = "http://localhost:10000/values"

url = 'https://mattermost.web.cern.ch/hooks/fpekko6jwibfzfchck6by89mdo'
#url = 'http://localhost:10000'

if len(sys.argv)==3:
    pvname = sys.argv[1]
    sevr = sys.argv[2]
    stat = epics.caget(pvname+".STAT",as_string=True)
    data =  {"text": f"{pvname} : {sevr} ({stat})"}
#if
#elif len(sys.argv)==1:
#    data =  {"text": f"{sys.argv[0]}"}
#elif len(sys.argv)==2:
#    data =  {"text": f"{sys.argv[1]}"}
##if

#if
#data =  {"text": "test"}

# A GET request to the API
response = requests.post(url,json=data)


## Print the response
print( response.content.decode('utf-8') )

#print(response.request.url)
#print(response.request.body)
#print(response.request.headers)

