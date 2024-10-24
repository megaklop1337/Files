set SRVCNAME=QuickNet

net stop %SRVCNAME%
sc delete %SRVCNAME%
