#include <stdlib.h>
#include <unistd.h>

int main(int argc, char **argv) {
    if (argc > 1)
        exit(argc);
    write(1, "Hello\n", 6);
    return 0;
}