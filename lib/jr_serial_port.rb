require 'java' 
require_relative 'RXTXcomm.jar'

import('gnu.io.CommPortIdentifier')
import('gnu.io.SerialPort') { 'GnuSerialPort' }
import('java.lang.System')
#https://bugs.launchpad.net/ubuntu/+source/rxtx/+bug/367833
#https://github.com/samaaron/serial-port
#http://forum.arduino.cc/index.php?topic=106183.0
#http://rxtx.qbang.org/wiki/index.php/Discovering_comm_portss
#System.setProperty("gnu.io.rxtx.SerialPorts", "/dev/ttyACM0")
     System.setProperty("gnu.io.rxtx.SerialPorts", "/dev/ttyACM0:/dev/ttyACM1:/dev/ttyACM2:/dev/ttyUSB0:/dev/ttyUSB1:/dev/ttyUSB2");

      p 'Displaying ports' 
      CommPortIdentifier.getPortIdentifiers.each do |port_identifier|
        p port_identifier.name
      end


    //First, Find an instance of serial port as set in PORT_NAMES.
    while (portEnum.hasMoreElements()) {
      CommPortIdentifier currPortId = (CommPortIdentifier) portEnum.nextElement();
      for (String portName : PORT_NAMES) {
        if (currPortId.getName().equals(portName)) {
          portId = currPortId;
          break;
        }
      }
    }
    if (portId == null) {
      System.out.println("Could not find COM port.");
      return;
    }



class JrSerialPort
  NONE = GnuSerialPort::PARITY_NONE

  def initialize name, baud, data, stop, parity
    port_id = CommPortIdentifier.get_port_identifier name
    data = GnuSerialPort.const_get "DATABITS_#{data}"
    stop = GnuSerialPort.const_get "STOPBITS_#{stop}"
    
    @port = port_id.open 'JRuby', 500
    @port.set_serial_port_params baud, data, stop, parity
    
    @in = @port.input_stream
    @in_io = @in.to_io
    @out = @port.output_stream
  end
  
  def close
    @port.close
  end

  def write(s)
    @out.write s.to_java_bytes
  end

  def read
    @in_io.read(@in.available) || ''
  end
end
