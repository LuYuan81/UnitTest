/*
 * teststubs.c
 *
 *  Created on: 2013-5-27
 *      Author: Administrator
 */

#include "CanIf.h"
#include "Can.h"
#include "PduGlobals.h"
void PduR_CanIfRxIndication(PduIdType CanRxPduId,const uint8* CanSduPtr) {
	return;
}

void PduR_CanIfTxConfirmation(PduIdType CanTxPduId) {
	return;
}
