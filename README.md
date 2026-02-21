This is a professional **README.md** tailored for your GitHub repository. It highlights the hardware-specific optimizations for your i7/RTX 4050 build and explains the sophisticated logic of the script to potential users or employers.

---

# 🚀 Tiny11 Ultimate Workstation Deployer

An automated, hardware-aware PowerShell orchestration script designed to transform a **Tiny11** (debloated Windows) installation into a high-performance environment for **MERN Stack Development**, **AI/ML Research**, and **Gaming**.

## 🌟 Key Features

* **Smart Hardware Detection:** Queries the system via WMI to identify CPU, NVIDIA GPU (RTX 4050), RAM, and NVMe SSD models in real-time.
* **Size-Optimized Queue:** Implements a "Small-to-Large" installation logic. Downloads micro-utilities first to maximize early success on bandwidth-constrained connections (optimized for **5MB/s**).
* **Concurrent Tooling:** Option to launch the **Chris Titus Tech (CTT) Windows Utility** in a separate thread to handle OS-level debloating while the main script installs software.
* **Performance Hardening:** * Enables **Hardware Accelerated GPU Scheduling (HAGS)** via Registry.
* Activates the **Ultimate Performance** Power Scheme.
* Disables `8dot3name` creation on NVMe drives for faster file I/O.


* **Single-Folder Data Management:** Creates dedicated directories (`C:\Dev`, `C:\AI_Models`, etc.) with automatic Desktop shortcuts.
* **Deployment Analytics:** Generates a detailed post-install report showing install duration and success/fail status for every package.

---

## 🛠 Script Architecture & Workflow

The script follows a rigorous 5-Phase execution model to ensure system stability and verification.

### 1. Pre-Flight Audit

Scans the local Chocolatey registry to identify apps already installed, preventing redundant downloads. It verifies internet connectivity and calculates required storage space.

### 2. OS Optimization

Applies low-level Windows tweaks to ensure the **Intel 13th Gen i7** and **RTX 4050** are utilized to their full potential by removing power-saving bottlenecks.

### 3. Orchestrated Installation

Leverages the Chocolatey Package Manager. The script uses an `Update-Environment` function to refresh system PATH variables in real-time, allowing subsequent installers to recognize newly installed tools (e.g., Git, Node.js) immediately.

### 4. Post-Install Verification

Every installation is verified against its `$LASTEXITCODE`. Failed installations are flagged in red in the final analytics table for manual review.

### 5. Final Hygiene

Cleans the Chocolatey cache to reclaim multi-gigabyte storage space and provides an automated bridge to Device Manager for final driver confirmation.

---

## 📋 Software Stack

The script automates the installation of:

* **Drivers:** NVIDIA Display Drivers, Intel Chipset.
* **AI:** Ollama, Stability Matrix, Anaconda.
* **Dev:** Node.js (LTS), VS Code, MongoDB, Android Studio, OpenJDK.
* **Creative:** Figma, GIMP, Krita, Kdenlive.
* **Utilities:** 7-Zip, Brave, PowerToys, and more.

---

## 🚀 Usage

1. **Clone the repository:**
```bash
git clone https://github.com/your-username/tiny11-workstation-deployer.git

```


2. **Run PowerShell as Administrator.**
3. **Execute the script:**
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
.\Ultimate_Setup.ps1

```


4. Type `go` when prompted to begin the hardware-aware deployment.

---

## ⚠️ Disclaimer

This script is designed for **Tiny11/Windows 11**. It modifies registry keys and power schemes. Use at your own risk. Always ensure you have a system restore point before running automated deployment scripts.
I made this script for my system. it works perfecty and fine, i am not sure if there will be any problems with your specific systems, so please use it on your own risk or atleast see the code first before running it.
---

**Would you like me to also generate a `.gitignore` file or a specific license (like MIT) to include in your repository?**
