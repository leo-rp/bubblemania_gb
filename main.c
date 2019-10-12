#include <gb/gb.h>
#include <string.h>
#include <stdio.h>

#include "logo.c"
#include "graphics/face.c"
#include "graphics/map.c"
#include "graphics/maptiles.c"
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



INT8 game_status;
INT16 xpos, ypos; 
INT8 ysp, xsp, gravity, jump_force, shoot_force, speed_movement, player_direction, animate, soffset;
INT16 sensor_a, sensor_b;


UINT8 sflip, sindex, lshoot, rshoot, dshoot;
UINT8 onGround, can_jump;
UINT8 stepCounter = 0;
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


void LCD_Interrupt(void){

	
	/*
	
	
	if(LY_REG < 120u) {
		
		SCX_REG = 0x00;
	}else{
		
		SCX_REG = effect[counter];		
		
		if(counter != 64u){
			
			counter+=1;
		}else{
			counter = 0;
		}
		
		
	}
	
	//SCX_REG = 0x00;
	
*/
}


INT16 map_down_collision(INT16 x, INT16 y){
	INT16 a, b, x2;
	
	x2 = x + 0x06;
	x = x - 0x06;
	x = x >> 3;
	x2 = x2 >> 3;
	
	y = y + 0x0D;
	y = y >> 3;
			
	index = ((mapSize * y) + x);
	a = map[index];
	index2 = ((mapSize * y) + x2);
	b = map[index2];
	
	if( IS_SOLID(a) || IS_SOLID(b)){
		return 1;
	}else{
		return 0;
	}
}

INT16 map_collision(INT16 x, INT16 y, UINT8 dir){
	INT16 a, b; 
	x = x - 0x08;
	switch (dir) {
		case 0x08:
			y = y - 0x0D;
		break;
		
		case 0x06: //right
			//x-= 0x01;
			//x+= xsp;
			b = 0x02;
			a = 0x02;
			
		break;
		
		case 0x02: //down
		break;
		
		
		case 0x04: //left			
			//x-= xsp;
			a = 0x00;
			b = 0x00;
			
		break;
	}
	
	
	x = x >> 3;
	y = y >> 3;
	
	
	index = ((mapSize * y) + x);
	
	
	a = map[index + a];
	b = map[(index + b) +  mapSize];
	
	if( IS_SOLID(a) || IS_SOLID(b)  ){
		return 1;
	}else{
		return 0;
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
		set_sprite_tile(2, sindex);
		set_sprite_tile(3, sindex + 0x01);	
		set_sprite_tile(0, sindex + 0x02);
		set_sprite_tile(1, sindex + 0x03);		
	}else{	
		set_sprite_tile(0, sindex);
		set_sprite_tile(1, sindex + 0x01);	
		set_sprite_tile(2, sindex + 0x02);
		set_sprite_tile(3, sindex + 0x03);
	}
	set_sprite_prop(0, sflip);
	set_sprite_prop(1, sflip);
	set_sprite_prop(2, sflip);
	set_sprite_prop(3, sflip);
}


void checkInput() {
	oldjoystate = joystate;
	joystate = joypad();
	//sflip = 0x00;
	player_direction = 0x00;
	///sindex = 0x00;
	sflip = 0x00;
	sindex = soffset;
		
	
	if(joypad()){	

		
		if (ISDOWN(J_LEFT)){			
			sflip= 0x20;
			player_direction = 0x04;
			sindex= 0x10;	
			
			if(map_collision(xpos, ypos, 0x04)){
				//xsp = 0x00;
			}else{
				xpos-=  0x02;							
			}
			
			
			
		}
	
		if (ISDOWN(J_RIGHT)){			
				sflip+= 0x00;
				player_direction = 0x06;
				sindex= 0X10;
				
			if(map_collision(xpos, ypos, 0x06)){
				///xsp = 0x00;
			}else{
				xpos+= 0x02;							
			}
			
			
			/*if(xpos != 0x98){				
				if(!map_collision(xpos, ypos, 0x02)){
					xpos+= speed_movement;
				}
			}*/
		}
		
		if (ISDOWN(J_DOWN)){								
			sindex= 0X18;		
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
			
			if(player_direction == 0x02){
				if(ypos != 0x18){
					if( ysp == 0x00){
						rshoot = 0x01;
						lshoot = 0x00;
						dshoot = 0x01;
						ysp = jump_force;
						fx_jump();
					}
				}
			}
			
			/*
			
			if(player_direction == 0x06){
				if(xpos != 0x10){
					if( xsp == 0x00){
						rshoot = 0x01;
						lshoot = 0x00;
						dshoot = 0x00;
						xsp = shoot_force;
						fx_jump();						
					}				
					
				}			
			}
			
			if(player_direction == 0x04){
				if(xpos != 0x98){
					if( xsp == 0x00){						
							lshoot = 0x01;
							rshoot = 0x00;
							dshoot = 0x00;
							xsp = shoot_force;
							fx_jump();
						
					}				
					
				}			
			}
			*/
			
		} 		
		
		
	}else{
		if(onGround){
			
			draw_player();
			
		}
		
	}	
}
	

void game_play(){
	if(stepCounter > 0x00){			
		stepCounter = 0x00;
		
		
		/*
		animate+= 0x01;
		if(animate > 0x08){			
			soffset = 0x04;
			
			
			memcpy(0x91E0, 0x91F0, sizeof(unsigned char) * 16);
			memcpy(0x9210, 0x9220, sizeof(unsigned char) * 16);
			
		}else{
			//animate = 0x00;
			soffset = 0x00;
			memcpy(0x91E0, 0x9200, sizeof(unsigned char) * 16);
			memcpy(0x9210, 0x9230, sizeof(unsigned char) * 16);
		}
		if(animate == 0x0f){
			animate = 0x00;
		}
		*/
		
		checkInput();
		onGround = map_down_collision(xpos, ypos);
		if (ypos > 0x8F){
			ypos = 0x10;
		}
			
		
		
		if(ysp != 0x00){
			 ysp-= 0x01;
		}
		
		if(dshoot){
			if( ypos > 0x17){
				ypos-= ysp;
				move_sprite(0x04, xpos, ypos + 16U);
			}
		}
		
		/*
		if(xsp != 0x00){
			 xsp-= 0x01;
		}
		
		
		
		
		if(player_direction){
			if(map_collision(xpos, ypos, 0x06)){
				xsp = 0x00;
			}else{
				xpos+= xsp;							
			}
		}
			
		if(rshoot){
			if(map_collision(xpos, ypos, 0x04)){
				xsp = 0x00;
			}else{
				xpos-= xsp;							
			}
		}
				
		*/
		
		
		
		
		
		if(onGround){
			//ysp = 0x00;
			//can_jump = 0x00;
			//ypos-=gravity;			
		}else{
			ypos+= gravity;
			
		}

		draw_player();
		move_sprite(0, xpos - 0x08, ypos);
		move_sprite(1, xpos - 0x08, ypos + 0x08);
		move_sprite(2, xpos, ypos );
		move_sprite(3, xpos, ypos + 0x08);

		
			
			
				
		
			
	}else{			
		stepCounter+= 0x01;
	}
}



void game_boot() {
    //memcpy(&col_mapxy, &map, sizeof(unsigned char) * 360);
	
	HIDE_SPRITES;
	HIDE_WIN;
    HIDE_BKG;
    STAT_REG = 8;
    
    //disable_interrupts();
    //add_LCD(LCD_Interrupt);
	//add_VBL(VBL_Interrupt);
    //enable_interrupts();
    
   
	
	/*if((_cpu == 0x01 )  || (_cpu == 0xFF)){
	  BGP_REG = 0x01B; //classic and pocket	
	}*/
	
    

	
	gravity = 0x03;
	jump_force = 0x0A;
	shoot_force = 0x04;
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
	
	//draw_player(0x00);
	
	//HIDE_BKG;
	set_bkg_data(0, 0x47, logo_tile_data);
    set_bkg_tiles(0, 0, 20, 18, logo_map_data);
	SHOW_BKG;
	SHOW_SPRITES;
}

void game_intro(){
	
	
	delay(1000);
	
	game_status = GAME_TITLE;	
	wait_vbl_done();
	HIDE_BKG;
	set_bkg_data(0, 0xF3, title_tile_data);
    set_bkg_tiles(0, 0, 20, 18, title_map_data);  
	SHOW_BKG;
}

game_title(){
	
	wait_vbl_done();
	
	if(joypad){
		
		if (joypad() & J_START){
				HIDE_BKG;
		set_bkg_data(0, 127, maptiles);
		set_bkg_tiles(0, 0, 22, 21, map);    
		set_sprite_data(0, 127u, face);
		SHOW_BKG;
		SCX_REG = 0x08;
		SCY_REG = 0x0F;
		CP_Play();	
		game_status = GAME_PLAY;
		}
		
	}
		
	


}

void main() {
    game_status = GAME_BOOT;
	
	while (1) {		
		wait_vbl_done();
		
			
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
				CP_UpdateMusic();
				
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
