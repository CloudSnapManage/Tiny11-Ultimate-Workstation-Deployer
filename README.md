---

# 🚀 Tiny11 Ultimate Workstation Deployer

An automated, hardware-aware PowerShell orchestration script designed to transform a **Tiny11** (debloated Windows) installation into a high-performance environment for **MERN Stack Development**, **AI/ML Research**, and **Gaming**.

---

## ⚠️ Important Disclaimer & Terms of Use

**Read this carefully before proceeding:**

> **Personal Use Only:** I created this script specifically for my own personal computer and workflow. While it works perfectly on my system, I am **not responsible** for any problems, data loss, or system instability that may occur on your PC.
> **No Automatic Backups:** 🛑 **This script DOES NOT create a System Restore Point.** It is your responsibility to manually create one before execution.
> **Use at Your Own Risk:** This script is designed for **Tiny11 / Windows 11**. It performs advanced operations, including modifying **Registry keys**, changing **Power Schemes**, and altering **System Environment Variables**.
> **Recommendations:**
> * **Review the code:** I strongly advise you to read through the script and understand each command before execution.
> * **System Restore:** Always ensure you have a fresh **System Restore Point** or a full system backup before running any automated deployment scripts.
> * **Manual Verification:** I am not sure if there will be problems with your specific hardware/software configuration. By running this script, you accept full responsibility for the outcome.
> 
> 

---

## 🚀 Quick Start Deployment

Open **PowerShell as Administrator** and copy-paste the command below to begin the automated setup. This will download and execute the script directly from this repository.

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/CloudSnapManage/Tiny11-Ultimate-Workstation-Deployer/main/Ultimate_Setup.ps1'))

```

---

## 🌟 Key Features

* **Smart Hardware Detection:** Queries the system via WMI to identify CPU, NVIDIA GPU (RTX 4050), RAM, and NVMe SSD models in real-time.
* **Size-Optimized Queue:** Implements a "Small-to-Large" installation logic. Downloads micro-utilities first to maximize early success on bandwidth-constrained connections (optimized for **5MB/s**).
* **Concurrent Tooling:** Option to launch the **Chris Titus Tech (CTT) Windows Utility** in a separate thread.
* **Performance Hardening:** * Enables **Hardware Accelerated GPU Scheduling (HAGS)**.
* Activates the **Ultimate Performance** Power Scheme.
* Disables `8dot3name` creation on NVMe drives for faster file I/O.


* **Automated Verification:** Checks every installation against `$LASTEXITCODE` and logs results.

---

## 🛠 Script Architecture & Workflow

1. **Pre-Flight Audit:** Scans for existing apps to prevent redundant downloads.
2. **OS Optimization:** Applies low-level Windows tweaks to unlock the **Intel 13th Gen i7** and **RTX 4050**.
3. **Deployment:** Leverages Chocolatey with a real-time `Update-Environment` refresh.
4. **Final Hygiene:** Cleans the installation cache and alerts the user with an audio notification.

---

## 📦 Master Application List (44 Apps)

The software is installed in **Tiers** based on size to ensure the most efficient use of your 5MB/s connection.

### 🔹 Tier 1: Micro-Utilities (< 20MB)

* **System:** 7-Zip, Everything, TreeSize Free, HWInfo, OpenSSL.
* **Dev:** Git, Yarn.

### 🔹 Tier 2: Productivity & Runtimes (20MB - 150MB)

* **Media:** VLC, MPC-HC, MusicBee.
* **Communication:** Discord, WhatsApp.
* **Dev/Tools:** Postman, RDM (Redis Desktop Manager), Figma, CrystalDiskMark, MSI Afterburner.
* **System:** DirectX, VC++ Redistributables (All), WinRAR.

### 🔹 Tier 3: Dev Engines & Browsers (150MB - 600MB)

* **Browsers:** Brave, Google Chrome, Firefox, Chrome Canary.
* **Dev:** VS Code, Node.js (LTS), MongoDB Compass, Ollama (Local AI).
* **Creative/Bench:** Krita, GIMP, Cinebench, Unigine Heaven.

### 🔹 Tier 4: Hardware Drivers & Heavy Media (600MB - 2GB+)

* **Core Drivers:** NVIDIA Display Driver, Intel Chipset Software.
* **Media/AI:** K-Lite Codec Pack (Full), Kdenlive, Stability Matrix (AI Art).
* **Gaming:** Playnite, Steam, Epic Games Launcher.

### 🔹 Tier 5: Massive IDEs & SDKs (3GB+)

* **Development:** Anaconda3, OpenJDK 17, Android Studio, Android SDK.

---

## 📂 Directory Mapping

The script creates the following "Single-Folder" data zones for project management with automatic desktop shortcuts:

* `C:\Dev` — Source code for MERN & Android projects.
* `C:\AI_Models` — Weights for LLMs and Diffusion models.
* `C:\Media` — Project files for video and photo editing.
* `C:\Games` — Game library path.

---

## 🚀 Manual Usage

If you prefer to run it locally:

1. **Clone the repository:**
```bash
git clone https://github.com/CloudSnapManage/Tiny11-Ultimate-Workstation-Deployer.git

```


2. **Run PowerShell as Administrator.**
3. **Execute:**
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
.\Ultimate_Setup.ps1

```


4. Type `go` to begin.

---

## 💡 Maintenance Tip

To update all applications installed by this script in the future, simply run:

```powershell
choco upgrade all -y

```

---

## 📄 License

Distributed under the MIT License. See `LICENSE` for more information.

---

**Would you like me to create the `.github/workflows/deploy.yml` file now to automate the deployment of your blog page?**
