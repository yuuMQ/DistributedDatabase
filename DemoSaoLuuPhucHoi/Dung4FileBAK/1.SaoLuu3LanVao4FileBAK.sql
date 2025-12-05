-- Sao luu FULL:
BACKUP Database CSDL1
TO DISK = N'D:\QTHCSDL\DemoSaoLuuPhucHoi\FULL.bak'
With Format

-- Sao luu DIFF:
BACKUP Database CSDL1
TO DISK = N'D:\QTHCSDL\DemoSaoLuuPhucHoi\DIFF.bak'
With Format, differential

-- Sao luu LOG:
BACKUP Log CSDL1
TO DISK = N'D:\QTHCSDL\DemoSaoLuuPhucHoi\LOG.bak'
With Format

-- Sao luu TailLOG:
BACKUP Log CSDL1
TO DISK = N'D:\QTHCSDL\DemoSaoLuuPhucHoi\TAILLOG.bak'
With Format, No_Truncate

