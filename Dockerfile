FROM mcr.microsoft.com/powershell:latest


COPY close-pr-excel.ps1 /close-pr-excel.ps1


CMD ["pwsh", "-File", "/close-pr-excel.ps1"]
