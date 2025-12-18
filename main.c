#include "classicslive-integration/cl_test.h"

#include <libdragon.h>

int main(void)
{
  /* Initialize console */
  rdpq_init();
  console_init();
  console_set_render_mode(RENDER_AUTOMATIC);
  console_clear();

  /* Run Classics Live integration test */
  cl_test();
}
