require 'java'
require_relative 'RXTXcomm.jar'

import('gnu.io.CommPortIdentifier')
import('gnu.io.SerialPort') { 'GnuSerialPort' }
import('java.lang.System')


System.setProperty("gnu.io.rxtx.SerialPorts", "/dev/ttyACM0:/dev/ttyACM1:/dev/ttyACM2:/dev/ttyUSB0:/dev/ttyUSB1:/dev/ttyUSB2");
class ArduinoTerminal
  attr_accessor :port
  def initialize(port_name='/dev/ttyACM0')
    @port = find_port(port_name)
  end

  private
    def find_port(port_name)
      matched_ports = CommPortIdentifier.getPortIdentifiers.select do |port_identifier|
        port_identifier.name == port_name
      end
      matched_ports.first
    end
end

p ArduinoTerminal.new.port
