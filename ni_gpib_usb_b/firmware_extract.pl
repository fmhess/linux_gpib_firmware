#!/usr/bin/perl

# process the usb snoop log with the something like the following egrep command before processing with this script
# egrep -A1 '(Value|TransferBufferMDL)' ./ni-usb-b-initialiation-log.txt | egrep '(Value|00:)' > /tmp/stage2
# You will then need to discard the first 5 lines (everything above the first write of "1" to the cpu
# control register at address 0x7f92), and break the output into two files.  Everything prior to the write of
# zero to 0x7f92 is the second stage loader, everything after that is the actual firmware (with the
# exception of some writes to the 0x7f92 which will be discarded by this script).
# Some older versions of fxload will choke on the firmware file unless you add a garbage character to
# the end of each line.  This can be accomplished by using the "flip" program to convert the firmware
# file to use DOS end-of-line characters.

while (<>) {
   $data = $_;
   $data = substr($data,14);
   $data =~ s/ //g;
   $data =~ tr/a-z/A-Z/;
   chop $data;
   $addr = <>;
   $addr = substr($addr,32,4);
   $addr =~ tr/a-z/A-Z/;

   # ignore writes to cpu control register, fxload handles this for us
   if($addr eq "7F92") { 
      next; 
   }
   $len = (length $data) / 2;
   $len = sprintf '%02x', $len;
   $out = $len.$addr."00".$data;

   $cc = 0;
   for ($x = 0; $x < (length $out)/2; $x++) {
      $cc = $cc + hex substr $out, 2*$x, 2;
   }

   print ":".$out;
   $cc = sprintf "%02x\n", ($cc & 255) ^ 255;
   $cc =~ tr/a-z/A-Z/;
   print $cc;
}
print ":00000001FF\n";

