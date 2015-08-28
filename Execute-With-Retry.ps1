<#
https://gist.github.com/alexbevi/34b700ff7c7c53c7780b
This function can be used to pass a ScriptBlock (closure) to be executed and returned.

The operation retried a few times on failure, and if the maximum threshold is surpassed, the operation fails completely.

Params:
    Command         - The ScriptBlock to be executed
    RetryDelay      - Number (in seconds) to wait between retries
                      (default: 5)
    MaxRetries      - Number of times to retry before accepting failure
                      (default: 3)
    VerboseOutput   - More info about internal processing
                      (default: false)
Examples:

Execute-With-Retry { $connection.Open() }
$result = Execute-With-Retry -RetryDelay 1 -MaxRetries 2 { $command.ExecuteReader() }
#>
function Execute-With-Retry {
    [CmdletBinding()]
    param(
    [Parameter(ValueFromPipeline,Mandatory)]
    $Command,
    $RetryDelay = 5,
    $MaxRetries = 3,
    $VerboseOutput = $false
    )

    $currentRetry = 0
    $success = $false
    $cmd = $Command.ToString()

    do {
        try
        {
            $result = & $Command
            $success = $true
            if ($VerboseOutput -eq $true) {
                $Host.UI.WriteDebugLine("Successfully executed [$cmd]")
            }

            return $result
        }
        catch [System.Exception]
        {
            $currentRetry = $currentRetry + 1

            if ($VerboseOutput -eq $true) {
                $Host.UI.WriteErrorLine("Failed to execute [$cmd]: " + $_.Exception.Message)
            }

            if ($currentRetry -gt $MaxRetries) {
                throw "Could not execute [$cmd]. The error: " + $_.Exception.ToString()
            } else {
                if ($VerboseOutput -eq $true) {
                    $Host.UI.WriteDebugLine("Waiting $RetryDelay second(s) before attempt #$currentRetry of [$cmd]")
                }
                Start-Sleep -s $RetryDelay
            }
        }
    } while (!$success);
}
