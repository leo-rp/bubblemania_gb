#include <gb/gb.h>
#include <string.h>
#include <stdio.h>

/*
#include "graphics/oldrobotto.h"
#include "graphics/water.c"
#include "graphics/background.h"
/*hub */
/*#include "graphics/hub.c"
#include "graphics/hub_map.c"*/

//#include "graphics/graphics.c"

/*audio*/
#include "libs/carillon_funcs.c"

#include "graphics/sgb.h"
#include "graphics/border.h"

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

/*extern const unsigned char border_chr[];
extern const unsigned char border_map[];
extern const unsigned char border_pal[];*/

#define STATE_GAME_BOOT 0x00
#define STATE_GAME_INTRO 0x01
#define STATE_GAME_TITLE 0x02
#define STATE_GAME_PLAY  0x03
#define STATE_GAME_PAUSE 0x04
#define STATE_GAME_OVER  0x05

#define STATE_GAME_LOGO  0x06
#define STATE_GAME_LOGO2  0x07


#define MAXIMO(a,b) (a > b) ? a : b
#define SPRITE_LENGTH (sizeof(unsigned char) * 16)
#define CLICKED(x) ((joystate & x) && (joystate & x) != (oldjoystate & x))
#define RELEASED(x) (!(joystate & x) && (joystate & x) != (oldjoystate & x))
#define ISDOWN(x) (joystate & (x))



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
INT16 xpos, ypos, ypos2; 
INT8 ysp, xsp, gravity, jump_force, shoot_force, speed_movement, player_direction;

/*sprite vars*/
UINT8 sflip, sprite_index;

struct Sprite {
  UBYTE x;
  UBYTE y;
  UBYTE active;
};

struct Sprite sprites[40];


INT8 getFreeSprite(){
	for(i = 2; i < 40; i=1){
		if(sprites[i].active){			
		}else{
			return i;
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
		set_sprite_tile(2, sprite_index);
		set_sprite_tile(3, sprite_index + 0x01);	
		set_sprite_tile(0, sprite_index + 0x02);
		set_sprite_tile(1, sprite_index + 0x03);		
	}else{	
		set_sprite_tile(0, sprite_index);
		set_sprite_tile(1, sprite_index + 0x01);	
		set_sprite_tile(2, sprite_index + 0x02);
		set_sprite_tile(3, sprite_index + 0x03);

	}
	set_sprite_prop(0, sflip);
	set_sprite_prop(1, sflip);
	set_sprite_prop(2, sflip);
	set_sprite_prop(3, sflip);
}


void checkInput() {
	oldjoystate = joystate;
	joystate = joypad();	
	player_direction = 0x00;	
	sflip = 0x00;
	sprite_index = 0x00;
		
	
	if(joypad()){
		if (ISDOWN(J_LEFT)){			
			sflip= 0x20;
			player_direction = 0x04;
			sprite_index= 0x10;

			if(xpos != 8u){
				xpos-= 0x02;	
			}
		}
	
		if (ISDOWN(J_RIGHT)){			
				sflip+= 0x00;
				player_direction = 0x06;
				sprite_index= 0X10;
				if(xpos != 136u){
					xpos+= 0x02;	
				}	
		}
		
		if (ISDOWN(J_DOWN)){								
			sprite_index= 0X18;		
			player_direction = 0x02;
		}
	

		if (joypad() & J_SELECT){
			printf("SCORE:%u \n", (INT16)score );
		}

		if (joypad() & J_START){
	     //printf("..X%u Y%u \n", (INT16)xpos, (INT16)ypos );			 
		 
			//printf("Index:%u Index2:%u \n", (INT16)index, (INT16)index2 );*/	
			if(score_stars < 4 ){

				score+=5U;

				updateScore();
			}
		}
		
		
				
		if(ISDOWN(J_B)){
			
			
		}
		
		
		if (ISDOWN(J_A)){
			if( ypos > 16u){	
				ysp = jump_force;
				PlaySoundJump();
			}				
		} 		
		
		
	}else{
		
		
	}	
}

void waterMovement(){
	if(water_delay > 4u){
		water_delay = 0;
		if(water_animation < 512u){		
			SWITCH_ROM_MBC1(0X03);
			memcpy(0x9580, &water[water_animation], SPRITE_LENGTH);
			memcpy(0x95A0, &water[water_animation + 16u ], SPRITE_LENGTH);
			memcpy(0x9590, &water[water_animation + 32u ], SPRITE_LENGTH);
			memcpy(0x95B0, &water[water_animation + 48u ], SPRITE_LENGTH);
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
		
//		if( ypos > 16u){
			ypos-= ysp;
			move_sprite(0x04, xpos, ypos + 16U);
//		}
				
		ypos+= gravity;

		//draw_player();
		move_sprite(0, xpos, ypos);
		move_sprite(1, xpos + 8u, ypos);
		move_sprite(4, xpos + 16u, ypos);
		move_sprite(5, xpos + 24u, ypos);

		ypos2 = ypos + 16u;
		move_sprite(2, xpos, ypos2);
		move_sprite(3, xpos + 8u, ypos2);
		move_sprite(6, xpos + 16u, ypos2);
		move_sprite(7, xpos + 24u, ypos2);

		
	}else{			
		game_play_counter+= 0x01;
	}
}



void stateGameBoot() {

	//SCY_REG=-8;SCX_REG=-8;
	
	set_sgb_border(border_chr,border_map,border_pal);
	
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
		SWITCH_ROM_MBC1(0x03);
		set_bkg_data(0, oldrobotto_tile_count, &oldrobotto_tile_data);
	    set_bkg_tiles(0, 0, 20, 18, &oldrobotto_map_data);
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
	SWITCH_ROM_MBC1(0x03);
	set_bkg_data(0, background_tile_count, background_tile_data);
	set_win_data(0x5C, 19, hub); //hub
    set_bkg_tiles(0, 0, 20, 18, background_map_data);
    set_win_tiles(0, 0, 20, 1, hub_map);
    SHOW_BKG;
    SHOW_WIN;
    move_win(7u, 136u);
	
	//SCX_REG = 0x08;
	//SCY_REG = 0x0F;			

	set_sprite_data(0, 16, &player);
	set_sprite_tile(0, 0);
	set_sprite_tile(1, 2);
	set_sprite_tile(2, 4);
	set_sprite_tile(3, 6);

	set_sprite_tile(4, 8);
	set_sprite_tile(5, 10);
	set_sprite_tile(6, 12);
	set_sprite_tile(7, 14);

	OBP0_REG = 0xC4; //11 00 01 00
	game_state = STATE_GAME_PLAY;	
	CP_LoadMusic(2, 0, 0 );	
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
