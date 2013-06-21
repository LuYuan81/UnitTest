/*
 * testcases.c
 *
 *  Created on: 2013-5-11
 *      Author: Administrator
 */

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <CUnit.h>
#include <Automated.h>
#include <TestDB.h>
/**//*---- functions to be tested ------*/

#include "CanIf.h"

/**//*---- test cases ------------------*/
void testIQJ() {
    CanIf_InitController(0, 0);
}

void testIGJ()
{
	CanIf_InitController(0, 0);
}

void testILJ()
{
	CanIf_InitController(0, 0);
}

CU_TestInfo testcases[] = {
        {"Testing i equals j:", testIQJ},
        {"Testing i greater than j:", testIGJ},
        {"Testing i less than j:", testILJ},
        CU_TEST_INFO_NULL
};


/**//*---- test suites ------------------*/
int suite_success_init(void)
{ return 0; }

int suite_success_clean(void)
{ return 0; }

CU_SuiteInfo suites[] = {
        {"Testing the function maxi:", suite_success_init, suite_success_clean, testcases},
        CU_SUITE_INFO_NULL
};


/**//*---- setting enviroment -----------*/

void AddTests(void)
{
        assert(NULL != CU_get_registry());
        assert(!CU_is_test_running());
        /**//* shortcut regitry */

        if(CUE_SUCCESS != CU_register_suites(suites)){
                fprintf(stderr, "Register suites failed - %s ", CU_get_error_msg());
                exit(EXIT_FAILURE);
        }
}

