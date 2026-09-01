
import pytz 
import numpy as np
import matplotlib.pyplot as plt
import datetime

from epicsarchiver import ArchiverAppliance

archiver = ArchiverAppliance("dqslwctrl")
pv = "DQ:CHL:Pref_hp"

cet = pytz.timezone("CET")
metadata, events = archiver.get_events(pv, datetime.datetime.now(tz=cet) - datetime.timedelta(hours=1), datetime.datetime.now(tz=cet))

dt = [ event.timestamp.astimezone(cet) for event in events   ]
vals = [event.val for event in events ]

plt.plot(dt, vals, "r-")
plt.show()


