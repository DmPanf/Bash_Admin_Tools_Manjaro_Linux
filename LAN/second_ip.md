To configure a second IP address on a port for a second subnet in Manjaro Linux, you would use `systemd-networkd`. Here’s a high-level overview of the steps you’d need to take:

1. **Disable NetworkManager** (if you are using it) to prevent it from interfering with your manual configurations:
   ```bash
   sudo systemctl disable --now NetworkManager.service
   ```

2. **Determine the name of your network device** using the `ip a` command.

3. **Create or edit a network configuration file** for your device within `/etc/systemd/network/`. For example, if your network device is named `enp0s3`, you would create or edit the file `/etc/systemd/network/enp0s3.network`.

4. **Edit the configuration file** to include the additional IP address and the appropriate subnet. Here's an example configuration that sets a static IP address:

   ```ini
   [Match]
   Name=enp0s3

   [Network]
   Address=192.168.1.101/24
   Address=192.168.2.101/24  # This is the second IP address for the second subnet.
   Gateway=192.168.1.1
   DNS=208.67.222.222
   DNS=208.67.220.220
   ```

5. **Start and enable `systemd-networkd`** to apply the changes:
   ```bash
   sudo systemctl enable --now systemd-networkd.service
   ```

Replace `192.168.1.101/24` with your primary IP address and subnet, and `192.168.2.101/24` with your secondary IP address and subnet. Make sure the `Name=` matches the actual interface name you want to configure.

Please note, you must have root privileges to edit these files, and you should customize the IP addresses and subnet masks to fit your network configuration【26†source】.
