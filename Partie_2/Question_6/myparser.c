#include "myparser.h"

Entry *head = NULL;

void add_entry(Entry new_entry) {
    Entry *new_node = (Entry *)malloc(sizeof(Entry));
    *new_node = new_entry;
    new_node->next = NULL;
    if (head == NULL || atoi(head->addr) > atoi(new_entry.addr)) {
        new_node->next = head;
        head = new_node;
    } else {
        Entry *current = head;
        while (current->next != NULL && atoi(current->next->addr) < atoi(new_entry.addr)) {
            current = current->next;
        }
        new_node->next = current->next;
        current->next = new_node;
    }
}

void print_entries() {
    Entry *current = head;
    while (current != NULL) {
        printf("%s %05d %c\n", current->addr, current->gen, current->status);
        current = current->next;
    }
}

void free_entries() {
    Entry *current = head;
    while (current != NULL) {
        Entry *next = current->next;
        free(current->addr);
        free(current);
        current = next;
    }
}

int get_startxref_from_external(const char* filename) {
    char command[256];
    snprintf(command, sizeof(command), "../../Partie_1/Question_3/parser.bin %s", filename);
    FILE *fp = popen(command, "r");
    if (fp == NULL) {
        fprintf(stderr, "Failed to run command\n");
        return -1;
    }

    char buffer[256];
    int startxref = -1;
    while (fgets(buffer, sizeof(buffer), fp) != NULL) {
        if (sscanf(buffer, "Startxref: %d", &startxref) == 1) {
            break;
        }
    }

    pclose(fp);
    printf("Startxref trouvé : %d\n", startxref);
    return startxref;
}
