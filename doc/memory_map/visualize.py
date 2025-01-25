import matplotlib.pyplot as plt
import numpy as np

# Convert addresses to GB for y-axis
def to_gb(addr):
    return addr / (1024 * 1024 * 1024)

# Memory regions
addresses = {
    'uart DMA base': 0xC0000000,
    'rom boot base': 0x80000000,
    'ssd load base': 0x40000000,
    'kernel memory base': 0x02000000,
    'kernel heap base': 0x01100000,
    'kernel stack base': 0x01000000,
    'mtimecmp/mtime region': 0xB0000000,
    'GPIO region': 0xA0000000,
    'uart region': 0xA0000100,
    'IIC region': 0xA0000200,
}

# Create figure
plt.figure(figsize=(12, 10))

# Plot horizontal lines for each region
x = np.array([0, 1])
for name, addr in addresses.items():
    y = [to_gb(addr), to_gb(addr)]
    plt.plot(x, y, 'b-', linewidth=1)

# Add region labels with sizes
prev_addr = 0
for i, (name, addr) in enumerate(sorted(addresses.items(), key=lambda x: x[1])):
    if i < len(addresses) - 1:
        next_addr = list(sorted(addresses.items(), key=lambda x: x[1]))[i + 1][1]
        size = next_addr - addr
        if size < 1024:  # Less than 1KB
            size_text = f"{size}B"
        else:
            size_text = f"{size/(1024*1024):.2f}MB"
        plt.text(0.3, to_gb(addr + (next_addr - addr)/2), f"{name}\n({size_text})", 
                verticalalignment='center')

# Customize plot
plt.ylim(0, 4)  # 0 to 4GB
plt.xlabel('No units')
plt.ylabel('Address (GB)')
plt.title('Memory Map Visualization')
plt.grid(True, linestyle='--', alpha=0.3)

# Remove x-axis ticks
plt.xticks([])

plt.tight_layout()