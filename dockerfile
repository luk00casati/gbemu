FROM basedev/deb:1.0

WORKDIR /app

COPY . .

#RUN apt update && apt install -y libsdl2-dev libsdl2-ttf-dev check libsubunit-dev build-essential

RUN gcc -c -fPIC /app/lib/emu.c -I/app/include
RUN gcc -c -fPIC /app/lib/cpu.c -I/app/include
RUN gcc -c -fPIC /app/lib/cart.c -I/app/include
RUN gcc -c -fPIC /app/lib/bus.c -I/app/include
RUN gcc -c -fPIC /app/lib/ram.c -I/app/include
RUN gcc -c -fPIC /app/lib/stack.c -I/app/include
RUN gcc -c -fPIC /app/lib/instructions.c -I/app/include
RUN gcc -c -fPIC /app/lib/cpu_util.c -I/app/include
RUN gcc -c -fPIC /app/lib/cpu_proc.c -I/app/include
RUN gcc -c -fPIC /app/lib/cpu_fetch.c -I/app/include

RUN gcc -shared -o libemu.so \
emu.o cpu.o cart.o bus.o cpu_util.o \
instructions.o cpu_proc.o cpu_fetch.o \
ram.o stack.o


#main
RUN gcc -c /app/src/main.c -I/app/include -o /app/src/main.o

RUN gcc -o /app/myapp /app/src/main.o /app/libemu.so -lSDL2 -lSDL2_ttf

#tests
RUN gcc -c /app/tests/check_gbe.c -I/app/include -o /app/tests/check_gbe.o

RUN gcc -o /app/mytest /app/tests/check_gbe.o /app/libemu.so -lSDL2 -lSDL2_ttf -lcheck -lsubunit -lm