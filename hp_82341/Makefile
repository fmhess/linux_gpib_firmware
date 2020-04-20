
all: hp_82341c_fw.bin hp_82341d_fw.bin

generate_firmware: hp_82341c_fw.h hp_82341d_fw.h main.c
	gcc -Wall main.c -o generate_firmware

hp_82341c_fw.bin + hp_82341d_fw.bin: generate_firmware
	./generate_firmware

