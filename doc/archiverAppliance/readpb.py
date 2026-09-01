from pathlib import Path
from epicsarchiver.retrieval.pb import read_pb_file

import datetime
import pytz
import numpy as np
import matplotlib.pyplot as plt

# Persist the raw response to a local .pb file, then read it back.
_pb_path = Path("Pref_hp:2026_08_31.pb")
file_meta, file_events = read_pb_file(str(_pb_path))

cet = pytz.timezone("CET")
dt = [ event.timestamp.astimezone(cet) for event in file_events   ]
vals = [event.val for event in file_events ]

plt.plot(dt, vals, "r-")
plt.show()

