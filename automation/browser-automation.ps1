# Method 1: Using Internet Explorer COM Object (Most compatible with Windows Server)
function Start-GoogleSearchIE {
    try {
        # Create Internet Explorer COM object
        $ie = New-Object -ComObject InternetExplorer.Application
        $ie.Visible = $true
        
        # Navigate to Google
        $ie.Navigate("https://www.google.com")
        
        # Wait for page to load
        while ($ie.Busy -eq $true) { Start-Sleep -Milliseconds 100 }
        while ($ie.ReadyState -ne 4) { Start-Sleep -Milliseconds 100 }
        
        # Find search box and enter text
        $searchBox = $ie.Document.getElementsByName("q")[0]
        $searchBox.value = "qlan.com"
        
        # Submit the form (hit enter)
        $searchBox.form.submit()
        
        Write-Host "Search submitted, waiting for results..."
        
        # Wait for search results to load
        while ($ie.Busy -eq $true) { Start-Sleep -Milliseconds 100 }
        while ($ie.ReadyState -ne 4) { Start-Sleep -Milliseconds 100 }
        Start-Sleep -Seconds 2  # Extra wait for dynamic content
        
        # Find and click the first result with QLAN text
        $links = $ie.Document.getElementsByTagName("a")
        $clicked = $false
        
        foreach ($link in $links) {
            if ($link.innerText -and $link.innerText -match "QLAN.*Managed IT.*Cybersecurity") {
                Write-Host "Found QLAN link: $($link.innerText)"
                $link.click()
                $clicked = $true
                break
            }
        }
        
        # If exact match not found, try broader search
        if (-not $clicked) {
            foreach ($link in $links) {
                if ($link.innerText -and $link.innerText -match "QLAN") {
                    Write-Host "Found QLAN link (broader match): $($link.innerText)"
                    $link.click()
                    $clicked = $true
                    break
                }
            }
        }
        
        # If still not found, try href matching
        if (-not $clicked) {
            foreach ($link in $links) {
                if ($link.href -and $link.href -match "qlan\.com") {
                    Write-Host "Found QLAN link by URL: $($link.href)"
                    $link.click()
                    $clicked = $true
                    break
                }
            }
        }
        
        if ($clicked) {
            Write-Host "Successfully clicked on QLAN website link!"
        } else {
            Write-Warning "Could not find QLAN link in search results"
        }
        
        # Keep browser open
        Start-Sleep -Seconds 10
        
        # Uncomment below line if you want to close browser automatically
        # $ie.Quit()
        
    } catch {
        Write-Error "Error with IE automation: $($_.Exception.Message)"
    }
}

# Method 2: Using SendKeys to simulate keystrokes (works with any browser)
function Start-GoogleSearchSendKeys {
    param(
        [string]$BrowserPath = "C:\Program Files\Internet Explorer\iexplore.exe"
    )
    
    try {
        # Load Windows Forms for SendKeys
        Add-Type -AssemblyName System.Windows.Forms
        
        # Start browser
        $process = Start-Process -FilePath $BrowserPath -ArgumentList "https://www.google.com" -PassThru
        
        # Wait for browser to start
        Start-Sleep -Seconds 3
        
        # Send keystrokes to type in search box
        [System.Windows.Forms.SendKeys]::SendWait("qlan.com")
        Start-Sleep -Milliseconds 500
        
        # Press Enter
        [System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
        
        # Wait for search results
        Start-Sleep -Seconds 3
        
        # Press Tab to navigate to first result, then Enter to click
        [System.Windows.Forms.SendKeys]::SendWait("{TAB}")
        Start-Sleep -Milliseconds 300
        [System.Windows.Forms.SendKeys]::SendWait("{TAB}")
        Start-Sleep -Milliseconds 300
        [System.Windows.Forms.SendKeys]::SendWait("{TAB}")
        Start-Sleep -Milliseconds 300
        [System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
        
        Write-Host "Navigated to first search result using SendKeys method!"
        
    } catch {
        Write-Error "Error with SendKeys method: $($_.Exception.Message)"
    }
}

# Method 3: Using Edge WebDriver (if available)
function Start-GoogleSearchEdgeDriver {
    try {
        # This requires Microsoft Edge WebDriver to be installed
        # Download from: https://developer.microsoft.com/en-us/microsoft-edge/tools/webdriver/
        
        $edgeDriverPath = "C:\WebDriver\msedgedriver.exe"  # Adjust path as needed
        
        if (-not (Test-Path $edgeDriverPath)) {
            Write-Warning "Edge WebDriver not found at $edgeDriverPath"
            return
        }
        
        # Start Edge WebDriver
        $driver = Start-Process -FilePath $edgeDriverPath -ArgumentList "--port=9515" -PassThru
        Start-Sleep -Seconds 2
        
        # Use REST API to control Edge
        $session = Invoke-RestMethod -Uri "http://localhost:9515/session" -Method Post -Body (@{
            capabilities = @{
                alwaysMatch = @{
                    "ms:edgeOptions" = @{
                        args = @("--start-maximized")
                    }
                }
            }
        } | ConvertTo-Json -Depth 3) -ContentType "application/json"
        
        $sessionId = $session.value.sessionId
        
        # Navigate to Google
        Invoke-RestMethod -Uri "http://localhost:9515/session/$sessionId/url" -Method Post -Body (@{
            url = "https://www.google.com"
        } | ConvertTo-Json) -ContentType "application/json"
        
        Start-Sleep -Seconds 2
        
        # Find search box
        $element = Invoke-RestMethod -Uri "http://localhost:9515/session/$sessionId/element" -Method Post -Body (@{
            using = "name"
            value = "q"
        } | ConvertTo-Json) -ContentType "application/json"
        
        $elementId = $element.value.ELEMENT
        
        # Type in search box
        Invoke-RestMethod -Uri "http://localhost:9515/session/$sessionId/element/$elementId/value" -Method Post -Body (@{
            text = "qlan.com"
        } | ConvertTo-Json) -ContentType "application/json"
        
        # Press Enter
        Invoke-RestMethod -Uri "http://localhost:9515/session/$sessionId/element/$elementId/value" -Method Post -Body (@{
            text = "`n"
        } | ConvertTo-Json) -ContentType "application/json"
        
        Start-Sleep -Seconds 3
        
        # Try to find and click QLAN link
        try {
            $linkElement = Invoke-RestMethod -Uri "http://localhost:9515/session/$sessionId/element" -Method Post -Body (@{
                using = "partial link text"
                value = "QLAN"
            } | ConvertTo-Json) -ContentType "application/json"
            
            $linkElementId = $linkElement.value.ELEMENT
            
            # Click the link
            Invoke-RestMethod -Uri "http://localhost:9515/session/$sessionId/element/$linkElementId/click" -Method Post -ContentType "application/json"
            
            Write-Host "Successfully clicked QLAN link using Edge WebDriver!"
        } catch {
            Write-Warning "Could not find QLAN link: $($_.Exception.Message)"
        }
        
        Start-Sleep -Seconds 10
        
        # Clean up
        Invoke-RestMethod -Uri "http://localhost:9515/session/$sessionId" -Method Delete
        Stop-Process -Id $driver.Id -Force
        
    } catch {
        Write-Error "Error with Edge WebDriver: $($_.Exception.Message)"
    }
}

# Method 4: Simple URL opening (least interactive but most reliable)
function Start-GoogleSearchSimple {
    $url = "https://www.google.com/search?q=qlan.com"
    Start-Process $url
    Write-Host "Opened Google search for qlan.com"
}

# Main execution
Write-Host "Choose automation method:"
Write-Host "1. Internet Explorer COM (Most compatible with Windows Server)"
Write-Host "2. SendKeys method (Works with any browser)"
Write-Host "3. Edge WebDriver (Requires WebDriver installation)"
Write-Host "4. Simple URL opening (Most reliable)"

$choice = Read-Host "Enter choice (1-4)"

switch ($choice) {
    "1" { Start-GoogleSearchIE }
    "2" { Start-GoogleSearchSendKeys }
    "3" { Start-GoogleSearchEdgeDriver }
    "4" { Start-GoogleSearchSimple }
    default { 
        Write-Host "Invalid choice, using Method 1 (IE COM)"
        Start-GoogleSearchIE 
    }
}