# Makefile to execute all the commands for terminal 

NAME=esp32-20171017-v1.9.2-279-g090b6b80.bin

deploy:
	wget -c http://micropython.org/resources/firmware/${NAME}
	esptool.py -p /dev/ttyUSB0 -b 460800 erase_flash
	esptool.py -p /dev/ttyUSB0 -b 460800 write_flash --flash_mode dio 0x1000 ${NAME}
	sleep 5
	#make sure you have ampy installed
    pip install adafruit-ampy # to install ampy 
	ampy -p /dev/ttyUSB0 put main.py
	ampy -p /dev/ttyUSB0 put boot.py
	echo "Press reset button on the board to reload the scripts"
	picocom -b115200 /dev/ttyUSB0

console:
	echo 
	picocom -b115200 /dev/ttyUSB0
