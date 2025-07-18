#include <stdio.h>    /* entrées sorties */
#include <unistd.h>   /* pimitives de base : fork, ...*/
#include <stdlib.h>   /* exit */
#include <sys/wait.h> /* wait */
#include <string.h>   /* opérations sur les chaines */
#include <fcntl.h>    /* opérations sur les fichiers */


int main(int argc, char* argv[]) {
	int desc_src, desc_dst, taille_lu;
	char tampon[BUFSIZ];
	bzero(tampon, BUFSIZ);

	if (argc != 3) {
		printf("erreur nombre d'arguments.\n");
		exit(1);
	} else {
		char* source = argv[1];
		char* destination = argv[2];
		desc_src = open(source, O_RDONLY);
		if (desc_src < 0) {
			perror("Erreur ouverture fichier a copier");
			exit(1);
		}
		desc_dst = open(destination, O_WRONLY | O_CREAT | O_TRUNC, 0640);
		if (desc_dst < 0) {
			perror("Erreur ouverture\n");
			exit(1);
		}
		do{
			taille_lu = read(desc_src, tampon, BUFSIZ);
			write(desc_dst, tampon, taille_lu);
			bzero(tampon, BUFSIZ);
		} while (taille_lu > 0);
		close(desc_src);
		close(desc_dst);
	}
	return EXIT_SUCCESS;
}
