kerneltext = 'v2.0 raw\n'

with open('./objs/test.bin',mode='rb') as f:
    bts = f.read()
    hexs = bts.hex(' ').split(' ')
    i = 0
    while i < len(hexs):
        kerneltext += f'{hexs[i]}\n'
        i += 1
    
with open('./hex/test.hex',mode='w') as f:
    f.write(kerneltext)
