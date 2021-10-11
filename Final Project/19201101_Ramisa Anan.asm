.MODEL SMALL
.STACK 100H
.DATA

MSG1 DB "Input: $"
MSG2 DB "Output: $" 
COUNT DW ? 
A DB 20 DUP(?)

.CODE
MAIN PROC

MOV AX, @DATA
MOV DS, AX


;TAKING INPUT

LEA DX, MSG1
MOV AH, 9H
INT 21H 

MOV CX, 20 
MOV BX, OFFSET A
MOV AH, 1 

 
START: 
CMP AL, "#"
JE E  
INT 21H                      
MOV [BX], AL
INC BX 
INC COUNT
LOOP START
MOV CX, COUNT                 

E:
LEA SI, A


L1: 
MOV DI, SI
INC DI
 
L2:            
DEC COUNT
MOV DX, COUNT         
         
AFTER:
CMP DX,0
JLE EXIT

MOV BH,[SI]
MOV BL,[DI]
CMP BH, BL
JE NULL
JMP SKIP

NULL:
MOV [DI], "#"

SKIP:
INC DI
DEC DX
JMP AFTER

EXIT:
INC SI
LOOP L1

 
MOV AH, 2
MOV DL, 10
INT 21H

MOV DL, 13
INT 21H

MOV CX, 20
MOV BX, OFFSET A 
 

;OUTPUT PRINTING
LEA DX, MSG2
MOV AH, 9H
INT 21H 

DISPLAY:  
MOV DL,[BX] 
CMP DL, "#" 
JE SKIP2
MOV AH, 2
INT 21H
SKIP2:                      

 
INC BX
LOOP DISPLAY

MAIN ENDP