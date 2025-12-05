--Phuc hoi tu file SL Full:
RESTORE Database CSDL1
FROM DISK = N'D:\QTHCSDL\DemoSaoLuuPhucHoi\FULL.bak'
with norecovery

--Phuc hoi tu file SL Diff:
RESTORE Database CSDL1
FROM DISK = N'D:\QTHCSDL\DemoSaoLuuPhucHoi\DIFF.bak'
with norecovery

--Phuc hoi tu file SL Log:
RESTORE log CSDL1
FROM DISK = N'D:\QTHCSDL\DemoSaoLuuPhucHoi\LOG.bak'
with norecovery

--Phuc hoi tu file SL TailLog:
RESTORE log CSDL1
FROM DISK = N'D:\QTHCSDL\DemoSaoLuuPhucHoi\TAILLOG.bak'
with recovery