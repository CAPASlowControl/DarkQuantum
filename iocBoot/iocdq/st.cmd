#!../../bin/linux-x86_64/dq

#- SPDX-FileCopyrightText: 2003 Argonne National Laboratory
#-
#- SPDX-License-Identifier: EPICS

#- You may have to change dq to something else
#- everywhere it appears in this file

< envPaths

cd "${TOP}"
epicsEnvSet(STREAM_PROTOCOL_PATH,"$(TOP)/dqApp/Db")


## Register all support components
dbLoadDatabase "dbd/dq.dbd"
dq_registerRecordDeviceDriver pdbbase


#####################
##### CHILLER #######
#####################

# Serial Port
drvAsynSerialPortConfigure("CHILLERPORT","/dev/ttyUSB0",0,0,0)

asynSetOption("CHILLERPORT",0,"baud","9600")
asynSetOption("CHILLERPORT",0,"bits","8")
asynSetOption("CHILLERPORT",0,"parity","none")
asynSetOption("CHILLERPORT",0,"stop","1")
#asynSetOption("CHILLERPORT",-1,"clocal","Y")
#asynSetOption("CHILLERPORT",-1,"crtscts","N")


modbusInterposeConfig("CHILLERPORT",1,100,5) # modbusInterposeConfig(portName,linkType,timeoutMsec, writeDelayMsec)

# Modbus Port
# drvModbusAsynConfigure("portName", "tcpPortName", slaveAddress, modbusFunction, modbusStartAddress, modbusLength, dataType, pollMsec, "plcType")
# pollMsec is the polling rate with the device. It allows for I/O Intr Scan. Typically it should be set to the desired scan value.
# dataType: datatype when MODBUS_DATA specified. 0=UINT16 as default, it can be overseed also in the db file
#           Other Datypes: 4: INT16, 5: INT32_LE, 7: FLOAT32_LE, 9: FLOAT32_LE, etc. (https://millenia.cars.aps.anl.gov/software/epics/modbusDoc.html)

drvModbusAsynConfigure("read_ChlPr_256", "CHILLERPORT", 1, 3, 256, 6, 0, 1000, "read_Holding")
drvModbusAsynConfigure("read_ChlExpVPr_288", "CHILLERPORT", 1, 3, 288, 8, 0, 1000, "read_Holding")
drvModbusAsynConfigure("read_ChlMachineStatus_1280", "CHILLERPORT", 1, 3, 1280, 1, 0, 5000, "read_Holding")
drvModbusAsynConfigure("write_ChlMachineStatus_1280", "CHILLERPORT", 1, 6, 1280, 1, 0, 5000, "write_Holding")

drvModbusAsynConfigure("read_ChlSetPoint_768", "CHILLERPORT", 1, 3, 768, 6, 0, 5000, "read_Holding")
drvModbusAsynConfigure("write_ChlSetPoint_768", "CHILLERPORT", 1, 6, 768, 1, 0, 5000, "write_Holding")

drvModbusAsynConfigure("read_ChlRelayStatus_2048", "CHILLERPORT", 1, 3, 2048, 10, 0, 5000, "read_Holding")

drvModbusAsynConfigure("read_ChlAlarms_3328", "CHILLERPORT", 1, 3, 3328, 12, 0, 5000, "read_Holding")
drvModbusAsynConfigure("read_ChlCompWH_3584", "CHILLERPORT", 1, 3, 3584, 1, 0, 5000, "read_Holding")
drvModbusAsynConfigure("read_ChlEvapWH_3590", "CHILLERPORT", 1, 3, 3590, 1, 0, 5000, "read_Holding")

#Load Records
dbLoadRecords("$(TOP)/dqApp/Db/chiller.db","P='DQ:CHL'")

#####################
##### BLUEFORS ######
#####################

# Defining differt port avoid parsing all input in every PV (for SCAN=IO Intr.)
#drvAsynIPPortConfigure("bf_mpbf","192.168.100.104:49098",0,0,1)
#drvAsynIPPortConfigure("bf_cpa","192.168.100.104:49098",0,0,1)

#Load Records
#dbLoadRecords("$(TOP)/dqApp/Db/bf_mpbf.db","P=DQ:BF:MPBF,PORT=bf_mpbf")
#dbLoadRecords("$(TOP)/dqApp/Db/bf_cpa.db","P=DQ:BF:CPA,PORT=bf_cpa")

#####################
##### SERVICES ######
#####################

# Terminal
drvAsynIPPortConfigure("terminal","localhost:4613",0,0,0)

#Load Records
dbLoadRecords("$(TOP)/dqApp/Db/services.db","P='DQ:SYS'")

#####################
##### OPCUA Tests ###
#####################

opcuaSession( "OPC1", "opc.tcp://localhost:53880/")
# <name> <session> <interval ms> [options…]
opcuaSubscription( "SUB1", "OPC1", "200")

# Switch off security
opcuaOptions( "OPC1", "sec-mode=None")

#Load Records
dbLoadRecords("$(TOP)/dqApp/Db/opcua.db","P='OPC',SESS='OPC1',SUBS='SUB1'" )

#####################
##### DEBUG #########
#####################

#asynSetTraceMask("html", -1, 0x008)
#asynSetTraceIOMask("html", -1, 0x0001)
#asynSetTraceInfoMask("html", -1, 0x0008)

#enable debug output
#var streamDebug 1


#####################
##### IOCINIT #######
#####################


cd "${TOP}/iocBoot/${IOC}"
iocInit

## Start any sequence programs
#seq sncxxx,"user=user"
