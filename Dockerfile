# escape=`

FROM mcr.microsoft.com/windows/servercore:ltsc2019

SHELL ["cmd", "/S", "/C"]

ADD https://aka.ms/vs/15/release/vs_buildtools.exe C:\Temp\vs_buildtools.exe

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

ENTRYPOINT ["C:\\VisualStudio\\VC\\Auxiliary\\Build\\vcvarsall.bat", "amd64", "&&"]
CMD ["powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]
