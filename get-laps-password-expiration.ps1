[CmdletBinding()]
PARAM(
    [Parameter(Mandatory=$true,HelpMessage='What computer account will we check?')][string]$TargetComputer
)
# This line adds 1600 years because of the stupid way microsoft handles time.
try {((Get-ADComputer -Identity $TargetComputer -Properties ms-mcs-admpwdexpirationtime).'ms-mcs-admpwdexpirationtime'|get-date).AddYears(1600)}
catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException] {
    throw "This computer account could not be retrieved"
}
catch { throw "Unable to retrieve expiration time" }
