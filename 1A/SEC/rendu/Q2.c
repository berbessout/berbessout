#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <string.h>
#include "readcmd.h"

int main(int argc, char *argv[]) {
    struct cmdline *l;
    int i, status;
    pid_t pid;
    while (1) {
        printf("sh-3.2$ ");
        fflush(stdout);
        l = readcmd();
        /* Si l'entrée standard est fermée, on termine normalement */
        if (!l) {
            printf("exit \n");
            exit(0);
        }
        int p[2];
        int fd_in = 0;
        /* Affichage de chaque commande  */
        for (i = 0; l->seq[i] != NULL; i++) {
                pipe(p); /* Création du tube */
                pid = fork(); /* Création du processus fils */
            if (pid == 0) {
            /* fils */
                dup2(fd_in, 0);
            if (l->seq[i+1] != NULL) {
                dup2(p[1], 1);
            }
            close(p[0]);
            execvp(l->seq[i][0], l->seq[i]);
            perror("execvp");
            exit(1);
            /* On ne devrait jamais arriver ici */
            } else if (pid < 0) {
                perror("fork");
                exit(1);
            } else {
            /* Père */
            close(p[1]);
            fd_in = p[0];
            }
        }
        while (waitpid(-1, &status, WNOHANG) > 0);
    }
    return 0;
}
