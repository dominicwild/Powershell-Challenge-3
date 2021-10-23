$logFile = 'C:\Users\dwild8\OneDrive - DXC Production\Documents\Powershell\Challenges\3\log.log'
$count = 0
$errors = @()
#Get time, date and error message
Get-Content $logFile | 
    Foreach-Object {
        
        Select-String -Pattern '(\[Failed.*\]).*time\=\"([0-9]{1,2}:[0-9]{1,2}:[0-9]{1,2}\.[0-9]{1,3}[\+\-][0-9]{1,3})\"\sdate=\"([0-9][0-9]-[0-9][0-9]-[0-9]{1,4})' -InputObject $_ |
        Foreach-Object {
            $count = $count + 1
            $errorMsg, $time, $date = $_.Matches[0].Groups[1..3].Value
            if(!$errors.Contains($errorMsg)){
                $errors += ,$errorMsg
            }
            Write-Host '-' $count
            Write-Host 'The error message is: ' $errorMsg
            Write-Host 'The time of the error is ' $time
            Write-Host 'The date of the error is ' $date
            Write-Host '-'
        }
    }

    Write-Host $errors.Count 'amount of unique errors'
