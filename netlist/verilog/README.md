## Collaborate with iCE-40 Board

### Intro

iCE-40 is an ...

### How to do

You need these:

* [iCESugar](https://github.com/wuxx/icesugar?tab=readme-ov-file#虚拟机镜像): 

* [nextpnr](https://github.com/YosysHQ/nextpnr): 

These are the commands that I executed on my M2 Mac in case you don't want to look at the them individually:

```zsh
mkdir ice40
cd ice40
git submodule update --init --recursive

# Install icestorm
git clone https://github.com/YosysHQ/icestorm.git
cd icestorm
make -j$(nproc) # $(nproc) uses all available CPU cores for faster compilation.
sudo make install PREFIX=/usr/local # ensure the ice tools (icepack icemulti icepll icebram icetime) are correctly installed to /usr/local

cd ..
# Install nextpnr
brew install cmake python boost eigen # nessasary packages
git clone https://github.com/YosysHQ/nextpnr.git
cd nextpnr
git submodule update --init --recursive
mkdir -p build && cd build
cmake .. -DARCH=ice40
make -j$(nproc)
sudo make install

# nextpnr-ice40 will not find a library, fix it using:
sudo install_name_tool -add_rpath /opt/homebrew/lib /usr/local/bin/nextpnr-ice40
ln -s /opt/homebrew/Cellar/python@3.12/3.12.8/Frameworks/Python.framework/Versions/3.12/lib/libpython3.12.dylib /opt/homebrew/lib/libpython3.12.dylib
nextpnr-ice40 --version # should work


```