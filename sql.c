#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>
#include "sql.h"

struct SqlNode* mallocNewNode() {
    struct SqlNode* pNew = (struct SqlNode*) malloc(sizeof(struct SqlNode));
    if (!pNew) {
        return pNew;
    }
    memset(pNew, 0, sizeof(*pNew));
    pNew->span = 1;
    return pNew;
}

struct SqlNode* addSon(struct SqlNode* pFather, int num, ...) {
    va_list vl;
    va_start(vl, num);
    struct SqlNode **pNext = &pFather->lpSub;
    if (!(*pNext)) {
        *pNext = va_arg(vl, struct SqlNode*);
        pFather->span += (*pNext)->span - 1;
        pNext = &((*pNext)->lpNext);
    } else {
        pNext = &((*pNext)->lpNext);
        while (*pNext) {
            pNext = &((*pNext)->lpNext);
        }
        *pNext = va_arg(vl, struct SqlNode*);
        pFather->span += (*pNext)->span;
        pNext = &((*pNext)->lpNext);
    }
    for (int i = 0; i < num - 1; ++i) {
        *pNext = va_arg(vl, struct SqlNode*);
        pFather->span += (*pNext)->span;
        pNext = &((*pNext)->lpNext);
    }
    return pFather;
}

