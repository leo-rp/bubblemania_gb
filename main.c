#include <gb/gb.h>
#include <string.h>
#include <stdio.h>

#include "graphics/oldrobotto.h"
#include "graphics/player.c"
#include "graphics/water.c"
#include "graphics/background.h"

#include "libs/carillon_funcs.c"


#define GAME_BOOT 0X00
#define GAME_INTRO 0X01
#define GAME_TITLE 0X02
#define GAME_PLAY  0X03
#define GAME_PAUSE 0X04
#define GAME_OVER  0X05


#define mapSize 0x16
#define SOLID 0x3F
#define IS_SOLID(x) (x > SOLID ) ? TRUE : FALSE
#define maximo(a,b) (a > b) ? a : b


#define CLICKED(x) ((joystate & x) && (joystate & x) != (oldjoystate & x))
#define RELEASED(x) (!(joystate & x) && (joystate & x) != (oldjoystate & x))
#define ISDOWN(x) (joystate & (x))



INT8 game_status, game_counter, game_animation;
INT16 xpos, ypos, ypos2, water_animation; 
INT8 ysp, xsp, gravity, jump_force, shoot_force, speed_movement, player_direction, animate, soffset, water_delay;
INT16 sensor_a, sensor_b;


UINT8 sflip, sprite_index, lshoot, rshoot, dshoot;
UINT8 onGround, can_jump;
UINT8 game_play_counter = 0;
UBYTE oldjoystate, joystate;
UINT8 i;
INT16 index, index2;

UBYTE ix, iy, counter, offset, win;
UINT16 p1, p2;


struct Sprite {
  UBYTE x;
  UBYTE y;
  UBYTE active;
};

struct Sprite sprites[40];


INT8 get_free_sprite(){
	for(i = 2; i < 40; i=1){
		if(sprites[i].active){			
		}else{
			return i;
		} 
	}
}

void fx_jump(){
	NR10_REG = 0x77;
	NR11_REG = 0x41;
	NR12_REG = 0x82;
	NR13_REG = 0xC2;
	NR14_REG = 0xC6;
}

void draw_player(){	
	
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
	
		if (joypad() & J_START){
	     /* printf("..X%u Y%u \n", (INT16)xpos, (INT16)ypos );			 
		 printf("Index:%u Index2:%u \n", (INT16)index, (INT16)index2 );*/	
				//reset();
		}
		
		
			
		if(RELEASED(J_A)){
			//can_jump = 0x01;
		}
		
		
		if(ISDOWN(J_B)){
			
		}
		
		
		if (ISDOWN(J_A)){
				
					//if( ysp == 0x00){
						rshoot = 0x01;
						lshoot = 0x00;
						dshoot = 0x01;
						ysp = jump_force;
						fx_jump();
					//}
				
		} 		
		
		
	}else{
		if(onGround){
			
			//draw_player();
			
		}
		
	}	
}

void water_movement(){
	if(water_delay > 0x04){
		water_delay = 0x00;
		if(water_animation < 512u){			
			memcpy(0x9580, &water[water_animation], sizeof(unsigned char) * 16);
			memcpy(0x95A0, &water[water_animation + 16u ], sizeof(unsigned char) * 16);
			memcpy(0x9590, &water[water_animation + 32u ], sizeof(unsigned char) * 16);
			memcpy(0x95B0, &water[water_animation + 48u ], sizeof(unsigned char) * 16);
			water_animation+= 64u;			
		}else{
			water_animation = 0;
			water_delay = 0x05;
		}
	}else{
		water_delay+= 0x01;
	}
}	

void game_play(){
	if(game_play_counter > 0x00){			
		game_play_counter = 0x00;
		 water_movement();
		checkInput();
		onGround = 0;
		if (ypos > 128u){
			ypos = 14u;
		}
		
		if(ysp != 0x00){
			 ysp-= 0x01;
		}
		
		if(dshoot){
			if( ypos > 16u){
				ypos-= ysp;
				move_sprite(0x04, xpos, ypos + 16U);
			}
		}
		
		
		if(onGround){
		
		}else{
			ypos+= gravity;
			
		}

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



void game_boot() {
    //memcpy(&col_mapxy, &map, sizeof(unsigned char) * 360);
	
	HIDE_SPRITES;
	HIDE_WIN;
    HIDE_BKG;
    STAT_REG = 8;
    SPRITES_8x16;
    
    //disable_interrupts();
    //add_LCD(LCD_Interrupt);
	//add_VBL(VBL_Interrupt);
    //enable_interrupts();
	
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
	can_jump = 0x01;
		
	//bank, sample,song
	CP_LoadMusic(2, 0, 0 );	
	//set_interrupts(LCD_IFLAG | VBL_IFLAG );    
    //SHOW_BKG;
    //SHOW_WIN;	
	//HIDE_BKG;
	set_bkg_data(0, oldrobotto_tile_count, &oldrobotto_tile_data);
    set_bkg_tiles(0, 0, 20, 18, &oldrobotto_map_data);
	SHOW_BKG;
	SHOW_SPRITES;
}

void game_intro(){
	
	
	delay(1000);
	
	game_status = GAME_TITLE;	
	wait_vbl_done();
	HIDE_BKG;
	set_bkg_data(0, background_tile_count, background_tile_data);
    set_bkg_tiles(0, 0, 20, 18, background_map_data);
	SHOW_BKG;	
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
	

	game_status = GAME_PLAY;	
	//CP_Play();
}

game_title(){
}

void main() {
    game_status = GAME_BOOT;
	
	while (1) {		
		wait_vbl_done();
		CP_UpdateMusic();
		
		
			
		switch (game_status){
			case GAME_BOOT:
				game_boot();
				game_status = GAME_INTRO;			
			break;
			
			case GAME_INTRO:
				//game intro

				game_intro();
			break;
			
			case GAME_TITLE:
				game_title();
				//game_status = GAME_PLAY;			
			break;
			
			case GAME_PLAY:				
				game_play();
				
			break;
			
			case GAME_PAUSE:
				//game PAUSE
			break;
			
			case GAME_OVER:
				//game OVER
			break;
		}	
	
	
    }

}
