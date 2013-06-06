#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/stat.h>

void main (int argc, char *argv[])
{
	int fd, i;
	struct stat st;
	char *addr;
	int PageSize;

	if ( (PageSize = sysconf(_SC_PAGE_SIZE)) < 0) 
	{
	    perror("sysconf() Error=");
	    exit(-1);
	}

	
	// Comprobamos tener dos argumentos
	if(argc != 2)
	{
		fprintf(stderr, "Usage: %s name_of_file\n", argv[0]);
		exit(1);
	}
	// Obtenemos el tamaño del fichero 
	if(stat(argv[1], &st) == -1)
	{
		perror("stat");
		exit(2);
	}
	// Abrimos el fichero 
	fd = open(argv[1], O_RDWR);
	if(fd == -1)
	{
		perror("open");
		exit(3);
	}
	// Proyectamos el fichero en memoria
	addr = (char *)mmap(NULL, st.st_size, PROT_WRITE, MAP_SHARED, fd, (off_t) 0);
	if(addr == MAP_FAILED)
	{
		perror("mmap");
		close(fd);
		exit(4);
	}
	const char* texto = "El fichero ha sido modificado";
	for(i=0; i<st.st_size; i++)
	{;
		addr[i] = '\0';
	}
	strcpy(addr, texto);
	// Cerramos el fichero
	close(fd);
	// Liberamos el fichero volcado en memoria
	if(munmap(addr, st.st_size) == -1)
	{
		perror("munmap");
		close(fd);
		exit(5);
	}
	exit(0);
}
