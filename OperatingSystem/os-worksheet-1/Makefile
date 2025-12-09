CC=gcc
CFLAGS=-m32 -fno-pie -c
LDFLAGS=-m32 -no-pie
NASM=nasm
NASMFLAGS=-f elf -I$(SRC)/
SRC=src

ALL=task1 task1_2 task2_1 task2_2 task2_3

all: $(ALL)

# build shared objects
$(SRC)/driver.o: $(SRC)/driver.c
	$(CC) $(CFLAGS) $< -o $@

$(SRC)/asm_io.o: $(SRC)/asm_io.asm $(SRC)/asm_io.inc
	$(NASM) $(NASMFLAGS) $< -o $@

# assemble any task .asm into .o
$(SRC)/%.o: $(SRC)/%.asm $(SRC)/asm_io.inc
	$(NASM) $(NASMFLAGS) $< -o $@

# link each program
task1: $(SRC)/driver.o $(SRC)/asm_io.o $(SRC)/task1.o
	$(CC) $(LDFLAGS) $^ -o $@

task1_2: $(SRC)/driver.o $(SRC)/asm_io.o $(SRC)/task1_2.o
	$(CC) $(LDFLAGS) $^ -o $@

task2_1: $(SRC)/driver.o $(SRC)/asm_io.o $(SRC)/task2_1.o
	$(CC) $(LDFLAGS) $^ -o $@

task2_2: $(SRC)/driver.o $(SRC)/asm_io.o $(SRC)/task2_2.o
	$(CC) $(LDFLAGS) $^ -o $@

task2_3: $(SRC)/driver.o $(SRC)/asm_io.o $(SRC)/task2_3.o
	$(CC) $(LDFLAGS) $^ -o $@

clean:
	rm -f $(SRC)/*.o $(ALL)
