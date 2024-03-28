FROM mcr.microsoft.com/powershell:latest

# Set environment variables
ENV GITHUB_OWNER=""
ENV GITHUB_REPO=""
ENV INPUT_GITHUB_TOKEN=""
ENV INPUT_GITHUB_BRANCH=""

# Copy the PowerShell script into the container
COPY close-pr-excel.ps1 /close-pr-excel.ps1

# Run the PowerShell script when the container starts
# CMD ["pwsh", "-File", "/close-pr-excel.ps1"]

# CMD ["pwsh", "-File", "/close-pr-excel.ps1", "-owner", "$GITHUB_OWNER", "-repo", "$GITHUB_REPO", "-token", "$INPUT_GITHUB_TOKEN", "-base_branch", "$INPUT_GITHUB_BRANCH"]
CMD ["pwsh", "-File", "close-pr-excel.ps1 -owner "GITHUB_OWNER" -repo "GITHUB_REPO" -token "INPUT_GITHUB_TOKEN" -base_branch "INPUT_GITHUB_BRANCH""]
