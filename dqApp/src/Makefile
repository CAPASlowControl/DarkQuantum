# SPDX-FileCopyrightText: 2003 Argonne National Laboratory
#
# SPDX-License-Identifier: EPICS

TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC = dq
# dq.dbd will be created and installed
DBD += dq.dbd

# dq.dbd will be made up from these files:
dq_DBD += base.dbd

# Include dbd files from all support applications:
dq_DBD += calcSupport.dbd
dq_DBD += asSupport.dbd
#dq_DBD += busySupport.dbd
dq_DBD += sscanSupport.dbd
dq_DBD += asyn.dbd
dq_DBD += drvAsynIPPort.dbd
dq_DBD += drvAsynSerialPort.dbd
dq_DBD += stream.dbd
dq_DBD += modbusSupport.dbd
dq_DBD += opcua.dbd
dq_DBD += system.dbd

# Add all the support libraries needed by this IOC
dq_LIBS += calc
dq_LIBS += autosave
#dq_LIBS += busy
dq_LIBS += seq
dq_LIBS += sscan
dq_LIBS += asyn
dq_LIBS += stream
dq_LIBS += modbus
dq_LIBS += opcua


# dq_registerRecordDeviceDriver.cpp derives from dq.dbd
dq_SRCS += dq_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
dq_SRCS_DEFAULT += dqMain.cpp
dq_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#dq_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
dq_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

