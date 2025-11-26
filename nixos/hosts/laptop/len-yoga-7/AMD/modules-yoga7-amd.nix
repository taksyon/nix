{
  ...
}:

{

  #### AMD iGPU (Radeon 880M / 890M) quirks
  boot.kernelParams = [
    "amdgpu.sg_display=0"
    "amdgpu.dcdebugmask=0x10"
  ];

  hardware.cpu.amd.updateMicrocode = true;

}
