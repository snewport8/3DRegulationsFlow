# 3D Printing Guidance Decision Flow - Windows Setup Script
# This script automates the setup process for Windows systems

param(
    [switch]$SkipNodeCheck,
    [switch]$StartServer
)

# Color functions for better output
function Write-Success { param($Message) Write-Host $Message -ForegroundColor Green }
function Write-Warning { param($Message) Write-Host $Message -ForegroundColor Yellow }
function Write-Error { param($Message) Write-Host $Message -ForegroundColor Red }
function Write-Info { param($Message) Write-Host $Message -ForegroundColor Cyan }

# Header
Write-Host "========================================" -ForegroundColor Magenta
Write-Host "3D Printing Guidance Decision Flow Setup" -ForegroundColor Magenta
Write-Host "========================================" -ForegroundColor Magenta
Write-Host ""

# Check if running as Administrator for better error handling
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
if (-not $isAdmin) {
    Write-Warning "Not running as Administrator. Some operations may require elevated privileges."
    Write-Info "If you encounter permission errors, try running PowerShell as Administrator."
    Write-Host ""
}

# Function to check if a command exists
function Test-Command {
    param($Command)
    try {
        Get-Command $Command -ErrorAction Stop | Out-Null
        return $true
    }
    catch {
        return $false
    }
}

# Function to get Node.js version
function Get-NodeVersion {
    try {
        $version = node --version 2>$null
        if ($version) {
            return $version.TrimStart('v')
        }
    }
    catch {
        return $null
    }
    return $null
}

# Function to compare versions
function Compare-Version {
    param($Version1, $Version2)
    $v1 = [System.Version]::Parse($Version1)
    $v2 = [System.Version]::Parse($Version2)
    return $v1.CompareTo($v2)
}

# Step 1: Check Node.js installation
Write-Info "Step 1: Checking Node.js installation..."

if (-not $SkipNodeCheck) {
    if (Test-Command "node") {
        $nodeVersion = Get-NodeVersion
        if ($nodeVersion) {
            $minVersion = "18.0.0"
            if ((Compare-Version $nodeVersion $minVersion) -ge 0) {
                Write-Success "✓ Node.js $nodeVersion is installed and meets requirements (>= $minVersion)"
            }
            else {
                Write-Error "✗ Node.js $nodeVersion is installed but version >= $minVersion is required"
                Write-Info "Please update Node.js from https://nodejs.org/"
                exit 1
            }
        }
        else {
            Write-Error "✗ Node.js is installed but version could not be determined"
            exit 1
        }
    }
    else {
        Write-Error "✗ Node.js is not installed"
        Write-Info "Please install Node.js from https://nodejs.org/"
        Write-Info "After installation, restart PowerShell and run this script again"
        exit 1
    }
}
else {
    Write-Warning "Skipping Node.js version check as requested"
}

# Check npm
if (Test-Command "npm") {
    $npmVersion = npm --version 2>$null
    Write-Success "✓ npm $npmVersion is available"
}
else {
    Write-Error "✗ npm is not available (should come with Node.js)"
    exit 1
}

Write-Host ""

# Step 2: Install dependencies
Write-Info "Step 2: Installing project dependencies..."

try {
    Write-Host "Running 'npm install'..." -ForegroundColor Gray
    $installOutput = npm install 2>&1
    
    if ($LASTEXITCODE -eq 0) {
        Write-Success "✓ Dependencies installed successfully"
    }
    else {
        Write-Error "✗ Failed to install dependencies"
        Write-Host $installOutput -ForegroundColor Red
        exit 1
    }
}
catch {
    Write-Error "✗ Error during npm install: $($_.Exception.Message)"
    exit 1
}

Write-Host ""

# Step 3: Project is ready
Write-Info "Step 3: Project setup complete..."
Write-Success "✓ No additional configuration needed"

Write-Host ""

# Step 4: Verify setup
Write-Info "Step 4: Verifying setup..."

try {
    Write-Host "Testing build process..." -ForegroundColor Gray
    $buildOutput = npm run build 2>&1
    
    if ($LASTEXITCODE -eq 0) {
        Write-Success "✓ Build test successful"
    }
    else {
        Write-Warning "⚠ Build test failed, but setup may still work for development"
        Write-Host $buildOutput -ForegroundColor Yellow
    }
}
catch {
    Write-Warning "⚠ Could not test build process: $($_.Exception.Message)"
}

Write-Host ""

# Step 5: Final instructions and optional server start
Write-Success "========================================="
Write-Success "Setup completed successfully!"
Write-Success "========================================="
Write-Host ""

Write-Info "Next steps:"
Write-Info "1. Start development server: npm run dev"
Write-Info "2. Open browser to: http://localhost:3000"
Write-Info "3. Build for production: npm run build"
Write-Host ""

Write-Info "Available commands:"
Write-Info "• npm run dev     - Start development server"
Write-Info "• npm run build   - Build for production"
Write-Info "• npm run preview - Preview production build"
Write-Host ""

if ($StartServer) {
    Write-Info "Starting development server..."
    Write-Host "Press Ctrl+C to stop the server" -ForegroundColor Yellow
    Write-Host ""
    npm run dev
}
else {
    $startNow = Read-Host "Would you like to start the development server now? (y/N)"
    if ($startNow -eq "y" -or $startNow -eq "Y") {
        Write-Info "Starting development server..."
        Write-Host "Press Ctrl+C to stop the server" -ForegroundColor Yellow
        Write-Host ""
        npm run dev
    }
    else {
        Write-Info "Run 'npm run dev' when you're ready to start developing!"
    }
}
