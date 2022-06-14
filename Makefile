CC := riscv64-elf-gcc
CFLAGS := -march=rv32i -mabi=ilp32
LDFLAGS := -nostdlib -T emulsiv.ld
LIBS := $(patsubst lib/%.s,lib/%.o,$(wildcard lib/*.s))
TEST_TARGETS := $(patsubst test/%.s,test_%,$(wildcard test/*.s))

# disable weird intermediate prerequisite auto deletion behavior
.SECONDARY:

all: snake.hex

$(TEST_TARGETS): test_%: test_%.hex

%.hex: %.elf
	riscv64-unknown-elf-objcopy -O ihex $< $@

snake.elf: startup.o snake.o $(LIBS)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^

test_%.elf: startup.o lib/%.o test/%.o
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^

%.o: %.s
	$(CC) $(CFLAGS) -c -o $@ $<

.PHONY: clean

clean:
	-rm -f *.o test/*.o lib/*.o *.elf *.hex

