<#Author       : Akash Chawla
# Usage        : Disable Storage Sense
#>

#######################################
#    Disable Storage Sense            #
#######################################
function Set-RegKey($registryPath, $registryKey, $registryValue) {
    try {
         Write-Host "*** AVD AIB CUSTOMIZER PHASE ***  Disable Storage Sense - Setting  $registryKey with value $registryValue ***"
         New-ItemProperty -Path $registryPath -Name $registryKey -Value $registryValue -PropertyType DWORD -Force -ErrorAction Stop
    }
    catch {
         Write-Host "*** AVD AIB CUSTOMIZER PHASE ***   Disable Storage Sense  - Cannot add the registry key  $registryKey *** : [$($_.Exception.Message)]"
    }
}

$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
Write-Host "***Starting AVD AIB CUSTOMIZER PHASE: Disable Storage Sense Start -  $((Get-Date).ToUniversalTime()) "

$registryPaths = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense","HKLM:\SOFTWARE\Policies\Microsoft\Windows\StorageSense"
$registryKey = "AllowStorageSenseGlobal"
$registryValue = "0"

Foreach($registryPath in $registryPaths){
    If(!(Test-Path $registryPath)) {
        New-Item -Path $registryPath -Force
    }
    Set-RegKey -registryPath $registryPath -registryKey $registryKey -registryValue $registryValue
}

$stopwatch.Stop()
$elapsedTime = $stopwatch.Elapsed
Write-Host "*** AVD AIB CUSTOMIZER PHASE: Disable Storage Sense - Exit Code: $LASTEXITCODE ***"
Write-Host "*** Ending AVD AIB CUSTOMIZER PHASE: Disable Storage Sense - Time taken: $elapsedTime "

#############
#    END    #
#############