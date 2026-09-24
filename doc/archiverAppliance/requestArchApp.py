import requests
import numpy as np
#from chaco.shell import *
#import urllib
import json
import matplotlib.pyplot as plt
import datetime
import pytz

def req_PV (PV, date0, date1):

    url = f"http://127.0.0.1:17668/retrieval/data/getData.json?pv={PV}&from={date0}&to={date1}#"
    print(url)

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
    dt = [datetime.datetime.fromtimestamp(t,tz=cet) for t in tt]
    return dt, vals
#def

######################

cet = pytz.timezone("CET")
uct = pytz.timezone("UCT")


PV = "DQ:CHL:Pref_hp"
date0= datetime.datetime(2026,1,2,12,0,0,0) # By defalult in CET
date0 = date0.astimezone(uct).strftime("%Y-%m-%dT%H:%M:%S.Z") # Convert to UCT

date1= datetime.datetime.now(tz=uct).strftime("%Y-%m-%dT%H:%M:%S.Z")


dt, vals =req_PV(PV,date0,date1)

plt.figure(1)
plt.plot(dt, vals, "r-")
plt.show(block=False)

## Integrate PV value
#PV = "DQ:BF:MPBF:scroll1"
PV = "DQ:BF:MPBF:turbo1"

dt, vals =req_PV(PV,date0,date1)

plt.figure(2)
plt.plot(dt, vals, "r-", ds='steps-post')
plt.show(block=True)

def int_step(dt,vals):
    now = datetime.datetime.now(cet)
    dt.append(  now )

    dt = np.array(dt)
    nt = dt.shape[0]
    Adt = dt[1:]-dt[:-1]

    Ainteg = Adt*vals
    integ =Ainteg.sum().total_seconds()

    return integ # In vals*seconds
#def

integ = int_step(dt,vals)

string = f"""On Time for {PV}
{integ} seconds
{integ//3600} hours
{integ//3600/24} days
"""
print(string)


