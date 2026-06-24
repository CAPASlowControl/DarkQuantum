#!../../bin/linux-x86_64/dq

#- You may have to change app to something else
#- everywhere it appears in this file

< envPaths
cd "${TOP}"

epicsEnvSet(STREAM_PROTOCOL_PATH,"$(TOP)/dqApp/Db")



## Register all support components
dbLoadDatabase "$(TOP)/dbd/dq.dbd"
dq_registerRecordDeviceDriver pdbbase


#####################
##### BLUEFORS ######
#####################

#Port
# Defining differt port avoid parsing all input in every PV (for SCAN=IO Intr.)
drvAsynIPPortConfigure("bf_mpbf","127.0.0.1:49099",0,0,1)
drvAsynIPPortConfigure("bf_cpa","127.0.0.1:49099",0,0,1)

#Load Records
dbLoadRecords("$(TOP)/dqApp/Db/bf_mpbf.db","P=DQ:BF:MPBF,PORT=bf_mpbf")
dbLoadRecords("$(TOP)/dqApp/Db/bf_cpa.db","P=DQ:BF:CPA,PORT=bf_cpa")


#cd "${TOP}/iocBoot/${IOC}"
cd "${TOP}"

#asynSetTraceMask("html", -1, 0x008)
#asynSetTraceIOMask("html", -1, 0x0001)
#asynSetTraceInfoMask("html", -1, 0x0008)

#enable debug output
#var streamDebug 1

iocInit

## Start any sequence programs
#seq sncxxx,"user=angel"
