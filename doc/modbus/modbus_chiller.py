# Import

from pymodbus.client import ModbusSerialClient
from pymodbus.framer import FramerType
from pymodbus.constants import Endian
from pymodbus.payload import BinaryPayloadDecoder
import time


client = ModbusSerialClient( port = "/dev/ttyUSB0",  framer = FramerType.RTU, baudrate =  9600, bytesize = 8, parity = 'N', stopbits =  1)
client.connect()

#result = client.read_holding_registers(address=256, count=8 )# , slave=1)
#result = client.read_input_registers(address=0, count=1) #, slave=1)
result = client.read_holding_registers(address=3590, count=1 )# , slave=1)
#print(result.isError())
#print(result.registers)
registers= result.registers
print(registers)

#print("Binary: {:16b}".format(registers[0]) )

client.close()

