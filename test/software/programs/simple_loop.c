__attribute__ ((naked, section(".text")))
void _enter(void)   {
    // Setup SP and GP
    // The locations are defined in the linker script
    __asm__ volatile  ("la    gp, __global_pointer$;"
                      "la    sp, _sp;"
                      "jal   zero, _start;"
                      :  /* output: none */
                      : /* input: none */
                      : /* clobbers: none */); 
    // This point will not be executed, _start() will be called with no return.
}

__attribute__((noreturn))
void _start(void)
{
  volatile int values[4] = {1, 2, 3, 4};

  while(1)
  {
    values[0] = values[1] + values[3];
    values[1] = values[3] + values[2];
    values[2] = values[0] - values[3];
    values[3] = values[2] + values[1];
  }
}