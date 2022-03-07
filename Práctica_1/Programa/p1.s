	AREA codigo, CODE, READONLY,ALIGN=2
	THUMB
	EXPORT Start
Start
	VLDR.F32 S0, = 3.141592654;valor de x
	VLDR.F32 S1, = 10;limite superior
	VLDR.F32 S2, = 1;factorial
	VLDR.F32 S3, = 2;constante 2
	VLDR.F32 S4, = 0;valor de n
	VLDR.F32 S5, = -1;constante -1
	VLDR.F32 S7, = 1;constante 1
	VLDR.F32 S9,=0;SUMATORIA
	VLDR.F32 S10, = 3;
	VLDR.F32 S11,=1
	VLDR.F32 S13,=0;constante
	VLDR.F32 S16,=1
sumatoria
	VADD.F32 S4,S7;aumenta n en 1
	VMUL.F32 S8,S4,S3;se obtiene 2n
	VADD.F32 S15,S8,S13;se copia 2n
	BL factorial;se traslada a factorial
	VADD.F32 S12,S4,S13 ;guarda en s12 el factorial
	BL potenciaa
	VADD.F32 S14,S11,S13;guarda en s14 el valor de la potencia de -1
	BL potenciab
	VADD.F32 S17,S16,S13;guarda en s16 el valor de la potencia de x
	VDIV.F32 S18,S14,S2;divide la potencia de -1 entre el factorial
	VMUL.F32 S18,S17;multiplica el valor anterior por la potencia de x
	VADD.F32 S9,S18;guarda en S9 la sumatoria hasta el momento
	VLDR.F32 S2, =1;regresa el valor del factorial a 1
	VLDR.F32 S16,=1;regresa el valor de la potencia de x a 1
	VLDR.F32 S11,=1;regresa el valor de la potencia de -1 a 1
	VCMP.F32 S4,S1; compara si n ha llegado al limite superior
	VMRS APSR_nzcv, FPSCR
	BNE sumatoria
	VADD.F32 S9,S7;Agrega a la sumatoria el valor de i para n=0;
Loop
	B Loop
factorial
	VMUL.F32 S2,S8;Se toma el valor de 2n y se multiplica por el valor que se trae del factorial
	VSUB.F32 S8,S7;se le resta un numero al valor de 2n
	VCMP.F32 S8,S7;se verifica si la expresion 2n ya es 1
	VMRS APSR_nzcv, FPSCR ;traslada las banderas de FPSCR a APSR
	BNE factorial ; repite el ciclo
	BX LR ;si ya es 1 regresa a la funcion principal
potenciaa ;potencia de -1 a la n
	VMUL.F32 S11,S5 ;multiplica -1 por el numero actual de n
	VSUB.F32 S12,S7;le resta uno al valor de n
	VCMP.F32 S12,S13 ;compara si n ha llegado a 0
	VMRS APSR_nzcv, FPSCR ;traslada las banderas de FPSCR a APSR
	BNE potenciaa ;repite el ciclo de no cumplirse la condicion
	BX LR ; regresa a la funcion principal
potenciab
	VMUL.F32 S16,S0 ; utiliza el valor de 2n y lo multiplica por el valor de x
	VSUB.F32 S15,S7 ; le resta 1 al valor de 2n
	VCMP.F32 S15,S13 ; compara si 2n ha llegado a 0
	VMRS APSR_nzcv, FPSCR ;traslada las banderas de FPSCR a APSR
	BNE potenciab ;reinicial el ciclo
	BX LR ; regresa a la funcion principal

ALIGN
END