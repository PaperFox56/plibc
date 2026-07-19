#include <stdlib.h>
#include <unistd.h>

int main(int argc, char **argv) {
    char buf[32] = {0};
    read(STDIN_FILENO, buf, 32);
    write(STDOUT_FILENO, "You said: ", 10);
    write(STDOUT_FILENO, buf, 32);
    return 0;
}