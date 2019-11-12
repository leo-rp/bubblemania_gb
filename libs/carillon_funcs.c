/*---------------------------------------------------------------------------------
CARILLON PLAYER FOR GBDK
; 
; (c)2000-2001 Aleksi Eeben (email: aleksi@cncd.fi)
; Ported to GBDK by nitro2k01 (http://gbdev.gg8.se/forums/)
;---------------------------------------------------------------------------
*/
#include <gb/gb.h>

//Carillon Player Functions
UINT8 CP_MusBank = 0;
UINT8 CP_SamBank = 0;
UINT8 CP_FxBank = 0;
UINT8 CP_ON = 0;
void CP_Init(); 
void CP_LoadSong(); 
void CP_SelectSong(UINT8 song); 

void CP_UpdateSong();  
void CP_UpdateSamp(); 
void CP_UpdateFx(); 
void CP_StopSong(); 
void CP_Mute_Chan(UINT8 chan);
void CP_Reset_Chan(UINT8 chan);
void CP_SND_OFF();
void CP_SND_ON();
void CP_Pause();
void CP_LoadFx();



//bank = rom bank where the song is stored
//sbank = rom bank where the samples are stored (0 = no sample)
//fxbak = rom bank where the fx are stored 0 = no fx
//song = song number
void CP_LoadMusic(UINT8 bank,UINT8 sbank, UINT8 fbank, int song){
	CP_MusBank = bank;
	CP_SamBank = sbank;
	CP_FxBank = fbank;
	SWITCH_ROM_MBC1(bank);
	CP_Init();
	CP_LoadSong();
	CP_SelectSong(song); 
	CP_ON = 1;
}
void CP_UpdateMusic(){
	if (CP_ON == 1){
		SWITCH_ROM_MBC1(CP_MusBank);
		CP_UpdateSong();
		if (CP_SamBank !=0){
			SWITCH_ROM_MBC1(CP_SamBank);
			CP_UpdateSamp();
		}
	}

	if(CP_FxBank != 0){
		SWITCH_ROM_MBC1(CP_FxBank);
		CP_UpdateFx();
	}
}

void CP_PlayFx(UINT8 fx){
	CP_LoadFx(fx);
	
}


void CP_StopMusic(){
	if (CP_ON == 1){
		SWITCH_ROM_MBC1(CP_MusBank);
		CP_MusBank = 0;
		CP_SamBank = 0;
		CP_ON = 0;
		CP_StopSong();
		CP_SND_OFF();
	}
}

void CP_Pause(){
	if( CP_ON == 1){
		CP_ON = 0;
		CP_Reset_Chan(0);
		CP_Reset_Chan(1);
		CP_Reset_Chan(2);		
		CP_Reset_Chan(4);		
	}
}

void CP_Play(){
	CP_ON = 1;
}


void CP_SND_OFF(){
	*(UBYTE*)0xFF26 = 0x00;
}

void CP_SND_ON(){
	*(UBYTE*)0xFF24 = 0x77; //mute
	*(UBYTE*)0xFF25 = 0x33; //balance
	*(UBYTE*)0xFF26 = 0xFB; //sound
	
}

/*fx*/
