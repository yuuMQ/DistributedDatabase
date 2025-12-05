-- Sao luu FULL:
BACKUP Database CSDL1
TO DISK = N'D:\QTHCSDL\SaoLuu1file\SaoLuu_CSDL1.bak'
With Format

-- Sao luu DIFF:
BACKUP Database CSDL1
TO DISK = N'D:\QTHCSDL\SaoLuu1file\SaoLuu_CSDL1.bak'
With differential

-- Sao luu TailLOG:
BACKUP Log CSDL1
TO DISK = N'D:\QTHCSDL\SaoLuu1file\SaoLuu_CSDL1.bak'
With No_Truncate

--Phuc hoi CSDL1:
RESTORE Database CSDL1
FROM DISK = N'D:\QTHCSDL\SaoLuu1file\SaoLuu_CSDL1.bak'
With File = 1, NORECOVERY
go
RESTORE Database CSDL1
FROM DISK = N'D:\QTHCSDL\SaoLuu1file\SaoLuu_CSDL1.bak'
With File = 2, NORECOVERY
go
RESTORE log CSDL1
FROM DISK = N'D:\QTHCSDL\SaoLuu1file\SaoLuu_CSDL1.bak'
With File = 3, RECOVERY
go