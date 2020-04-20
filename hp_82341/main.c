/* This file may be freely modified, copied, distributed or used for any 
 * purpose without restrictions. 
 * Author: Frank Mori Hess <fmhess@users.sourceforge.net>
 */
#include <stdio.h>
#include "hp_82341c_fw.h"
#include "hp_82341d_fw.h"

int main()
{
	FILE *c_file = fopen("hp_82341c_fw.bin", "w");
	fwrite(hp_82341c_firmware_data, sizeof(hp_82341c_firmware_data[0]), hp_82341c_firmware_length, c_file);
	fclose(c_file);
	FILE *d_file = fopen("hp_82341d_fw.bin", "w");
	fwrite(hp_82341d_firmware_data, sizeof(hp_82341d_firmware_data[0]), hp_82341d_firmware_length, d_file);
	fclose(d_file);
	
	return 0;
}
