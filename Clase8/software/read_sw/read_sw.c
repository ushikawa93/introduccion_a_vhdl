/*
Programa mínimo para leer un PIO desde el HPS usando /dev/mem
DE10-Nano - acceso al Lightweight HPS-FPGA bridge
*/

#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <stdint.h>

// Direcciones base (hardcodeadas)
#define ALT_STM_OFST          0xFC000000
#define ALT_LWFPGASLVS_OFST   0xFF200000

#define HW_REGS_BASE          ALT_STM_OFST
#define HW_REGS_SPAN          0x04000000
#define HW_REGS_MASK          ( HW_REGS_SPAN - 1 )

// Offset del periférico PIO (cambiar según tu diseño en Platform Designer)
#define SW_PIO_BASE           0x00000000

int main() {
    int fd;
    void *virtual_base;
    volatile uint32_t *h2p_lw_pio_addr;
    int contenido_pio;
    char char_obtenido;

    // Abrir /dev/mem
    if ((fd = open("/dev/mem", (O_RDWR | O_SYNC))) == -1) {
        printf("ERROR: could not open \"/dev/mem\"\n");
        return 1;
    }

    // Mapear memoria
    virtual_base = mmap(NULL, HW_REGS_SPAN, (PROT_READ | PROT_WRITE), MAP_SHARED, fd, HW_REGS_BASE);
    if (virtual_base == MAP_FAILED) {
        printf("ERROR: mmap() failed\n");
        close(fd);
        return 1;
    }

    // Dirección al PIO
    h2p_lw_pio_addr = (volatile uint32_t *)(
        (uint8_t *)virtual_base +
        ((ALT_LWFPGASLVS_OFST + SW_PIO_BASE) & HW_REGS_MASK)
    );

    // Bucle de lectura
	while (1) {
		int contenido_pio = *h2p_lw_pio_addr;
		printf("PIO = %d\n", contenido_pio);
		usleep(500000); // 500 ms para que no inunde la consola
	}

    // Liberar memoria
    if (munmap(virtual_base, HW_REGS_SPAN) != 0) {
        printf("ERROR: munmap() failed\n");
        close(fd);
        return 1;
    }

    close(fd);
    return 0;
}
