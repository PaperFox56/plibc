#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>

int main(int argc, char **argv) {
    if (argc > 1)
        _Exit(argc);
    return 0;
}