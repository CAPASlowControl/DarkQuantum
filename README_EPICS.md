EPICs Notes
===========
***


Next some notes and tips for epics installation and IOC preparation are given. 

# EPICs Configuration
## PC 
This EPICs IOCs has been tested in a PC with Debian 13 with the following credentials

 - darkquantum/DarkQuantumZgz.



## Dependencies
For EPICs installation add the following packages:

```bash
sudo apt-get install gcc
sudo apt-get install g++
sudo apt-get install make
sudo apt-get install libpcre2-dev
sudo apt-get install libcrypt-dev
sudo apt-get install x11proto-dev
sudo apt-get install libx11-dev
sudo apt-get install libxext-dev
sudo apt-get install libusb-1.0-0-dev
sudo apt-get install libusb-dev
sudo apt-get install maven
sudo apt-get install openjdk-21-jdk 
sudo apt-get install postgresql-17
sudo apt-get install libxml2-dev
sudo apt-get install libtirpc-dev
sudo apt-get install re2c
sudo apt-get install procserv
sudo apt-get install sshpass

sud apt-get install python3-numpy
sudo apt-get install python3-matplotlib
sudo apt-get install python3-pyepics
```

Other task are:
 - Add user to dialout for device communication `sudo adduser <user>  dialout`
 - Install uldaq https://github.com/mccdaq/uldaq/tree/master
 - Install pcre (for StreamDevice)


## Install EPICs

Download or clone the [epics base](https://github.com/epics-base/epics-base) and support modules (most are in https://github.com/epics-modules/).

For installation select a folder (typically `/usr/local/epics/`).

Add Env variables in `/home/user/.bashrc`:

```bash
  export EPICS_ROOT=/usr/local/epics
  export EPICS_BASE=${EPICS_ROOT}/base
  export EPICS_HOST_ARCH=`${EPICS_BASE}/startup/EpicsHostArch`
  export EPICS_BASE_BIN=${EPICS_BASE}/bin/${EPICS_HOST_ARCH}
  export EPICS_BASE_LIB=${EPICS_BASE}/lib/${EPICS_HOST_ARCH}
  if [ "" = "${LD_LIBRARY_PATH}" ]; then
      export LD_LIBRARY_PATH=${EPICS_BASE_LIB}
  else
      export LD_LIBRARY_PATH=${EPICS_BASE_LIB}:${LD_LIBRARY_PATH}
  fi
  export PATH=${PATH}:${EPICS_BASE_BIN}

  export EPICS_CA_MAX_ARRAY_BYTES=1000000
  export EPICS_CA_ADDR_LIST=127.0.0.1
  export EPICS_CA_AUTO_ADDR_LIST=NO 
```
    
### Install Base

```bash
  cd /usr/local/epics/base/
  make
```

### Install Modules

Can be done downloading modules individually or with syncApps (https://github.com/EPICS-synApps/support/releases)

For synApps, edit `configure/RELEASE` and then `make release ` and `make`.

Try to use gcc-13 (apt-get install gcc-13/g++-13 and then update-alternatives). Compilation can give error with gcc14 or gcc15.
It can be solved for some modules using USR_CFLAGS += -std=c17 and USR_CXXFLAGS += -std=c++17 to CONFIG_SITE. 


For individual modules edit `configure/RELEASE` or create `RELEASE.local` in `/usr/local/epics/support`:

```bash
  SUPPORT=/usr/local/epics/support
  
  ASYN=$(SUPPORT)/asyn/
  <MODULE>=$(SUPPORT)/<module>/
  
  EPICS_BASE=/usr/local/epics/base
 ```


In ASYN it may necessary to uncomment `TIRP=YES` in `configure/CONFIG_SITE`

For PCRE in STREAMDEVICE add pcre to RELEASE, `PCRE_INCLUDE=/usr/include/`and `PCRE_LIB=/usr/lib64` to the RELEASE.
pcre (not pcre2) is usually a package in most distributions, if not it can be installed from source https://sourceforge.net/projects/pcre/


## INSTALL OPCUA

First requires also installation of Open62541 module https://github.com/open62541/open62541/issues/3248

 - tag to version 3.1.17
 - Clone submodules
 - mkdir build
 - cd build
 - build two times for static and shared libraries
 - cmake .. -DBUILD_SHARED_LIBS=ON \
         -DCMAKE_BUILD_TYPE=RelWithDebInfo \
         -DUA_ENABLE_ENCRYPTION=OPENSSL
 - make & sudo make install & rm -rf *
 - cmake .. -DBUILD_SHARED_LIBS=OFF \
         -DCMAKE_BUILD_TYPE=RelWithDebInfo \
         -DCMAKE_INTERPROCEDURAL_OPTIMIZATION=OFF \
         -DUA_ENABLE_ENCRYPTION=OPENSSL
 - make & sudo make install


For the OPCUA module https://github.com/epics-modules/opcua/, edit `configure/CONFIG_SITE`:
 
```
\# Path to the Open62541 installation
OPEN62541 = /usr/local/

OPEN62541_DEPLOY_MODE = PROVIDED
\#OPEN62541_LIB_DIR = $(OPEN62541)/lib
\#OPEN62541_SHRLIB_DIR = $(OPEN62541)/lib
\# How the Open62541 libraries were built
OPEN62541_USE_CRYPTO = YES
OPEN62541_USE_XMLPARSER = YES
```

Finally add EPICS_BASE to `configure/RELEASE` and `exampleTop/configure/RELEASE`

## Create App 

- Create app folder

```bash
  mkdir appfolder
  cd appfolder 
  makeBaseApp.pl -t ioc appname 
  makeBaseApp.pl -i -t ioc appname 
```

- Add modules in `configure/RELEASE`

```bash
    ASYN=/usr/local/epics/modules/asyn
    STREAM=/usr/local/epics/modules/stream
    <MODULE>=/usr/local/epics/modules/<module>
```

- Add db and protos in `<app>/Db` folder.

- Add cpp and dbds in `<app>/src` folder.

- Add dbd, libs and source files (c/c++) in `<app>/src/Makefile`.

- Then `make` in the `top` folder.

For ioc startup:

  ```bash
  iocBoot/iocapp/st.cmd
  ```

- For boot start-up it is possible to use `procServ` and a start-up service.

- The procServ script is defined in `epicsIOC.sh`:
 ```#!/bin/bash

- `cd /usr/local/epics/IOCs/phymotion/iocBoot/iocphymotion
procServ -L ./EpicsIoc.log 20000 ./st.cmd`
```

- Then for connecting to the IOC use `telnet localhost 20000`

- Then is possible to include the IOC with `procServ` as a service (in `/etc/systemd/system/epicsIOC.service`).

- Then copy service to `/etc/systemd/system/` and start with `systemctl start epicsIOC` or for start-up service `systemctl enable epicsIOC` 

## CSS

Once java is installed, [download](https://controlssoftware.sns.ornl.gov/css_rcp/nightly/basic-epics-4.5.0-linux.gtk.x86_64.zip), unpack and execute `css`.

## CSS Phoebus

Download/Clone from `https://github.com/ControlSystemStudio/phoebus/tags`.

Install maven, java, etc.
For Java it has been tested with openjdk21, be careful with newest versions e.g compilation with openjdk26 gives errors.

Follow installation instructions from ttps://github.com/ControlSystemStudio/phoebus/. 
If there problems during compilation tests skip them wigh `mvn -DskipTests`.

# RDB Archiver

## Install Postgressql
Install `postgressql`.

For initial access `sudo -u postgres psql`.
For other users is necessary to change the authetication in `pg_hba.conf` to md5.

The documentation on the archive database is in [Phoebus Documentation](https://control-system-studio.readthedocs.io/en/latest/services/archive-engine/doc/index.html)

## Create Database
For the database creation see the [postgres_schema.txt](https://github.com/ControlSystemStudio/phoebus/blob/master/services/archive-engine/dbd/postgres_schema.txt).

Execute the script adding the PVs that need to be archived 
```bash
INSERT INTO channel(channel_id, name) VALUES (1, 'PVNAME'); 
```

## Database Engine
Configure the archive engine with the settings.ini` file.

 - `org.csstudio.archive/url=jdbc:postgresql://localhost:5432/archive`

Run the archive_engine:

 - `archive-engine.sh -engine Demo -port 4812 -settings settings.ini`

The archiving properties are in `archive_preferences.properties`

 - write_period=30, max_repeats=60, etc 

# Alarm Server

Phoebues includes an alarm server based on kafka.

For the alarms server start-up:
 - `start_zookeeper.sh`
	- settings in zookeeper.properties
        - port 2181
 - `start_kafka.sh`
	- settings in server.properties	
        - port 9092
        - listeners=PLAINTEXT://127.0.0.1:9092
        - advertised.listeners=PLAINTEXT://127.0.0.1:9092
 - `start_alarm_server.sh`

To keep record of the alarms and alarm logger is included based on elasticsearch.

For the alarm logger start-up:
 - `./elasticsearch` (disable security)
   - Disable security in `elasticsearch.yml`
   - Port 9200
 - `alarm_logger.sh`
   - Port 8080 (reconfigured in settings.in in settings.ini)

# OTHER NOTES
For running wsl in background:

 - wsl --exec dbus-launch true
 - Then it can only be stopped using wsl --shutdown

For serial communication in WSL2 https://learn.microsoft.com/en-us/windows/wsl/connect-usb



