
#include <gb/gb.h>
#include <string.h>
#include <stdio.h> 
#include <rand.h> 
/*audio*/
#include "libs/carillon_funcs.c"
#include "libs/fx_hammer_funcs.c"

#include "player.h"
#include "defines.h"


#include "bubbles.c"
#include "score.c"
#include "enemies.c"


#include "player.c"



#include "game_states.c"





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
				FX_Play(7);
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

	if (player.y < 130u){ //menu or easy mode	
			
	
		if(joypad()){
			

			if (ISDOWN(J_LEFT)){			
				movePlayerToLeft();
			}
		
			if (ISDOWN(J_RIGHT)){			
				movePlayerToRight();
			}		
			

			
			if (ISDOWN(J_SELECT)){
				//load_score();
				//GAMESTATE = GAMESTATE_PLAYER_DIE;
				FX_Stop();
			}
			
			
			if(CLICKED(J_A)){				
				FX_Play(6);
			}

			if (ISDOWN(J_A) || ISDOWN(J_UP)){ //JUMP
				playerJump();
			}

			if (ISDOWN(J_DOWN) ){ 
				movePlayerToDown();
			}

		
							
			if(CLICKED(J_B)){
				playerShootBubble();
				newBubble();
				FX_Play(1);
			}
		}	

	

		updatePlayer();
		updateBubbles();	

		updateEnemies();
		
		

		if(delay_new_enemie > 100){
			newEnemie();
			delay_new_enemie = 0;	
		}else{
			delay_new_enemie+= 1;	
		}
		
	}else{
	  	GAMESTATE = GAMESTATE_PLAYER_DIE;
	  	stateGamePlayerDie();
	}

	
	
	animateWater();	
	animateEnemies();
}


void main() {
	stateGameBoot();
	while (1) {		
		wait_vbl_done();
		CP_UpdateMusic();
		FX_Update();
		
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
