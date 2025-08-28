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
#define FIFO_ADC_BASE          0x00000010
#define FIFO_PROCESADA_BASE           0x00000018

int main() {
    int fd;
    void *virtual_base;
    volatile uint32_t *h2p_lw_fifo_adc_addr;
	volatile uint32_t *h2p_lw_fifo_procesado_addr;
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

    // Dirección a los FIFO
    h2p_lw_fifo_adc_addr = (volatile uint32_t *)(
        (uint8_t *)virtual_base +
        ((ALT_LWFPGASLVS_OFST + FIFO_ADC_BASE) & HW_REGS_MASK)
    );
	
	h2p_lw_fifo_procesado_addr = (volatile uint32_t *)(
        (uint8_t *)virtual_base +
        ((ALT_LWFPGASLVS_OFST + FIFO_PROCESADA_BASE) & HW_REGS_MASK)
    );
	
	// Lectura de FIFOS
	printf("Contenido del ADC: \n");
	for (int i = 0;i < 128; i++)	
	{
		int contenido_fifo = *h2p_lw_fifo_adc_addr;
		printf("%d, ", contenido_fifo);
	}
	
	printf("\n\nContenido procesado: \n");
	for (int i = 0;i < 128; i++)	
	{
		int contenido_fifo = *h2p_lw_fifo_procesado_addr;
		printf("%d, ", contenido_fifo);
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
