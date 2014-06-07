/* Description: */
envShow(taskId) - Show environment for a given task

iosDevShow - Show loaded I/O Devices

iosDrvShow - Show I/O Device Driver Function Table

iosFdShow - show open File Descriptors

memShow - show memory usage statistics

moduleShow - show downloaded modules

objShowAll - show the list of all the objects in the system (semaphores, tasks, msgQs, etc...)

objShow (objectId) - show detailed information about an object

=====================================================================================================

-> iosFdShow
 fd name                                     drv
  3 /tyCo/0                                    1 in out err
  4 (socket)                                   5   
  5 /tffs/log/system.log                       3   
  6 (socket)                                   5   
  7 (dev deleted)mem:0                       n/a   
  8 /tffs/log/system.log                       3   
  9 (socket)                                   5   
 10 /tffs/pkm/rootcert.pem                     3   
 11 (socket)                                   5   
 12 /tffs/pkm/svrcertsigned.pem                3   
 13 /tffs/pkm/svrkey.pem                       3   
 14 (socket)                                   5   
 15 (socket)                                   5   
 16 stdio_pty_7c1744.M                         8   
 17 stdio_pty_7c1744.S                         7   
value = 150 = 0x96


-> devs
drv name                
  0 /null               
  1 /tyCo/0             
  3 /tffs/              
  6 host:               
  3 /ram                
  7 stdio_pty_7afb6c.S  
  8 stdio_pty_7afb6c.M  
value = 25 = 0x19

-> cd "/ram"
-> ls
diff.txt 
run_rtsh.sh 
route_list 
if_list 
route.sh 
statPhy.xml 
value = 0 = 0x0


/* Example: Create RAM disk and initialize DOS file system with default parameters */
-> pBlkDev = ramDevCreate (0, 512, 400, 400, 0)
-> dosFsMkfs ("/RAM1", pBlkDev)

/* Create and write to a file. Flush to RAM disk */
-> fd = creat("/RAM1/myFile", 2)
-> writeBuf = "This is a string.\n"
-> write(fd, writeBuf, strlen(writeBuf)+1)
-> close(fd)


/* Open file and read contents. */
-> readBuf = malloc(100)
-> fd = open("/RAM1/myFile", 2)
-> read(fd, readBuf, 100)
-> printf readBuf

/* The following call creates a new I/O device on VxWorks called mars:, which accesses files on the host system mars using RSH:   */
netDevCreate "mars:", "mars", 0

/* After a network device is created, files on that host are accessible by appending the host pathname to the device name. 
For example, the filename mars:/usr/darger/myfile refers to the file /usr/darger/myfile on the mars system. 
This file can be read and/or written exactly like a local file. For example, the following Tornado shell command opens that file for
I/O access: */
fd = open ("mars:/usr/darger/myfile", 2)



/* Setting the User ID for Remote File Access with RSH or FTP

All FTP and RSH requests to a remote system include the user name. All FTP requests include a password as well as a user name. 
From VxWorks you can specify the user name and password for remote requests by calling iam( ): */
iam ("username", "password")

/* The first argument to iam( ) is the user name that identifies you when you access remote systems. 
The second argument is the FTP password. This is ignored if RSH is being used, and can be specified as NULL or 0 (zero).

/* For example, the following command tells VxWorks that all accesses to remote systems with RSH or FTP are through user darger, 
and if FTP is used, the password is unreal: */

-> iam "darger", "unreal"
/* The VxWorks network startup routine, usrNetInit( ) in usrNetwork.c, initially sets the user name and password to those specified in 
the boot parameters. */


