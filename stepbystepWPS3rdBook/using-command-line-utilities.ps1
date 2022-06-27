# Running multiple Commands
ipconfig /all > tshoot.txt
# >> will append to the end of tshoot.txt
ipconfig /all >tshoot.txt; route print >>tshoot.txt

ipconfig /all >tshoot.txt; route print >>tshoot.txt; hostname >>tshoot.txt

ipconfig /all >tshoot.txt; route print >>tshoot.txt; hostname >>tshoot.txt; net satistics workstation >>tshoot.txt

ipconfig /all && route print && hostname && net statistics workstation 