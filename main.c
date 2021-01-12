
#include <gb/gb.h>
#include "hUGEDriver.h"
#include <string.h>
#include <stdio.h> 
#include <rand.h> 
/*audio*/
//#include "libs/carillon_funcs.c"


#include "graphics.c"
#include "player.h"
#include "defines.h"


#include "bubbles.c"
#include "score.c"
#include "enemies.c"


#include "player.c"



#include "game_states.c"

#include "song.c"


extern const hUGESong_t Intro;




void stateGamePlayerDie(){
	player.is_dying = 1u;
	if( !frame_counter){
		player.sprite_index = 48u;
	}
	

	if(frame_counter != 60u ){
		frame_counter+=1u;		
		
	}else{						
		if(player.y < 144){			
			player.y+=1;					
			player.sprite_index = 64u;			
			
		}else{		
			player.y = 14u;
			player.sprite_index = 0;			
			
			
			if(player.lives){
				fx_jump_finished = 0x01;				
				initPlayer();
				initBubbles();
				initEnemies();
				GAMESTATE = GAMESTATE_PLAY;		
				frame_counter = 0;

			}else{

				initEnemies();
				initBubbles();
				player.x = 0;
	    		player.y = 0;
				GAMESTATE = GAMESTATE_OVER;	
				frame_counter = 0;				
			}		
		}
	}

	updatePlayer();

}


void stateGamePlay(){

	oldjoystate = joystate;
	joystate = joypad();
	
		if(joypad()){
			

			if (ISDOWN(J_LEFT)){			
				movePlayerToLeft();
			}
		
			if (ISDOWN(J_RIGHT)){			
				movePlayerToRight();
			}
			
			
			if (ISDOWN(J_A) ){ //JUMP
				playerJump();
			}

			

			
			if(ISDOWN(J_B)){
				player.sprite_index = 32u;		
			}

			if(CLICKED(J_B)){
				
				// playerShootBubble(){	
				
				newBubble();
				
			}
		}	
		
		updatePlayer();
		updateEnemies();		
		updateBubbles();	
		animateEnemies();

		if(delay_new_enemie > 40){
			newEnemie();
			delay_new_enemie = 0;	
		}else{
			delay_new_enemie+= 1;	
		}
		
	
	 
	animateWater();	

 	if (player.y > 144u){ 	  		
  		GAMESTATE = GAMESTATE_PLAYER_DIE;	  	
  	}
	
}


void main() {
	NR52_REG = 0x80;
    NR51_REG = 0xFF;
    NR50_REG = 0x77;
	__critical {
        hUGE_init(&Intro);
        add_VBL(hUGE_dosound);
    } 
	stateGameBoot();
	while (1) {		
		wait_vbl_done();
		//CP_UpdateMusic();
		
		
		switch (GAMESTATE){

			case GAMESTATE_PLAY:

				stateGamePlay();				
			break;

			case GAMESTATE_LOGO:
				stateGameLogo();
			break;

			case GAMESTATE_INTRO:
				//game intro

				stateGameIntro();
			break;
			
			case GAMESTATE_TITLE:
				stateGameTitle();
				//GAMESTATE = GAME_PLAY;			
			break;

			case GAMESTATE_LOAD_GAMEPLAY:
				stateGameLoadGameplay();
			break;

			

			case GAMESTATE_PLAYER_DIE:								
				stateGamePlayerDie();				
			break;
						
			case GAMESTATE_PAUSE:
				//game PAUSE
			break;
			
			case GAMESTATE_OVER:
				//game OVER				
				stateGameGameOver();
			break;
		}
    }
}
