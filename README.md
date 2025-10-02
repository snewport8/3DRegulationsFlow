<div align="center">
<img width="1200" height="475" alt="GHBanner" src="https://github.com/user-attachments/assets/0aa67016-6eaf-458a-adb2-6e31a0763ed6" />
</div>

# 3D Printing Guidance Decision Flow

An interactive decision flow application built with React, TypeScript, and Vite that helps users navigate Medical Device regulation decisions. 


## 🚀 Quick Start

For the fastest setup, use our automated installation scripts:

- **Windows**: Run `setup.ps1` in PowerShell
- **macOS/Linux**: Run `./setup.sh` in Terminal

Or follow the manual setup instructions below.

## 📋 Prerequisites

### Required Software

- **Node.js** (version 18.0.0 or higher)
  - Download from [nodejs.org](https://nodejs.org/)
  - Verify installation: `node --version`
- **npm** (comes with Node.js)
  - Verify installation: `npm --version`

### System Requirements

- **Operating System**: Windows 10+, macOS 10.15+, or Linux (Ubuntu 18.04+)
- **RAM**: 4GB minimum, 8GB recommended
- **Storage**: 500MB free space for dependencies
- **Network**: Internet connection required for initial setup

## 🛠️ Manual Installation

### Step 1: Clone the Repository

```bash
git clone <repository-url>
cd medical-device-guiance-decision-flow
```

### Step 2: Install Dependencies

```bash
npm install
```

### Step 3: Start Development Server

```bash
npm run dev
```

The application will be available at:
- **Local**: http://localhost:3000/
- **Network**: http://[your-ip]:3000/ (accessible from other devices on your network)

## 🏗️ Build for Production

### Development Build
```bash
npm run dev
```
Starts the development server with hot reloading.

### Production Build
```bash
npm run build
```
Creates an optimized production build in the `dist/` directory.

### Preview Production Build
```bash
npm run preview
```
Serves the production build locally for testing.

## 🔧 Configuration



### Port Configuration

The development server runs on port 3000 by default. To change this:

1. Edit `vite.config.ts`
2. Modify the `server.port` value
3. Restart the development server

## 🌐 Platform-Specific Instructions

### Windows

#### Using PowerShell (Recommended)
1. Open PowerShell as Administrator
2. Run: `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`
3. Navigate to project directory
4. Run: `.\setup.ps1`

#### Using Command Prompt
1. Install Node.js from [nodejs.org](https://nodejs.org/)
2. Open Command Prompt
3. Navigate to project directory
4. Run: `npm install`
5. Configure `.env.local` file
6. Run: `npm run dev`

### macOS

#### Using Homebrew (Recommended)
```bash
# Install Node.js via Homebrew
brew install node

# Run setup script
./setup.sh
```

#### Manual Installation
1. Download Node.js from [nodejs.org](https://nodejs.org/)
2. Install the downloaded package
3. Open Terminal
4. Navigate to project directory
5. Run setup commands

### Linux (Ubuntu/Debian)

#### Using Package Manager
```bash
# Update package list
sudo apt update

# Install Node.js and npm
sudo apt install nodejs npm

# Run setup script
./setup.sh
```

#### Using NodeSource Repository (Latest Version)
```bash
# Add NodeSource repository
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -

# Install Node.js
sudo apt-get install -y nodejs

# Run setup script
./setup.sh
```

## 🐛 Troubleshooting

### Common Issues

#### Port Already in Use
**Error**: `EADDRINUSE: address already in use :::3000`

**Solutions**:
1. Kill the process using port 3000:
   ```bash
   # Find process using port 3000
   lsof -ti:3000 | xargs kill -9  # macOS/Linux
   netstat -ano | findstr :3000   # Windows
   ```
2. Or change the port in `vite.config.ts`

#### Node.js Version Issues
**Error**: `The engine "node" is incompatible with this module`

**Solution**: Update Node.js to version 18.0.0 or higher
- Windows/macOS: Download from [nodejs.org](https://nodejs.org/)
- Linux: Use package manager or NodeSource repository



#### Permission Errors (Windows)
**Error**: `cannot be loaded because running scripts is disabled`

**Solution**: Enable script execution in PowerShell:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

#### Build Failures
**Error**: Build process fails or produces errors

**Solutions**:
1. Clear npm cache: `npm cache clean --force`
2. Delete `node_modules` and reinstall: `rm -rf node_modules && npm install`
3. Check for TypeScript errors: `npx tsc --noEmit`

### Getting Help

If you encounter issues not covered here:

1. Check the browser console for JavaScript errors
2. Review the terminal output for build errors
3. Ensure all prerequisites are properly installed


## 📁 Project Structure

```
medical-device-guiance-decision-flow/
├── components/          # React components
├── data/               # Static data files
├── services/           # Service utilities
├── scripts/            # Build and utility scripts
├── dist/               # Production build output

├── package.json        # Dependencies and scripts
├── vite.config.ts      # Vite configuration
├── tsconfig.json       # TypeScript configuration
├── setup.ps1           # Windows setup script
└── setup.sh            # Unix setup script
```

## � Deployment

### GitHub Pages (Automatic)

This project is configured for automatic deployment to GitHub Pages:

1. **Push to main branch**: Any push to the `main` or `master` branch triggers automatic deployment
2. **GitHub Actions**: The workflow builds the project and deploys to GitHub Pages
3. **Access your site**: Visit `https://[username].github.io/medical-device-guiance-decision-flow`

### Manual Deployment

To deploy manually to other platforms:

1. **Build the project**: `npm run build`
2. **Upload the `dist/` folder** to your hosting provider
3. **Configure your server** to serve the `index.html` file for all routes

## �🔄 Development Workflow

1. **Start Development**: `npm run dev`
2. **Make Changes**: Edit files in the project directory
3. **Test Changes**: View at http://localhost:3000
4. **Build for Production**: `npm run build`
5. **Test Production Build**: `npm run preview`

## 📝 Scripts Reference

| Script | Command | Description |
|--------|---------|-------------|
| Development | `npm run dev` | Start development server with hot reload |
| Build | `npm run build` | Create production build |
| Preview | `npm run preview` | Serve production build locally |
| Install | `npm install` | Install all dependencies |

---

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.
