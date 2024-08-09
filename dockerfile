FROM basedev/deb:1.0

WORKDIR /app

COPY . .

RUN gcc -c -fPIC /app/lib/emu.c -I/app/include
RUN gcc -c -fPIC /app/lib/cpu.c -I/app/include
RUN gcc -c -fPIC /app/lib/cart.c -I/app/include
RUN gcc -c -fPIC /app/lib/bus.c -I/app/include
RUN gcc -c -fPIC /app/lib/ram.c -I/app/include
RUN gcc -c -fPIC /app/lib/stack.c -I/app/include
RUN gcc -c -fPIC /app/lib/ui.c -I/app/include
RUN gcc -c -fPIC /app/lib/io.c -I/app/include
RUN gcc -c -fPIC /app/lib/dbg.c -I/app/include
RUN gcc -c -fPIC /app/lib/timer.c -I/app/include
RUN gcc -c -fPIC /app/lib/dma.c -I/app/include
RUN gcc -c -fPIC /app/lib/ppu.c -I/app/include
RUN gcc -c -fPIC /app/lib/instructions.c -I/app/include
RUN gcc -c -fPIC /app/lib/interrupts.c -I/app/include
RUN gcc -c -fPIC /app/lib/cpu_util.c -I/app/include
RUN gcc -c -fPIC /app/lib/cpu_proc.c -I/app/include
RUN gcc -c -fPIC /app/lib/cpu_fetch.c -I/app/include

RUN gcc -shared -O2 -g -o libemu.so \
emu.o cpu.o cart.o bus.o cpu_util.o \
instructions.o cpu_proc.o cpu_fetch.o \
ram.o stack.o interrupts.o ui.o dbg.o \
io.o timer.o dma.o ppu.o

#main
RUN gcc -o /app/myapp /app/src/main.c /app/libemu.so \
-lSDL2 -lSDL2_ttf -I/app/include -O2 -Wall -Wextra -Werror \
-pedantic -ansi -g

#tests
RUN gcc -o /app/mytest /app/tests/check_gbe.c /app/libemu.so \
-lSDL2 -lSDL2_ttf -lcheck -lsubunit -lm -I/app/include -O2 \
-Wall -Wextra -Werror -pedantic -std=c99 -g