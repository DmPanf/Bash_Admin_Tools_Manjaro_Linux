`nvtop` stands for NVIDIA Top, which is an htop-like GPU monitoring tool for NVIDIA GPUs on Linux. It provides a terminal-based graphical layout that shows information about GPU utilization, memory usage, temperature, and other metrics in real-time. `nvtop` is particularly useful for sysadmins, developers, and users who need to monitor the performance of NVIDIA GPUs on a Linux system, especially in a multi-GPU setup.

Here's a quick rundown of some of the metrics you can monitor using `nvtop`:

- GPU Utilization
- Memory Utilization
- Power Usage
- Temperature
- Fan Speed
- Compute Processes
- Memory Information (used, free, total)

You can install `nvtop` from the package manager on Manjaro Linux, typically using a command like `sudo pacman -S nvtop` or you may need to pull it from the AUR (Arch User Repository) depending on its availability in the official repository.

After installing, you can simply run `nvtop` in the terminal to bring up the interface.

Note: `nvtop` requires an NVIDIA GPU and the NVIDIA System Management Interface (nvidia-smi) to be installed on your system.
