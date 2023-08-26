@ECHO OFF
@REM ###########################################
@REM # Script file to run the flow 
@REM # 
@REM ###########################################
@REM #
@REM # Command line for ngdbuild
@REM #
ngdbuild -ise ../__xps/ise/system.ise -p xc3s700anfgg484-4 -nt timestamp -bm system.bmm "C:/EDK_Trial_3/implementation/system.ngc" -uc system.ucf system.ngd 

@REM #
@REM # Command line for map
@REM #
map -ise ../__xps/ise/system.ise -o system_map.ncd -pr b -ol high -timing -detail system.ngd system.pcf 

@REM #
@REM # Command line for par
@REM #
par -ise ../__xps/ise/system.ise -w -ol high system_map.ncd system.ncd system.pcf 

@REM #
@REM # Command line for post_par_trce
@REM #
trce -ise ../__xps/ise/system.ise -e 3 -xml system.twx system.ncd system.pcf 

