#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void fetch_cheat_sheet(const char *query, int full_output) {
    char command[256];
    sprintf(command, "curl -s cheat.sh/%s", query);

    FILE *fp = popen(command, "r");
    if (fp == NULL) {
        fprintf(stderr, "Failed to run command\n");
        exit(1);
    }

    char response[4096];
    fread(response, sizeof(char), sizeof(response) - 1, fp);
    pclose(fp);

    response[sizeof(response) - 1] = '\0'; // Ensure null-terminated string

    if (full_output) {
        printf("%s", response);
    } else {
        char *tldr_part = strstr(response, "tldr:");
        if (tldr_part) {
            printf("%s", tldr_part);
        } else {
            printf("%s", response);
        }
    }
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s [-f] <query>\n", argv[0]);
        return 1;
    }

    int full_output = 0;
    const char *query;

    if (strcmp(argv[1], "-f") == 0) {
        full_output = 1;
        query = argv[2];
    } else if (argc > 2 && strcmp(argv[2], "-f") == 0) {
        full_output = 1;
        query = argv[1];
    } else {
        query = argv[1];
    }

    fetch_cheat_sheet(query, full_output);

    return 0;
}

