.global _start

.section text
_start:
  addi x5, x0, 0x001
  addi x6, x5, 0x002
  addi x7, x6, 0x004
  add  x8, x5, x6
  addi x9, x8, 0x008
  addi x10, x9, 0x00F
  addi x11, x10, 0x010
  addi x12, x11, 0x020
  addi x13, x12, 0x040
  addi x14, x13, 0x080
  addi x15, x14, 0x0F0
  addi x16, x15, 0x100
  addi x17, x16, 0x200
  addi x18, x17, 0x400
  addi x19, x18, 0x080
  addi x20, x19, 0x090
  addi x21, x20, 0x488
  addi x22, x21, 0x444
  addi x23, x22, 0x222
  addi x24, x23, 0x123
  addi x25, x24, 0x432
  addi x26, x25, 0x432
  add x27, x26, x12
  add x28, x27, x14
  add x29, x28, x20
  add x30, x29, x6
  add x31, x30, x15
