# change local user password
set-localuser -name <username> -password (convertto-securestring "<password>" -asplaintext -force)