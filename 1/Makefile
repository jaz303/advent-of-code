ALL_SRC := $(wildcard *.s)
ALL_OBJ = $(ALL_SRC:.s=.o)

%.o: %.s
	arm-none-eabi-as -o $@ $<

%.tbin: %.elf
	arm-none-eabi-objcopy -O binary $< $@

%.bin: %.tbin
	dd if=/dev/zero of=$@ bs=4096 count=4096
	dd if=$< of=$@ bs=4096 conv=notrunc

build: solution.bin

solution.elf: $(ALL_OBJ)
	arm-none-eabi-ld -T linker.ld -o $@ $(ALL_OBJ)

obj: $(ALL_OBJ)

clean:
	rm -f *.bin *.tbin *.elf *.o

.PHONY: clean obj build