TITLE Assembly.asm

INCLUDE Irvine32.inc


; Prototypes
findMax PROTO, 
	arrayAddress : PTR SDWORD

findMin PROTO,
	arrayAddress : PTR SDWORD

bubbleSort PROTO,
	arrayAddress : PTR SDWORD

randomPopulate PROTO,
	arrayAddress : PTR SDWORD,
	max	: SDWORD,
	min : SDWORD

printArray PROTO,
	arrayAddress : PTR SDWORD

mulArray PROTO,
	arrayAddress : PTR SDWORD,
	mulValue : SDWORD

divArray PROTO,
	arrayAddress : PTR SDWORD,
	divValue : SDWORD

.data 
array SDWORD 20 DUP(?)
highVal SDWORD ?
lowVal SDWORD ?
multiple SDWORD ?
divisor SDWORD ?

msg1 BYTE "Maximum: ",0
msg2 BYTE "Minimum: ",0
msg3 BYTE "Bubble Sorted: ",0
msg4 BYTE "Populated array with randoms:",0
msg5 BYTE "Enter a number to multiply by: ",0
msg6 BYTE "Enter a number to divide by: ",0
msg7 BYTE "Multiplied array by number: ",0
msg8 BYTE "Divided array by number: ",0
outMsg BYTE "-----------------------------------------------------------------------------------------------------------------",0

maxRange BYTE "Enter a max value: ",0
minRange BYTE "Enter a min value: ",0
errorMsg BYTE "maxVal <= minVal. Try again!",0

openBrac BYTE "[",0
closeBrac BYTE "]",0
comma BYTE ", ",0

.code 
main PROC
	call Randomize
start:
	mov edx, OFFSET maxRange
	call WriteString
	call ReadInt
	mov highVal, eax

	mov edx, OFFSET minRange
	call WriteString
	call ReadInt
	mov lowVal, eax
	
	mov eax, highVal
	cmp eax, lowVal
	jle error
	jmp continue

error:
	mov edx, OFFSET errorMsg
	call WriteString
	call Crlf
	call Crlf
	jmp start

continue:
	mov edx, OFFSET msg5
	call WriteString
	call ReadInt
	mov multiple, eax

	mov edx, OFFSET msg6
	call WriteString
	call ReadInt
	mov divisor, eax

	mov edx, OFFSET outMsg
	call WriteString
	call Crlf

	INVOKE randomPopulate, ADDR array, highVal, lowVal
	mov edx, OFFSET msg4
	call WriteString
	INVOKE printArray, ADDR array
	call Crlf
	
	mov edx, OFFSET msg3
	call WriteString
	INVOKE bubbleSort, ADDR array
	INVOKE printArray, ADDR array
	call Crlf

	mov edx, OFFSET msg7
	call WriteString
	INVOKE mulArray, ADDR array, multiple
	INVOKE printArray, ADDR array
	call Crlf

	mov edx, OFFSET msg8
	call WriteString
	;INVOKE divArray, ADDR array, divisor
	INVOKE printArray, ADDR array
	call Crlf

	mov edx, OFFSET msg1
	call WriteString
	INVOKE findMax, ADDR array
	call WriteInt
	call Crlf
	call Crlf

	mov edx, OFFSET msg2
	call WriteString
	INVOKE findMin, ADDR array
	call WriteInt
	call Crlf
	call Crlf
	exit
main ENDP

; ----------------------------------------------------------------------------
; printArray Procedure
; ----------------------------------------------------------------------------
printArray PROC,
	address : PTR SDWORD
	
	pushad
	pushfd

	mov ecx, LENGTHOF array
	dec ecx

	; Print array
	call Crlf
	mov esi, address
	mov edx, OFFSET openBrac
	call WriteString

L1:
	mov eax, [esi]
	call WriteInt

	mov edx, OFFSET comma
	call WriteString

	add esi, TYPE DWORD
	loop L1

	mov eax, [esi]
	call WriteInt
	mov edx, OFFSET closeBrac
	call WriteString

	popfd
	popad
	call Crlf
	ret
printArray ENDP

; ----------------------------------------------------------------------------
; findMax Procedure
; ----------------------------------------------------------------------------
findMax PROC,
	address : PTR SDWORD
	LOCAL temp : DWORD

	push esi
	push ecx
	pushfd

	mov ecx, LENGTHOF array
	mov esi, address
	mov eax, [esi]
	mov temp, eax

L1:
	mov eax, [esi]
	cmp eax, temp

	jg isGreater
	jmp continue

isGreater:
	mov temp, eax

continue:
	add esi, TYPE DWORD
	loop L1

	mov eax, temp

	popfd
	pop ecx
	pop esi
	ret
findMax ENDP

; ----------------------------------------------------------------------------
; findMin Procedure
; ----------------------------------------------------------------------------
findMin PROC,
	address : PTR SDWORD
	LOCAL temp : DWORD

	push ecx
	push esi
	pushfd

	mov ecx, LENGTHOF array
	mov esi, address
	mov eax, [esi]
	mov temp, eax

L1:
	mov eax, [esi]
	cmp eax, temp

	jl isSmaller
	jmp continue

isSmaller:
	mov temp, eax

continue:
	add esi, TYPE DWORD
	loop L1

	mov eax, temp
	
	popfd
	pop esi
	pop ecx
	ret
findMin ENDP

; ----------------------------------------------------------------------------
; bubbleSort Procedure
; ----------------------------------------------------------------------------
bubbleSort PROC,
	address : PTR SDWORD 
	LOCAL temp : DWORD

	pushad
	pushfd

	mov ecx, LENGTHOF array

L1:
	push ecx
	mov esi, address
	mov ecx, LENGTHOF array

	L2:
		mov eax, [esi]
		mov ebx, [esi+4]

		cmp eax, ebx
		jg swap
		jmp continue

	swap:
		mov eax, [esi+4]
		mov temp, eax
		mov eax, [esi]
		mov [esi+4], eax
		mov eax, temp
		mov [esi], eax

	continue:
		add esi, TYPE DWORD
		loop L2

		pop ecx
		loop L1

	popfd
	popad

	ret
bubbleSort ENDP

; ----------------------------------------------------------------------------
; randomPopulate Procedure
; ----------------------------------------------------------------------------
randomPopulate PROC,
	address : PTR SDWORD,
	maxVal : SDWORD,
	minVal : SDWORD
	
	pushad
	pushfd

	mov ecx, LENGTHOF array
	mov esi, address
	
L2:
	mov eax, maxVal
	sub eax, minVal
	inc eax
	call RandomRange
	add eax, minVal

	mov [esi], eax
	add esi, TYPE DWORD
	loop L2
	
	call Crlf

	popfd
	popad

	ret
randomPopulate ENDP

; ----------------------------------------------------------------------------
; mulArray Procedure
; ----------------------------------------------------------------------------
mulArray PROC,
	address : PTR SDWORD,
	mulNum: SDWORD
	
	pushad
	pushfd

	mov ecx, LENGTHOF array
	mov esi, address
	mov ebx, mulNum

L1:
	mov eax, [esi]
	imul ebx
	mov [esi], eax
	add esi, TYPE DWORD
	loop L1
	
	popfd
	popad
	ret
mulArray ENDP

; ----------------------------------------------------------------------------
; divArray Procedure
; ----------------------------------------------------------------------------
divArray PROC,
	address : PTR SDWORD,
	divNum : SDWORD
	
	pushad
	pushfd

	mov ecx, LENGTHOF array
	mov esi, address
	mov ebx, divNum

L1:
	mov eax, [esi]
	idiv ebx
	mov [esi], edx
	add esi, TYPE DWORD
	loop L1

	popfd
	popad
	ret
divArray ENDP
END main