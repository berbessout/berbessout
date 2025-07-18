#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <fcntl.h>

#define FILENAME "temp"

void write_numbers() {
    
}


int main() {
    pid_t pid = fork();

    if (pid < 0) {
        perror("fork");
        exit(1);
    } else if (pid == 0) {
        // child process

        int fd = open(FILENAME, O_WRONLY | O_CREAT | O_TRUNC, 0644);
    	if (fd < 0) {
        	perror("open");
        	exit(1);
    	}

    	for (int i = 1; i <= 30; i++) {
        	if (i % 10 == 1 && i != 1) {
            		lseek(fd, 0, SEEK_SET);
        	}
        	dprintf(fd, "%d\n", i);
        	sleep(1);
    	}

    	close(fd);

        exit(0);

    } else {
        // parent process
        pid_t child_pid = waitpid(pid, NULL, 0);
        if (child_pid != pid) {
            perror("waitpid");
            exit(1);
        }

        int fd = open(FILENAME, O_RDONLY);
    	if (fd < 0) {
        	perror("open");
        	exit(1);
    	}

    	char buf[256];
    	ssize_t nread;

    	while ((nread = read(fd, buf, sizeof(buf))) > 0) {
        	write(STDOUT_FILENO, buf, nread);
        	sleep(5);
    	}

    	if (nread < 0) {
        	perror("read");
    	}

    	close(fd);
    }

    return 0;
}
