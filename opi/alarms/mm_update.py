import requests
import sys
import epics

# The API endpoint
#url = "http://localhost:10000/values"

url = 'https://mattermost.web.cern.ch/hooks/fpekko6jwibfzfchck6by89mdo'
#url = 'http://localhost:10000'


PVlist = ["DQ:CHL:RelayStatus1_Alarm",
          "DQ:CHL:MachineStatus_Standby",
          "DQ:CHL:RelayStatus1_WaterPump",
          "DQ:CHL:Pref_hp_MaxCalc",
          "DQ:CHL:ChSetPoint",
          "DQ:CHL:Tout",
          "DQ:BF:MPBF:pulsetube",
          "DQ:BF:MPBF:scroll1", 
          "DQ:BF:MPBF:turbo1",
          "DQ:BF:MPBF:t4k",
          "DQ:BF:MPBF:t50k",
          "DQ:BF:MPBF:tmixing",
          "DQ:BF:MPBF:tstill",
        ]

text =""

if epics.caget("DQ:CHL:RelayStatus1_Alarm",as_string=True)=="On":
    text = text + "# ERROR Chiller Alarm\n"
#if

text = "##### Dil Ref. Info:\n"
for PV in PVlist:
    val = epics.caget(PV,as_string=True)
    text = text+  f"{PV} : {val}\n"

data =  {"text": text}

# A GET request to the API
response = requests.post(url,json=data)

## Print the response
#print( response.content.decode('utf-8') )
