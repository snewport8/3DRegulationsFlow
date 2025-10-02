#!/bin/bash

# 3D Printing Guidance Decision Flow - Unix Setup Script
# This script automates the setup process for macOS and Linux systems

set -e  # Exit on any error

# Parse command line arguments
SKIP_NODE_CHECK=false
START_SERVER=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --skip-node-check)
            SKIP_NODE_CHECK=true
            shift
            ;;
        --start-server)
            START_SERVER=true
            shift
            ;;
        -h|--help)
            echo "Usage: $0 [OPTIONS]"
            echo "Options:"
            echo "  --skip-node-check    Skip Node.js version checking"
            echo "  --start-server       Start development server after setup"
            echo "  -h, --help          Show this help message"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use -h or --help for usage information"
            exit 1
            ;;
    esac
done

# Color functions for better output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m' # No Color

print_success() { echo -e "${GREEN}$1${NC}"; }
print_warning() { echo -e "${YELLOW}$1${NC}"; }
print_error() { echo -e "${RED}$1${NC}"; }
print_info() { echo -e "${CYAN}$1${NC}"; }
print_header() { echo -e "${MAGENTA}$1${NC}"; }

# Header
print_header "========================================"
print_header "3D Printing Guidance Decision Flow Setup"
print_header "========================================"
echo ""

# Detect OS
OS="unknown"
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macOS"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="Linux"
fi

print_info "Detected OS: $OS"
echo ""

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to compare versions
version_compare() {
    if [[ $1 == $2 ]]; then
        return 0
    fi
    local IFS=.
    local i ver1=($1) ver2=($2)
    # fill empty fields in ver1 with zeros
    for ((i=${#ver1[@]}; i<${#ver2[@]}; i++)); do
        ver1[i]=0
    done
    for ((i=0; i<${#ver1[@]}; i++)); do
        if [[ -z ${ver2[i]} ]]; then
            # fill empty fields in ver2 with zeros
            ver2[i]=0
        fi
        if ((10#${ver1[i]} > 10#${ver2[i]})); then
            return 1
        fi
        if ((10#${ver1[i]} < 10#${ver2[i]})); then
            return 2
        fi
    done
    return 0
}

# Step 1: Check Node.js installation
print_info "Step 1: Checking Node.js installation..."

if [[ "$SKIP_NODE_CHECK" != "true" ]]; then
    if command_exists node; then
        NODE_VERSION=$(node --version | sed 's/v//')
        MIN_VERSION="18.0.0"
        
        version_compare $NODE_VERSION $MIN_VERSION
        case $? in
            0|1)
                print_success "✓ Node.js $NODE_VERSION is installed and meets requirements (>= $MIN_VERSION)"
                ;;
            2)
                print_error "✗ Node.js $NODE_VERSION is installed but version >= $MIN_VERSION is required"
                print_info "Please update Node.js:"
                if [[ "$OS" == "macOS" ]]; then
                    print_info "  • Download from https://nodejs.org/"
                    print_info "  • Or use Homebrew: brew install node"
                else
                    print_info "  • Download from https://nodejs.org/"
                    print_info "  • Or use package manager: sudo apt install nodejs npm"
                fi
                exit 1
                ;;
        esac
    else
        print_error "✗ Node.js is not installed"
        print_info "Please install Node.js:"
        if [[ "$OS" == "macOS" ]]; then
            print_info "  • Download from https://nodejs.org/"
            print_info "  • Or use Homebrew: brew install node"
        else
            print_info "  • Download from https://nodejs.org/"
            print_info "  • Or use package manager: sudo apt install nodejs npm"
        fi
        print_info "After installation, restart your terminal and run this script again"
        exit 1
    fi
else
    print_warning "Skipping Node.js version check as requested"
fi

# Check npm
if command_exists npm; then
    NPM_VERSION=$(npm --version)
    print_success "✓ npm $NPM_VERSION is available"
else
    print_error "✗ npm is not available (should come with Node.js)"
    exit 1
fi

echo ""

# Step 2: Install dependencies
print_info "Step 2: Installing project dependencies..."

echo "Running 'npm install'..."
if npm install; then
    print_success "✓ Dependencies installed successfully"
else
    print_error "✗ Failed to install dependencies"
    exit 1
fi

echo ""

# Step 3: Project is ready
print_info "Step 3: Project setup complete..."
print_success "✓ No additional configuration needed"

echo ""

# Step 4: Verify setup
print_info "Step 4: Verifying setup..."

echo "Testing build process..."
if npm run build >/dev/null 2>&1; then
    print_success "✓ Build test successful"
else
    print_warning "⚠ Build test failed, but setup may still work for development"
fi

echo ""

# Step 5: Final instructions and optional server start
print_success "========================================="
print_success "Setup completed successfully!"
print_success "========================================="
echo ""

print_info "Next steps:"
print_info "1. Start development server: npm run dev"
print_info "2. Open browser to: http://localhost:3000"
print_info "3. Build for production: npm run build"
echo ""

print_info "Available commands:"
print_info "• npm run dev     - Start development server"
print_info "• npm run build   - Build for production"
print_info "• npm run preview - Preview production build"
echo ""

if [[ "$START_SERVER" == "true" ]]; then
    print_info "Starting development server..."
    print_warning "Press Ctrl+C to stop the server"
    echo ""
    npm run dev
else
    read -p "Would you like to start the development server now? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        print_info "Starting development server..."
        print_warning "Press Ctrl+C to stop the server"
        echo ""
        npm run dev
    else
        print_info "Run 'npm run dev' when you're ready to start developing!"
    fi
fi
