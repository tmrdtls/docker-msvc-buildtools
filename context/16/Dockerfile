# escape=`

# Use the Windows Server Core image
ARG BASE_IMAGE
FROM $BASE_IMAGE

# Restore the default Windows shell for correct batch processing.
SHELL ["cmd", "/S", "/C"]

ADD https://aka.ms/vs/16/release/vs_buildtools.exe C:\Temp\vs_buildtools.exe

# Download and install build tools
# See https://docs.microsoft.com/en-us/visualstudio/install/workload-component-id-vs-build-tools?view=vs-2019#c-build-tools
RUN C:\Temp\vs_buildtools.exe --quiet --wait --norestart --nocache `
        --installPath C:\VisualStudio `
        --add Microsoft.VisualStudio.Workload.VCTools `
        --add Microsoft.VisualStudio.Workload.MSBuildTools `
        --remove Microsoft.VisualStudio.Component.Roslyn.Compiler `
        --includeRecommended `
    && powershell.exe -Command `
        Remove-Item -Force -Recurse C:\Temp; `
        Remove-Item -Force -Recurse "${Env:TEMP}\*"; `
        Remove-Item -Force -Recurse "${Env:windir}\Temp\*"

# This entry point starts the developer command prompt and launches the PowerShell shell.
ENTRYPOINT ["C:\\VisualStudio\\VC\\Auxiliary\\Build\\vcvarsall.bat", "x64", "&&"]
CMD ["powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]
