FROM mcr.microsoft.com/powershell:latest


COPY close-pr-excel.ps1 /


ENTRYPOINT ["pwsh", "-File", "/close-pr-excel.ps1"]
