#pragma once
#ifndef __SQL_H
#define __SQL_H
struct SqlNode {
    int type;
    int span;
    char text[128];
    struct SqlNode *lpNext; // 指向同一层下一个节点
    struct SqlNode *lpSub;  // 指向子节点
};

struct SqlNode* mallocNewNode();
struct SqlNode* addSon(struct SqlNode* pFather, int num, ...);

#endif
