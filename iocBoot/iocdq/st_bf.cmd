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
drvAsynIPPortConfigure("bf_tcch","127.0.0.1:49099",0,0,1)
drvAsynIPPortConfigure("bf_tcht","127.0.0.1:49099",0,0,1)
drvAsynIPPortConfigure("bf_nxds","127.0.0.1:49099",0,0,1)
drvAsynIPPortConfigure("bf_tc400","127.0.0.1:49099",0,0,1)

#Load Records
dbLoadRecords("$(TOP)/dqApp/Db/bf_mpbf.db","P=DQ:BF:MPBF,PORT=bf_mpbf") # Mapper Bf with main variables.
dbLoadRecords("$(TOP)/dqApp/Db/bf_cpa.db","P=DQ:BF:CPA,PORT=bf_cpa") # Compressor CPA
dbLoadRecords("$(TOP)/dqApp/Db/bf_tcch.db","P=DQ:BF:TCCH,PORT=bf_tcch") # Temperature controller channels
dbLoadRecords("$(TOP)/dqApp/Db/bf_tcht.db","P=DQ:BF:TCHT,PORT=bf_tcht") # Temperature controller Heaters
dbLoadRecords("$(TOP)/dqApp/Db/bf_nxds.db","P=DQ:BF:NXDS,PORT=bf_nxds") # xnds: Edwars Scroll Pump (Scroll1)
dbLoadRecords("$(TOP)/dqApp/Db/bf_tc400.db","P=DQ:BF:TC400,PORT=bf_nxds") # Peiffer HiPACE TC400 (TURBO 1)


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
