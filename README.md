# Nexplore

This guide provides setup instructions for Windows, macOS, and Linux.

## Windows Setup

1. Install Docker Desktop. You can find the installation guide [here](https://docs.docker.com/desktop/install/windows-install/).
2. Open PowerShell and navigate to the directory containing the setup scripts.
3. Execute the `WindowSetup.ps1` script by running the following command:

```
powershell
.\WindowSetup.ps1
```

## Mac Setup

1. Install Docker Desktop. You can find the installation guide here.
2. Open Terminal and navigate to the directory containing the setup scripts.
3. Make the LinuxAndMacSetup.sh script executable and run it:

```
chmod +x LinuxAndMacSetup.sh
./LinuxAndMacSetup.sh
```

## Linux Setup

1. Open Terminal and navigate to the directory containing the setup scripts.
2. Make the k8s_setup.sh and LinuxAndMacSetup.sh scripts executable and run them:

```
chmod +x k8s_setup.sh
./k8s_setup.sh
chmod +x LinuxAndMacSetup.sh
./LinuxAndMacSetup.sh
```

Please replace WindowSetup.ps1, LinuxAndMacSetup.sh, and k8s_setup.sh with the actual paths to your setup scripts if they're located in a different directory.