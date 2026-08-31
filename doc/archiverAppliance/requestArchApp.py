import requests
import numpy as np
#from chaco.shell import *
#import urllib
import json
import matplotlib.pyplot as plt


url = f"http://127.0.0.1:17668/retrieval/data/getData.json?pv=DQ:CHL:Pref_hp&from=2026-08-28T10:00:00.000Z&to=2026-08-28T15:00:00.000Z"


#req = urllib.urlopen( url )

response = requests.get(url,verify=False)

data_js = response.json() #json.load(response)
data = data_js[0]["data"]
secs = [x['secs'] for x in data]
nanos = [x['nanos'] for x in data]
vals = [x['val'] for x in data]

sec = np.array(secs)
nanos = np.array(nanos)
vals = np.array(vals)

tt = secs+nanos*1E-9 
dt = tt.astype('datetime64[s]') 

plt.plot(dt, vals, "r-")
plt.show()


