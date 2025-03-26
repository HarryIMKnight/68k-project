*-----------------------------------------------------------
* Title      : Calculator Program
* Written by : Harry Knight
* Date       : 26/03/25
* Description: Simple Calculator App
*-----------------------------------------------------------

* PROGRAM CONSTANTS
CR              EQU     $0D     * Carriage return
LF              EQU     $0A     * Line feed

* START OF PROGRAM
        ORG     $1000
START:
        * Display welcome message
        LEA     WELCOME_MSG,A1
        MOVE.B  #14,D0
        TRAP    #15

* INPUT FIRST NUMBER
INPUT_NUM1:
        LEA     PROMPT_NUM1,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        * Read first number
        MOVE.B  #4,D0
        TRAP    #15
        MOVE.L  D1,D5           * Store first number in D5

* INPUT SECOND NUMBER
INPUT_NUM2:
        LEA     PROMPT_NUM2,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        * Read second number
        MOVE.B  #4,D0
        TRAP    #15
        MOVE.L  D1,D6           * Store second number in D6

* INPUT OPERATION
INPUT_OP:
        LEA     PROMPT_OP,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        * Read operation
        MOVE.B  #4,D0
        TRAP    #15
        MOVE.B  D1,D7           * Store operation in D7

* PERFORM CALCULATION
CALCULATE:
        * Compare and execute operation
        CMP.B   #'+',D7
        BEQ     ADD_NUMS
        CMP.B   #'-',D7
        BEQ     SUB_NUMS
        CMP.B   #'*',D7
        BEQ     MUL_NUMS
        CMP.B   #'/',D7
        BEQ     DIV_NUMS
        
        * Invalid operation handler
        BRA     INVALID_OP

* ADDITION SUBROUTINE
ADD_NUMS:
        MOVE.L  D5,D1
        ADD.L   D6,D1
        BRA     DISPLAY_RESULT

* SUBTRACTION SUBROUTINE
SUB_NUMS:
        MOVE.L  D5,D1
        SUB.L   D6,D1
        BRA     DISPLAY_RESULT

* MULTIPLICATION SUBROUTINE
MUL_NUMS:
        MOVE.L  D5,D1
        MULS    D6,D1
        BRA     DISPLAY_RESULT

* DIVISION SUBROUTINE
DIV_NUMS:
        * Check for division by zero
        CMP.L   #0,D6
        BEQ     DIV_ZERO
        
        MOVE.L  D5,D1
        DIVS    D6,D1
        BRA     DISPLAY_RESULT

* DISPLAY RESULT
DISPLAY_RESULT:
        * Display result message
        LEA     RESULT_MSG,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        * Convert and display numeric result
        MOVE.B  #3,D0
        TRAP    #15

        * New line
        LEA     NEWLINE,A1
        MOVE.B  #14,D0
        TRAP    #15

        BRA     EXIT

* ERROR HANDLING
INVALID_OP:
        LEA     ERR_OP_MSG,A1
        MOVE.B  #14,D0
        TRAP    #15
        BRA     EXIT

DIV_ZERO:
        LEA     ERR_DIV_ZERO,A1
        MOVE.B  #14,D0
        TRAP    #15

* PROGRAM EXIT
EXIT:
        MOVE.B  #9,D0
        TRAP    #15

* DATA SECTION
* Message strings
WELCOME_MSG     DC.B    'Simple Calculator Program',CR,LF,0
PROMPT_NUM1     DC.B    'Enter first number: ',0
PROMPT_NUM2     DC.B    'Enter second number: ',0
PROMPT_OP       DC.B    'Enter operation (+,-,*,/): ',0
RESULT_MSG      DC.B    'Result: ',0
NEWLINE         DC.B    CR,LF,0

* ERROR MESSAGES
ERR_OP_MSG      DC.B    'Invalid operation!',CR,LF,0
ERR_DIV_ZERO    DC.B    'Error: Division by zero!',CR,LF,0

        END     START

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
