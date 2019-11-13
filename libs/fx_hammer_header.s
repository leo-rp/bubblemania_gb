;---------------------------------------------------------------------------------
;FX Hammer Header file for GBDK 
;(c)2000-2001 Aleksi Eeben (email: aleksi@cncd.fi)
;Ported to GBDK by Leonardo Rodriguez  https://github.com/leo-rp
;----------------------------------------------------------------------------------
        
		
		.globl  _FX_TrigFx
		.globl  _FX_StopFx
		.globl  _FX_UpdateFx
		
		

.area	_CODE

.SoundFX_Trig            =     0x4000  
.SoundFX_Stop            =     0x4003
.SoundFX_Update          =     0x4006   ; call once every frame


_FX_TrigFx:	
		LDA	HL,2(SP)
		LD	A,(HL)			 		; a = sound FX number (0 - 59)
		call  .SoundFX_Trig
		ret 

_FX_StopFx:
		call .SoundFX_Stop
		ret           

_FX_UpdateFx:
		jp	.SoundFX_Update 		; Call this once a frame