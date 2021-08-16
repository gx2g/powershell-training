Write-Output "get process";
# get processes that begin with the letter 'a'
Get-Process a*;

Write-Output "get service";
# get services that begin with the letter 'a'
Get-Service a*;

# get process that begin with the letter 'a' and pipe object proerties, methods, ect
get-process a* | Get-Member;

# get process where object name equels 'notepad'
get-process | where-object {$_.name -eq "notepad"};

# get process where object name equels 'notepad' pipe stop process to close
get-process | where-object {$_.name -eq "notepad"} | stop-process;

# add () to run object first
(get-process | where-object {$_.name -eq "notepad"});

# run () object first and method 
(get-process | where-object{$_.name -eq "notepad"}).kill();

# try shortening to the left

get-process | sort-object -property name | where-object {$_.name -eq "notepad"};


get-process -name notepad | sort-object -Property name;

get-process -name notepad | sort-object -Property Id;



