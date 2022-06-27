# change local user password
set-localuser -name ">usernme>" -password (convertto-securestring "<password>" -asplaintext -force)