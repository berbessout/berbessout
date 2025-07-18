#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <string.h>
#include "readcmd.h"

int execute_command(char** cmd, char *backgrounded) {
    if (strcmp(cmd[0], "cd") == 0) {
        if (cmd[1] == NULL) {
            /* cd sans argument => on va dans le répertoire personnel */
            fprintf(stderr, "cd: argument manquant\n"); 
            return 1;
        }
        if (chdir(cmd[1]) != 0) {
            perror("cd");
            return 1;
        }
        return 0;
    }
    else if (strcmp(cmd[0], "exit") == 0) {
        exit(0);
    }
    else {
        pid_t pid;
        int status;
        pid = fork();
        if (pid == 0) {
            /* Fils */
            execvp(cmd[0], cmd);
            perror("execvp");
            exit(1);
        }
        else if (pid < 0) {
            /* erreur */
            perror("fork");
            return 1;
        }
        else {
            /* Père */
            if (backgrounded != NULL) {
                //rien
            } else {
                waitpid(pid, &status, 0);
            }
            return WIFEXITED(status) ? WEXITSTATUS(status) : 1;
        }
    }
}

int main(int argc, char *argv[]) {
    struct cmdline *l;
    int i, status;
    while (1) {
        printf("sh-3.2$ ");
        fflush(stdout);
        l = readcmd();
        /* Si l'entrée standard est fermée, on termine normalement */
        if (!l) {
            printf("exit \n");
            exit(0);
        }
        /* Affichage de chaque commande  */
        for (i = 0; l->seq[i] != NULL; i++) {
            char **cmd = l->seq[i];
            status = execute_command(cmd, l->backgrounded);
        }
    }
    return 0;
}