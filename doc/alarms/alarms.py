import sys

filew = "temp.txt"
Idw = open(filew,"a")

Idw.write("Hola\n")
Idw.write( f"{len(sys.argv):d}\n" ) 
Idw.write( f"{sys.argv}\n" ) 
Idw.close()

#command:/Accelerator/Chiller/DQ:CHL:alarmTest! {"user":"angel", "host":"localhost", "command":"acknowledge"}!
