#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <string.h>
#include <signal.h>
#include "readcmd.h"

#define MAX_JOBS 100

struct job {
    int id;
    pid_t pid;
    char *cmdline;
    int state; // 0: actif, 1: suspendu
};

static int next_job_id = 1;
static struct job jobs[MAX_JOBS];

void print_job(struct job *j) {
    printf("[%d] pid=%d state=%s cmdline='%s'\n", j->id, j->pid, j->state == 0 ? "actif" : "suspendu", j->cmdline);
}

void list_jobs() {
    int i;
    for (i = 0; i < MAX_JOBS; i++) {
        if (jobs[i].pid != 0) {
            print_job(&jobs[i]);
        }
    }
}

struct job* find_job(int id) {
    int i;
    for (i = 0; i < MAX_JOBS; i++) {
        if (jobs[i].pid != 0 && jobs[i].id == id) {
            return &jobs[i];
        }
    }
    return NULL;
}

void stop_job(int id) {
    struct job *j = find_job(id);
    if (j != NULL && j->state == 0) {
        kill(j->pid, SIGTSTP);
        j->state = 1;
    }
}

void resume_job(int id) {
    struct job *j = find_job(id);
    if (j != NULL && j->state == 1) {
        kill(j->pid, SIGCONT);
        j->state = 0;
    }
}

void add_job(pid_t pid, char** cmd) {
    for (int i = 0; i < MAX_JOBS; i++) {
        if (jobs[i].id == 0) {
            jobs[i].id = next_job_id;
            jobs[i].pid = pid;
            jobs[i].state = 1;
            jobs[i].cmdline = *cmd;
            next_job_id++;
            break;
        }
    }
}

void remove_job(pid_t pid) {
    for (int i = 0; i < MAX_JOBS; i++) {
        if (jobs[i].pid == pid) {
            jobs[i].id = 0;
            jobs[i].pid = 0;
            jobs[i].state = 0;
            jobs[i].cmdline = NULL;
        }
    }
}


int execute_command(char** cmd, char *backgrounded) {
    if (strcmp(cmd[0], "cd") == 0) {
        if (cmd[1] == NULL) {
            /* cd sans argument => on va dans le répertoire personnel */
            fprintf(stderr, "cd: erreur d'argument\n"); 
            return 1;
        }
        if (chdir(cmd[1]) != 0) {
            perror("cd");
            return 1;
        }
        return 0;
    } else if (strcmp(cmd[0], "exit") == 0) {
        exit(0);
    } else if (strcmp(cmd[0], "lj") == 0) {
        /* Liste les jobs */
        list_jobs();
        return 1;
    } else if (strcmp(cmd[0], "sj") == 0) {
        /* Suspendre un job */
        if (cmd[1] == NULL) {
            printf("Usage: sj <job_id>\n");
            return 1;
        } else {
            int job_id = atoi(cmd[1]);
            stop_job(job_id);
            perror("stop_job");
            return 1;
        }
    } else if (strcmp(cmd[0], "bg") == 0) {
        /* Reprendre un job en arrière-plan */
        if (cmd[1] == NULL) {
            printf("Usage: bg <job_id>\n");
            return 1;
        } else {
            int job_id = atoi(cmd[1]);
            resume_job(job_id);
            perror("resume_job");
            return 1;
        }
    } else if (strcmp(cmd[0], "fg") == 0) {
        /* Reprendre un job en avant-plan */
        if (cmd[1] == NULL) {
            printf("Usage: fg <job_id>\n");
            return 1;
        } else {
            int job_id = atoi(cmd[1]);
            resume_job(job_id);
            perror("resume_job");
            return 1;
        }
    } else {
        pid_t pid;
        int status;
        pid = fork();
        if (pid == 0) {
            /* Fils */
            add_job(pid, cmd);
            execvp(cmd[0], cmd);
            perror("execvp");
            remove_job(pid);
            return 1;
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
            } else if (strcmp(cmd[0], "fg") == 0) {
                waitpid(atoi(cmd[1]), &status, 0);
            } else {
                waitpid(pid, &status, 0);
            }
            return WIFEXITED(status) ? WEXITSTATUS(status) : 1;
        }
    }
}

int main() {
    struct cmdline *l;
    int i;
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
            execute_command(cmd, l->backgrounded);
        }
    }
    return 0;
}