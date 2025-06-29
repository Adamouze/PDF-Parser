#ifndef MYPARSER_H
#define MYPARSER_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Entry {
    char *addr;
    int gen;
    char status;
    struct Entry *next;
} Entry;

extern Entry *head;

void add_entry(Entry new_entry);
void print_entries();
void free_entries();
int get_startxref_from_external(const char* filename);

typedef struct {
    int i;
    int n;
} Header;

#endif
