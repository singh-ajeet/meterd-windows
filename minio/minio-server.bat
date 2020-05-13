  rem This program starts the minio batch.
      @echo off 
      setlocal
      path=c:\minio;%path%
      set MINIO_ACCESS_KEY=minio
      set MINIO_SECRET_KEY=minio123
      call minio server --config-dir=c:\minio\c1 --address=:9000 >c:\minio\c1.out c:\minio\export
      endlocal