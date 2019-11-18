     PRESERVE8 
	 THUMB 
	 AREA     factorial, CODE, READONLY
     EXPORT __main
     IMPORT printMsg
	 IMPORT printMsg2p
	 IMPORT printMsg4p
     ENTRY 
__main  FUNCTION	
; IGNORE THIS PART 	
;	    MOV  R9, #0x20000000
;		ADD  R9, #0x5
;		MOV  R4, #0x13
;		STR  R4,[R9] 
;		; IGNORE THIS PART 	
;        MOV  R9,  #0x20000000              ; Base Address
;        LDR R0, [R9, #0x5]              ; 0x5 is the offset  
;        LSL r1, r0, #1 ; shift 1 bit left
;        LSL r2, r1, #1 ; shift 1 bit left
;		MOV R0, #0x12
;		BL printMsg
;		MOV R0, #0x12
;		MOV R11, #0x13
;        BL printMsg2p
;		MOV R0, #0xAAAA
;		MOV R11, #0xBBBB
;		MOV R9, #0xCCCC
;		MOV R9, #0xDDDD
;		MOV R4, #0xEEEE
;		BL printMsg4p

		MOV R4,#0
		MOV R5,#0
		MOV R10,#360 ;number of polar co ordinates
		VLDR.F32 S13,=3.14592 ;Storing Pi value
		VLDR.F32 S14,=180 ; Storing 180 degress
		VLDR.F32 S17,=319 ; Storing x center
		VLDR.F32 S18,=239 ; Storing y center
		VLDR.F32 S19,=100 	; radius	
mainloop
		
		ADD R4,R4,R5 ;Angle in degrees
		MOV R2,R4
		VMOV.F32 R3,S19

;SINE	
		
		VMOV.F32 S0,R4; 
        VCVT.F32.U32 S0, S0;
		VMUL.F32 S0,S0, S13
		VDIV.F32 S0,S0, S14 ;Converted angle into radians
		MOV R11,#10;Number of iterations or number of elements in the series
		MOV R9,#0;Counter	
		VLDR.F32 S7,=1.0; counter in float
		VMOV.F32 S1,S0; temp variables
		VMOV.F32 S10,S0; First element of sinx is x
		VMOV.F32 S6,#-1.0;constants
		VLDR.F32 S8,=2.0;
		VLDR.F32 S9,=1.0;
		
		
loop1	VMUL.F32 S3,S1,S6; multiplying x with -1
		VMUL.F32 S3,S3,S0;	multiplying with x^2
		VMUL.F32 S3,S3,S0;
		VMUL.F32 S4,S7,S8; taking only odd multiple of counter
		VADD.F32 S5,S4,S9;
		VMUL.F32 S4,S4,S5;	
		VDIV.F32 S1,S3,S4;	Each elelement of the series
		VADD.F32 S10,S10,S1;	Sum of the whole series iterating
		VADD.F32 S7,S7,S9; Updating the counter
		ADD R9,R9,#1;
		CMP R11,R9;
		BNE loop1 
		
		
;COSINE

		MOV R9,#0;Counter
		VLDR.F32 S7,=1.0;temp variables and constants
		VMOV.F32 S1,S7;
		VMOV.F32 S11,S7;
		
		
		
loop2	VMUL.F32 S3,S1,S6; multiplying x with -1
		VMUL.F32 S3,S3,S0;	multiplying with x^2
		VMUL.F32 S3,S3,S0;
		VMUL.F32 S4,S7,S8; taking only odd multiple of counter
		VSUB.F32 S5,S4,S9;
		VMUL.F32 S4,S4,S5;
		VDIV.F32 S1,S3,S4; Each elelement of the series
		VADD.F32 S11,S11,S1; Sum of the whole series iterating
		VADD.F32 S7,S7,S9; Updating the counter
		ADD R9,R9,#1;
		CMP R11,R9;
		BNE loop2
		
		;VDIV.F32 S0,S10,S11; Final value of tan 
;polar co-ordinates

		VMOV.F32 S12,S19 ;radius
		VMUL.F32 S15,S12,S11 ;rcos
		VMUL.F32 S16,S12,S10 ;rsin
		SUB R10,#1 	
		VADD.F32 S15,S15,S17	;adding offset(center)
		VMOV.F32 R0,S15
		VADD.F32 S16,S16,S18
		VMOV.F32 R1,S16
		BL printMsg  ;print message
		MOV R5,#1
		CMP R10,#0
		BEQ Stop ;Stop the program
		B mainloop
Stop B Stop ; Stop program
     ENDFUNC
	 END
stop    B stop ; stop program
     ENDFUNC
     END 
