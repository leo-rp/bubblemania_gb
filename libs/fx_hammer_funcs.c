/*---------------------------------------------------------------------------------
;FX Hammer for GBDK 
;(c)2000-2001 Aleksi Eeben (email: aleksi@cncd.fi)
;Ported to GBDK by Leonardo Rodriguez  https://github.com/leo-rp
;----------------------------------------------------------------------------------
*/
#include <gb/gb.h>

//FX Hammer  Functions
//rom bank where the FX hammer is stored (0 = no sample)
UINT8 fxBank = 0;



void FX_TrigFx(UINT8 fx);
void FX_StopFX();
void FX_UpdateFx();


/*--------------------------------------------------------------------------------------
; Turns ON the Gameboy sound. 
; Use it at first if You aren't using Carillion Player
;----------------------------------------------------------------------------------------
*/

void FX_SND_ON(){
	NR52_REG = 0x80;
	NR51_REG = 0x11;
	NR50_REG = 0x77;
}

/*--------------------------------------------------------------------------------------; 
; Sets the rom bank where the FX hammer is stored (0 = no sample)
;----------------------------------------------------------------------------------------
*/
void FX_Bank(UINT8 bank){
	fxBank = bank;	
	//FX_SND_ON(); //Use it if You aren't using Carillion Player
}

/*--------------------------------------------------------------------------------------
; Call this to start playing a sound FX. Load register A with sound FX number (0 - 59). 
; This can be done at any point in your game program.
;----------------------------------------------------------------------------------------
*/

void FX_Play(UINT8 fx){		
	
	FX_TrigFx(fx);  

}

/*--------------------------------------------------------------------------------------
; Call this if you need to stop a sound FX currently playing. 
; Remember that calling Player_MusicStop doesn't affect sound FX.
;----------------------------------------------------------------------------------------
*/
void FX_Stop(){
	FX_StopFX();
}


/*--------------------------------------------------------------------------------------
; This must be called once every frame to keep the sound FX playing. 
; Right after Player_MusicUpdate is fine.
;----------------------------------------------------------------------------------------
*/

void FX_Update(){
	if(fxBank != 0){
		SWITCH_ROM_MBC1(fxBank);
		FX_UpdateFx();
	}
}


