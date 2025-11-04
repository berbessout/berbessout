CC=gcc
MPICC=smpicc
CFLAGS=-g -O4

all: CG_par CG_sq

clean:
	rm -rf *.o CG_par CG_sq

util_par.o: util_par.c
	echo $@
	$(MPICC) -c -Wall -o $@ $<

CG_par.o: CG_par.c
	echo $@
	$(MPICC) -c -Wall -o $@ $<

main_par.o: main_par.c
	echo $@
	$(MPICC) -c -Wall -o $@ $<

util.o: util.c
	echo $@
	$(CC) -c -Wall -o $@ $<

CG_seq.o: CG_seq.c
	echo $@
	$(CC) -c -Wall -o $@ $<

main_seq.o: main_seq.c
	echo $@
	$(CC) -c -Wall -o $@ $<

CG_par: util_par.o CG_par.o main_par.o
	$(MPICC) -o $@ $^  -lm

CG_sq: util.o CG_sq.o main_sq.o
	$(CC) -o $@ $^  -lm
