/* $Id: ex05.mc,v 2.1 2005/06/14 22:16:48 jls Exp $ */

/*
 * Copyright 2005 SRC Computers, Inc.  All Rights Reserved.
 *
 *	Manufactured in the United States of America.
 *
 * SRC Computers, Inc.
 * 4240 N Nevada Avenue
 * Colorado Springs, CO 80907
 * (v) (719) 262-0213
 * (f) (719) 262-0223
 *
 * No permission has been granted to distribute this software
 * without the express permission of SRC Computers, Inc.
 *
 * This program is distributed WITHOUT ANY WARRANTY OF ANY KIND.
 */

#include <libmap.h>


void subr (int64_t I0[], int n0, int n1, int64_t *res, int64_t *time, int mapnum) {
    OBM_BANK_A (AL, int64_t, MAX_OBM_SIZE)
    int64_t t0, t1, v, accum;
    int i, j, sz;

    sz = n0 * n1;

    buffered_dma_cpu (CM2OBM, PATH_0, AL, MAP_OBM_stripe(1,"A"), I0, 1, sz*sizeof(int64_t));

    read_timer (&t0);

    accum = 0;
    for (i=0; i<n0; i++)
        for (j=0; j<n1; j++) {
	    v = AL[i*n1+j];
	    cg_accum_add_64 (v, v<128, 0, (i==0)&(j==0), &accum);
	    }

    *res = accum;

    read_timer (&t1);
    *time = t1 - t0;
    }
