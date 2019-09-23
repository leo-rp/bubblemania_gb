#include <gb/gb.h>
#include "face.c"
#include "map.c"
#include "maptiles.c"
#include <stdio.h>
#include <string.h>


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


const UINT8 fadePals[] = {
	0xE4, // 11100100
	0x90, // 10010000
	0x40, // 01000000
	0x00  // 00000000
};

unsigned char effect[] =
{
   0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
    0x01,0x01,0x01,0x01,0x01,0x01,0x01,0x01,
	0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,
	0x03,0x03,0x03,0x03,0x03,0x03,0x03,0x03,
	0x04,0x04,0x04,0x04,0x04,0x04,0x04,0x04,
	0x05,0x05,0x05,0x05,0x05,0x05,0x05,0x05,
	0x04,0x04,0x04,0x04,0x04,0x04,0x04,0x04,
	0x03,0x03,0x03,0x03,0x03,0x03,0x03,0x03,
	0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,
	0x01,0x01,0x01,0x01,0x01,0x01,0x01,0x01,
	0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
	
};

INT8 game_status;
INT16 xpos, ypos; 
INT8 ysp, gravity, jump_force, speed_movement;
INT16 sensor_a, sensor_b;


UINT8 pldir;
UINT8 onGround, can_jump;
UINT8 stepCounter = 0;
UBYTE oldjoystate, joystate;
UINT8 i;
	INT16 index, index2;

UBYTE ix, iy, counter, offset, win;
UINT16 p1, p2;



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

void fade(){
	
	for(i = 0x00; i < 0x04; i+= 0x01 ){
		BGP_REG = fadePals[i];
		i+=0x01;
	}
}

INT16 map_up_collision(INT16 x, INT16 y){
	INT16 a, b, x2;
	
	x2 = x + 0x07;
	x = x - 0x08;
	x = x >> 3;
	x2 = x2 >> 3;
	
	y = y - 0x08;
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


INT16 map_down_collision(INT16 x, INT16 y){
	INT16 a, b, x2;
	
	x2 = x + 0x07;
	x = x - 0x08;
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
		case 0x00:
			y = y - 0x0D;
		break;
		
		case 0x02:
			x-= 0x01;
			x+= speed_movement;
			b = 0x02;
			a = 0x02;
			
		break;
		
		case 0x04: //down
		break;
		
		
		case 0x08: //left
			
			x-= speed_movement;
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


void set_pl_sprites_prop(UINT8 s0, UINT8 s1, UINT8 s2, UINT8 s3, UINT8 sflip){
	set_sprite_tile(0, s0);
	set_sprite_tile(1, s1);	
	set_sprite_tile(2, s2);
	set_sprite_tile(3, s3);
	set_sprite_prop(0, sflip);
	set_sprite_prop(1, sflip);
	set_sprite_prop(2, sflip);
	set_sprite_prop(3, sflip);
}


void checkInput() {
			oldjoystate = joystate;
			joystate = joypad();	
	
		
			if (joypad() & J_A){
				
				if(!map_up_collision(xpos, ypos)){
				   ysp = jump_force;				
				}
			}
			
			
		
		
		
		
		if (joypad() & J_DOWN){			
			if(ypos < 0x88){
				ypos+= speed_movement;
			}
		} 
		
		
		if (joypad() & J_LEFT){
			if(pldir != 0x08){
			  pldir = 0x08;
			  set_pl_sprites_prop(0x02, 0x03, 0x00, 0x01, 0x20);
			}
			
			if(xpos != 0x08){
				if(!map_collision(xpos, ypos, 0x08)){
					xpos-= speed_movement;
				}
			}			
		}
		
		if (joypad() & J_RIGHT){
			if(pldir != 0x02){
				pldir = 0x02;
				set_pl_sprites_prop(0x00, 0x01, 0x02, 0x03, 0x00);
			}
			
			if(xpos != 0x98){
				
				if(!map_collision(xpos, ypos, 0x02)){
					xpos+= speed_movement;
				}
			}
		}
		
		if (joypad() & J_START){
		 printf("..X%u Y%u \n", (INT16)xpos, (INT16)ypos );
		 
		 printf("Index:%u Index2:%u \n", (INT16)index, (INT16)index2 );
		  
		}
		
		if ( joypad() & J_SELECT ){
			fade();
		}
		
	
}
	

void game_play(){
	if(stepCounter > 0x02){			
		stepCounter = 0x00;
		
		checkInput();
		onGround = map_down_collision(xpos, ypos);
		
		
		

		if( ypos > 0x17){
			ypos-= ysp;				
			
		}
		if(ysp != 0x00){
			 ysp-= 0x01;
		}
		
		if(onGround){
			ysp = 0x00;
			//ypos-=gravity;
		}else{
			ypos+= gravity;
		}

		
		move_sprite(0, xpos - 0x08, ypos);
		move_sprite(1, xpos - 0x08, ypos + 0x08);
		move_sprite(2, xpos, ypos );
		move_sprite(3, xpos, ypos + 0x08);

		
		if(onGround){
			if(pldir == 0x08){
				set_pl_sprites_prop(0x02, 0x03, 0x00, 0x01, 0x20);
			}else{
				set_pl_sprites_prop(0x00, 0x01, 0x02, 0x03, 0x00);
			}
		}else{
			if(pldir == 0x02){
				set_pl_sprites_prop(0x04, 0x05, 0x06, 0x07, 0x00);
			}else{
				set_pl_sprites_prop(0x06, 0x07, 0x04, 0x05, 0x20);
			}
		}
			
			
			
				
		
			
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
	
    set_bkg_data(0, 127, maptiles);
    set_bkg_tiles(0, 0, 22, 21, map);
    
	set_sprite_data(0, 12, face);	
	set_sprite_tile(0, 0);
	set_sprite_tile(1, 1);
	set_sprite_tile(2, 2);
	set_sprite_tile(3, 3);
	/* test sprites */
	set_sprite_tile(4, 9);
	set_sprite_tile(5, 9);
	set_sprite_tile(6, 9);
	set_sprite_tile(7, 9);
	
	gravity = 0x02;
	jump_force = 0x08;
	speed_movement = 0x01;
    xpos = 0x50;
    ypos = 0x10;
	ysp = 0x00;
	pldir = 0x04;
	
	SCX_REG = 0x08;
	SCY_REG = 0x0F;
	
	//set_interrupts(LCD_IFLAG | VBL_IFLAG );
    
    SHOW_BKG;
    //SHOW_WIN;
	SHOW_SPRITES;
}

void main() {
    game_status = GAME_BOOT;
	
	while (1) {
		wait_vbl_done();
			
		switch (game_status){
		case GAME_BOOT:
			game_boot();
			game_status = GAME_PLAY;			
		break;
		
		case GAME_INTRO:
			//game intro
		break;
		
		case GAME_TITLE:
			//game title
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
