
#include "helpers.h"


void drawLives(){
	set_win_tiles(0, 0, 1U, 1U, &hub_no_element);
	set_win_tiles(1, 0, 1U, 1U, &hub_no_element);		
	set_win_tiles(2, 0, 1U, 1U, &hub_no_element);
	
	for(i = 0; i < lives; i+=1u){				
		set_win_tiles(i, 0, 1U, 1U, &hub_live);
	}	
}



void stateGamePlayerDie(){

	if( !frame_counter){
		sprite_index = 48u;			
		drawPlayer();
		
	}
	

	if(frame_counter != 60u ){
		frame_counter+=1u;		
		
	}else{						
		if(ypos < 144){
			initBubbles();
			ypos+=1;		
			movePlayer();
			sprite_index = 64u;
			drawPlayer();
			
		}else{		
			ypos = 14u;
			sprite_index = 0;	
			
			distance = 0;
			
			if(lives){							
				xpos = 0x58;
	    		ypos = 0x10;
				ysp = 0x00;
				xsp = 0x00;
				sflip = 0x00;
				fx_jump_finished = 0x01;
				player_direction = 0x06;									
				lives-=1;
				drawLives();
				initEnemies();
				game_state = STATE_GAME_PLAY;		
				frame_counter = 0;
			}else{
				game_state = STATE_GAME_LOADGAMEPLAY;	
				frame_counter = 0;				
			}		
		}
	}

}


void stateGamePlay(){
	oldjoystate = joystate;
	joystate = joypad();

	if (ypos < 130u){ //menu	
			
	
		if(joypad()){
			

			if (ISDOWN(J_LEFT)){			
				sflip= 0x20;
				player_direction = 0x04;
				if(xpos != 8u){
					xpos-= 0x02;	
				}
			}
		
			if (ISDOWN(J_RIGHT)){			
				sflip= 0x00;
				player_direction = 0x06;				
				if(xpos != 136u){
					xpos+= 0x02;	
				}	
			}
			
			if (ISDOWN(J_DOWN)){			
				ypos+= 2;
			}

			if (ISDOWN(J_START)){
				save_score();
			}

			if (ISDOWN(J_SELECT)){
				//load_score();
				game_state = STATE_GAME_PLAYERDIE;
			}
			
			
			if(CLICKED(J_A)){				
				PlaySoundJump();
			}

			if (ISDOWN(J_A)){ //JUMP
				if( ypos > 20u){	
					ysp = jump_force;
				}
			}

			if(RELEASED(J_A)){							
			} 	

			if(ISDOWN(J_B)){
				//newBubble();			
				if(score != 999u){
					score+=1U;
					//updateScore();	

				}							
			}	
							
			if(CLICKED(J_B)){
				newBubble();
				

				sprite_index = 32u;				
				
			}
		}	

	
		
		if(ysp != 0x00){
		 ysp-= 0x01;
		}		



		ypos-= ysp;				
		ypos+= gravity;



		drawPlayer();
		movePlayer();


		updateBubbles();
		updateEnemies();

		//collideBubbles();

		collidePlayer();


		newEnemie();


		


		
	}else{
	  	game_state = STATE_GAME_PLAYERDIE;
	  	stateGamePlayerDie();
	}

	
	
	animatePlayer();		
	animateWater();
	//animateBird();
	
		
}


void main() {
	stateGameBoot();
	while (1) {		
		wait_vbl_done();
		CP_UpdateMusic();
		switch (game_state){

			case STATE_GAME_LOGO:
				stateGameLogo();
			break;

			case STATE_GAME_CONTEST:
				stateGameContest();
			break;
			
			case STATE_GAME_INTRO:
				//game intro

				stateGameIntro();
			break;
			
			case STATE_GAME_TITLE:
				stateGameTitle();
				//game_state = GAME_PLAY;			
			break;

			case STATE_GAME_LOADGAMEPLAY:
				stateGameLoadGameplay();
			break;

			case STATE_GAME_PLAY:

				stateGamePlay();				
			break;

			case STATE_GAME_PLAYERDIE:								
				stateGamePlayerDie();				
			break;


			
			
			case STATE_GAME_PAUSE:
				//game PAUSE
			break;
			
			case STATE_GAME_OVER:
				//game OVER
			break;
		}
    }
}
