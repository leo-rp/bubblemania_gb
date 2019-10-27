#include <gb/gb.h>
#include <string.h>
#include <stdio.h>
#include <gb/sgb.h>

/*audio*/
#include "libs/carillon_funcs.c"




#define BANK_GRAPHICS 0X02
#define STATE_GAME_BOOT 0x00
#define STATE_GAME_INTRO 0x01
#define STATE_GAME_TITLE 0x02
#define STATE_GAME_PLAY  0x03
#define STATE_GAME_PAUSE 0x04
#define STATE_GAME_OVER  0x05

#define STATE_GAME_LOGO  0x06
#define STATE_GAME_LOGO2  0x07


#define MAXIMO(a,b) (a > b) ? a : b
#define SPRITE_LENGTH 16u
#define CLICKED(x) ((joystate & x) && (joystate & x) != (oldjoystate & x))
#define RELEASED(x) (!(joystate & x) && (joystate & x) != (oldjoystate & x))
#define ISDOWN(x) (joystate & (x))


extern const unsigned char water[];
extern const int oldrobotto_tile_count;
extern const unsigned char oldrobotto_map_data[];
extern const unsigned char oldrobotto_tile_data[]; 
extern const int background_tile_count;
extern const unsigned char background_map_data[];
extern const unsigned char background_tile_data[]; 
extern const unsigned char hub[];
extern const unsigned char hub_map[];
extern const unsigned char player[];
extern const unsigned char bubble[];



/*auxs*/
UINT8 i;

/*game vars*/
UINT8 game_state;
UINT8 game_play_counter;
UINT16 frame_counter;
UINT8 oldjoystate, joystate;
UINT16 score;
UINT8 score_stars;


/* water*/
INT16 water_animation; /* does not work with UINT16 */
UINT8 water_delay;



/* player vars*/ 
UINT8 xpos, ypos, ypos2; 
UINT8 ysp, xsp, gravity, jump_force, shoot_force, speed_movement, player_direction;

/*fx*/

UINT8 fx_jump_finished;



/*sprite vars*/
UINT8 sflip, sprite_index;



/*struct Bubble {
  UBYTE x;
  UBYTE y;
  UBYTE active;
};*/


UINT8 bubbles_x[4];
UINT8 bubbles_y[4];
UINT8 bubbles_active[4];
UINT8 bubbles_direction[4];

//struct Bubble bubbles[3];


UINT16 *mbc_ram_pointer; 



void save_score(){
	ENABLE_RAM_MBC1;
	mbc_ram_pointer = (UINT16 *)0xA000;
	mbc_ram_pointer[0] = score;
	DISABLE_RAM_MBC1;
}

void load_score(){
	ENABLE_RAM_MBC1;
	mbc_ram_pointer = (	UINT16 *)0xa000;
	score = mbc_ram_pointer[0];
	DISABLE_RAM_MBC1;
}


/*
INT8 getFreeSprite(){
	for(i = 2; i < 40; i=1){
		if(sprites[i].active){			
		}else{
			return i;
		} 
	}
}
*/


void initBubbles(){
  UINT8 i;
  for( i = 0; i != 3; i ++){
     bubbles_x[i] = 0;
     bubbles_y[i] = 0;
     bubbles_active[i] = 0;
  }
  
  set_sprite_tile(8, 0x30);
  set_sprite_tile(9, 0x30);

  set_sprite_tile(10, 0x30);
  set_sprite_tile(11, 0x30);

  set_sprite_tile(12, 0x32);
  set_sprite_tile(13, 0x32);

  set_sprite_tile(14, 0x32);
  set_sprite_tile(15, 0x32);
  
}

void newBubble(){   	
	UINT8 i;
	for( i = 0; i != 3; i++){
	    if( !bubbles_active[i]){    
		     bubbles_y[i] = ypos + 16;
		     bubbles_active[i] = 1;
		     bubbles_direction[i] = player_direction;

		     if(bubbles_direction[i] == 0x06){
		     	bubbles_x[i] = xpos + 16;
		     	set_sprite_prop(8 + i, 0x00);
		     	set_sprite_prop(12 + i, 0x00);
		     	move_sprite(8 + i, bubbles_x[i], bubbles_y[i]);      
		     	move_sprite(12 + i, bubbles_x[i] + 8 , bubbles_y[i]); 
		     }else{
		     	bubbles_x[i] = xpos;
		     	set_sprite_prop(8 + i, 0x20);
		     	set_sprite_prop(12 + i, 0x20);
		     	move_sprite(8 + i, bubbles_x[i], bubbles_y[i]);      
		     	move_sprite(12 + i, bubbles_x[i] - 8 , bubbles_y[i]); 
		     }
		     
		     break;
	    }
  	}
}

void updateBubbles(){  
	UINT8 i;
	for( i = 0; i != 3; i++){
		if(bubbles_active[i]){ 
			if( bubbles_x[i] < 168  || bubbles_x[i] < 4){
				if(bubbles_direction[i] == 0x06){
			     	bubbles_x[i] += 6;
			     	set_sprite_prop(8 + i, 0x00);
		     		set_sprite_prop(12 + i, 0x00);
			     	move_sprite(8 + i, bubbles_x[i], bubbles_y[i]);      
			     	move_sprite(12 + i, bubbles_x[i] + 8 , bubbles_y[i]); 
		     	}else{		     		
			     	bubbles_x[i] -= 6;
			     	set_sprite_prop(8 + i, 0x20);
		     		set_sprite_prop(12 + i, 0x20);
			     	move_sprite(8 + i, bubbles_x[i], bubbles_y[i]);      
			     	move_sprite(12 + i, bubbles_x[i] - 8 , bubbles_y[i]); 
		     	}


			     
			}else{
	  			bubbles_active[i] = 0;    
	      		bubbles_x[i] = 0;
    		}    	
		 }
  	}
}



void PlaySoundJump(){
	NR10_REG = 0x77;
	NR11_REG = 0x41;
	NR12_REG = 0x82;
	NR13_REG = 0xC2;
	NR14_REG = 0xC6;
}

void drawScore(UINT8 x, UINT8 y, UINT8 offset, UINT16 value) {
	UINT8 tile;
	if(value >= 1000U) {
			
			score= 0;			
			score_stars += 1U;
			value = 0;
			tile = 0;
			tile+= offset;
			
			set_win_tiles(x+1u, y, 1U, 1U, &tile);
			set_win_tiles(x+2u, y, 1U, 1U, &tile);
			set_win_tiles(x+3U, y, 1U, 1U, &tile);

			tile = 18u;
			tile+= offset;
			set_win_tiles(20 - score_stars, y, 1U, 1U, &tile);
	}


	if(value >= 100U) {
		tile = value / 100U;
		tile+= offset;
		set_win_tiles(x+1u, y, 1U, 1U, &tile);
	}
	if(value >= 10U) {
		tile = (value / 10U) % 10;
		tile+= offset;
		set_win_tiles(x+2u, y, 1U, 1U, &tile);
	}
	if(value) {
		tile = value % 10U;
		tile+= offset;
		set_win_tiles(x+3U, y, 1U, 1U, &tile);
		
	}
	}


void updateScore(){
	drawScore(10, 0, 0x5C, score);   
}


void drawPlayer(){	
	
	if(sflip){
		set_sprite_tile(0, sprite_index + 10U);
		set_sprite_tile(1, sprite_index + 8U);	
		set_sprite_tile(2, sprite_index + 14U);
		set_sprite_tile(3, sprite_index + 12U);		
		set_sprite_tile(4, sprite_index + 2U);	
		set_sprite_tile(5, sprite_index);
		set_sprite_tile(6, sprite_index + 6U);		
		set_sprite_tile(7, sprite_index + 4U);			
	}else{	
		set_sprite_tile(0, sprite_index);
		set_sprite_tile(1, sprite_index + 2U);	
		set_sprite_tile(2, sprite_index + 4U);
		set_sprite_tile(3, sprite_index + 6U);		
		set_sprite_tile(4, sprite_index + 8U);	
		set_sprite_tile(5, sprite_index + 10U);
		set_sprite_tile(6, sprite_index + 12U);		
		set_sprite_tile(7, sprite_index + 14U);	
		

	}
	set_sprite_prop(0, sflip);
	set_sprite_prop(1, sflip);
	set_sprite_prop(2, sflip);
	set_sprite_prop(3, sflip);
	set_sprite_prop(4, sflip);
	set_sprite_prop(5, sflip);
	set_sprite_prop(6, sflip);
	set_sprite_prop(7, sflip);
}





void checkInput() {
	oldjoystate = joystate;
	joystate = joypad();	
	//player_direction = 0x00;	
	
	
		
	
	if(joypad()){
		if (ISDOWN(J_LEFT)){			
			sflip= 0x20;
			player_direction = 0x04;
			//sprite_index= 0x10;

			if(xpos != 8u){
				xpos-= 0x02;	
			}
		}
	
		if (ISDOWN(J_RIGHT)){			
				sflip= 0x00;
				player_direction = 0x06;
				//sprite_index= 0X10;
				if(xpos != 136u){
					xpos+= 0x02;	
				}	
		}
		
		if (ISDOWN(J_DOWN)){								
			
			ypos+= 2;
		}
	

	

		if (ISDOWN(J_START)){
			save_score();
	     //printf("..X%u Y%u \n", (INT16)xpos, (INT16)ypos );			 
		 
			//printf("Index:%u Index2:%u \n", (INT16)index, (INT16)index2 );*/	
		
		}

		if (ISDOWN(J_SELECT)){
			load_score();
			//updateScore();
		}
		
		
		if(CLICKED(J_A)){				
			PlaySoundJump();
		}

		if (ISDOWN(J_A)){
			if( ypos > 16u){	
				ysp = 8u;
			}			


			/*if(frame_counter < 2u){
					frame_counter+= 1u;
			}else{
				sprite_index = (sprite_index != 0) ? 0 : 16U;
				frame_counter = 0;
			}*/

				
			
		}


		if(RELEASED(J_A)){				
			//sprite_index = 0;
		} 		
						
		if(CLICKED(J_B)){

			newBubble();
			if(score_stars < 4 ){
				score+=5U;
				updateScore();
			}
			
			
		}
		
		
		
		
		
	}else{
		
		
	}	
}

void waterMovement(){
	if(water_delay > 4u){
		water_delay = 0;
		if(water_animation < 512u){		
			SWITCH_ROM_MBC1(BANK_GRAPHICS);
			memcpy(0x9580, &water[water_animation], SPRITE_LENGTH);
			memcpy(0x95A0, &water[water_animation + 16u ], SPRITE_LENGTH);
			memcpy(0x9590, &water[water_animation + 32u ], SPRITE_LENGTH);
			memcpy(0x95B0, &water[water_animation + 48u ], SPRITE_LENGTH);
			SWITCH_ROM_MBC1(0x01);
			water_animation+= 64u;			
		}else{
			water_animation = 0;
			water_delay = 5u;
		}
	}else{
		water_delay+= 1u;
	}
}	

void stateGamePlay(){
	if(game_play_counter > 0x00){			
		game_play_counter = 0x00;
		waterMovement();
		checkInput();
		
		if (ypos > 120u){ //menu
			ypos = 14u;
		}
		
		if(ysp != 0x00){
			 ysp-= 0x01;
		}
		

		ypos-= ysp;
			

				
		ypos+= gravity;

		drawPlayer();
		move_sprite(0, xpos, ypos);
		move_sprite(1, xpos + 8u, ypos);
		move_sprite(4, xpos + 16u, ypos);
		move_sprite(5, xpos + 24u, ypos);

		ypos2 = ypos + 16u;
		move_sprite(2, xpos, ypos2);
		move_sprite(3, xpos + 8u, ypos2);
		move_sprite(6, xpos + 16u, ypos2);
		move_sprite(7, xpos + 24u, ypos2);

		
		updateBubbles();
		

		
	}else{			
		game_play_counter+= 0x01;
	}
}



void stateGameBoot() {
	
		
	
    //STAT_REG = 8;
    SPRITES_8x16;    
    //disable_interrupts();
    //add_LCD(LCD_Interrupt);
	//add_VBL(VBL_Interrupt);
    //enable_interrupts();
	//bank, sample,song
	
	/*if((_cpu == 0x01 )  || (_cpu == 0xFF)){
	  BGP_REG = 0x01B; //classic and pocket	
	}*/
	gravity = 0x03;
	jump_force = 0x08;	
	speed_movement = 0x02;
    xpos = 0x58;
    ypos = 0x10;
	ysp = 0x00;
	xsp = 0x00;
	sflip = 0x00;
	fx_jump_finished = 0x01;
	game_state = STATE_GAME_LOGO;
}
		

void stateGameLogo(){
	if(frame_counter == 0){	
		HIDE_SPRITES;
		HIDE_WIN;
    	HIDE_BKG;
		
		//set_interrupts(LCD_IFLAG | VBL_IFLAG );    
	    //SHOW_BKG;
	    //SHOW_WIN;	
		//HIDE_BKG;
		SWITCH_ROM_MBC1(BANK_GRAPHICS);
		set_bkg_data(0, oldrobotto_tile_count, &oldrobotto_tile_data);
	    set_bkg_tiles(0, 0, 20, 18, &oldrobotto_map_data);
	    SWITCH_ROM_MBC1(0x01);
		SHOW_BKG;
		SHOW_SPRITES;
	}

	if(frame_counter < 200u){
		frame_counter+= 1u;
	}else{
		game_state = STATE_GAME_INTRO;			
	}
}

void stateGameIntro(){
	game_state = STATE_GAME_TITLE;	
	wait_vbl_done();
	HIDE_BKG;
	HIDE_WIN;
	SWITCH_ROM_MBC1(BANK_GRAPHICS);
	set_bkg_data(0, background_tile_count, background_tile_data);
	set_win_data(0x5C, 19, hub); //hub
    set_bkg_tiles(0, 0, 20, 18, background_map_data);
    set_win_tiles(0, 0, 20, 1, hub_map);    
    
    SHOW_BKG;
    SHOW_WIN;
    move_win(7u, 136u);
	
	//SCX_REG = 0x08;
	//SCY_REG = 0x0F;			

	set_sprite_data(0, 48, &player);
	set_sprite_data(48, 4, &bubble);
	initBubbles();
	OBP0_REG = 0xC4; //11 00 01 00

	player_direction = 0x06;
	game_state = STATE_GAME_PLAY;	
	SWITCH_ROM_MBC1(0x01);
	CP_LoadMusic(3, 0, 0 );	
	CP_Play();
	
	
}

void stateGameTitle(){
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

			case STATE_GAME_LOGO2:
				
			break;
			
			case STATE_GAME_INTRO:
				//game intro

				stateGameIntro();
			break;
			
			case STATE_GAME_TITLE:
				stateGameTitle();
				//game_state = GAME_PLAY;			
			break;
			
			case STATE_GAME_PLAY:								
				stateGamePlay();
				
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
