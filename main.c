#include <gb/gb.h>
#include "face.c"
#include "map.c"
#include "maptiles.c"
#include <stdio.h>
#include <string.h>

#define mapSize 0x14
#define gravity 0x02

#define CLICKED(x) ((joystate & x) && (joystate & x) != (oldjoystate & x))
#define RELEASED(x) (!(joystate & x) && (joystate & x) != (oldjoystate & x))
#define ISDOWN(x) (joystate & (x))


INT16 xpos, ypos; 
INT8 ysp;
INT16 sensor_a, sensor_b, sensor_c, sensor_d, sensor_y;	
UINT8 col_mapxy[18][20];


UINT8 pldir;
UINT8 onGround;
UINT8 stepCounter = 0;
UBYTE oldjoystate, joystate;




void init() {
    //memcpy(&col_mapxy, &map, sizeof(unsigned char) * 360);
    DISPLAY_OFF;
    set_bkg_data(0, 126, maptiles);
    set_bkg_tiles(0, 0, 20, 19, map);
    
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

    
    xpos = 0x08;
    ypos = 0x10;
	ysp = 0x00;
	pldir = 0x04;	
	
	DISPLAY_ON;
	HIDE_WIN;
    SHOW_BKG;
    SHOW_SPRITES;
}


void  map_collision(){
	sensor_a = (xpos - 0x03); //ground
	sensor_b = (xpos + 0x05); //ground
	
	sensor_c = (xpos - 0x07); //left
	sensor_d = (xpos + 0x07); //right
	
	sensor_y = (ypos + 16u); 
	
	/*move_sprite(4, sensor_a, sensor_y);
	move_sprite(5, sensor_b , sensor_y);
	move_sprite(6, sensor_c, (sensor_y - 8u));
	move_sprite(7, sensor_d, (sensor_y - 8u));*/
	
	sensor_a = sensor_a >> 3;
	sensor_b = sensor_b >> 3;
	sensor_c = sensor_c >> 3;
	sensor_d = sensor_d >> 3;
	
	sensor_y = sensor_y >> 3;
	sensor_y = (sensor_y - 0x02);
	
	sensor_a = ( (mapSize * sensor_y ) + sensor_a);
	sensor_a = map[sensor_a];
	
	sensor_b = ( (mapSize * sensor_y ) + sensor_b);
	sensor_b = map[sensor_b];
	
	
	sensor_y = (sensor_y - 0x01);
	
	sensor_c = ( (mapSize * sensor_y) + sensor_c);
	sensor_c = map[sensor_c];
	
	sensor_d = ( (mapSize * sensor_y) + sensor_d);
	sensor_d = map[sensor_d];
	
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
	
		
			if (CLICKED(J_A) &  onGround){
				
				if(ypos > 0x09){
					ysp =16u;
				}
			}			
		
		
		
		
		if (joypad() & J_DOWN){			
			if(ypos < 0x88){
				ypos+=1;
			}
		} 
		
		
		if (joypad() & J_LEFT){
			if(pldir != 0x02){
			  pldir = 0x02;
			  set_pl_sprites_prop(0x02, 0x03, 0x00, 0x01, 0x20);
			}
			
			if(xpos != 0x08){
				if(sensor_c == 0x00){
					xpos-=1;
				}
			}
			
		}
		if (joypad() & J_RIGHT){
			if(pldir != 0x04){
				pldir = 0x04;
				set_pl_sprites_prop(0x00, 0x01, 0x02, 0x03, 0x00);
			}
			
			if(xpos != 0x98){
				if(sensor_d == 0x00){
					xpos+=1;
				}
			}
		}
		
		if (joypad() & J_START){
		 printf("X%u Y%u \n", (UINT16)xpos, (UINT16)ypos );
		 printf("Sc%u Sd%u Sy%u \n", (INT16)sensor_c, (INT16)sensor_d, (INT16)sensor_y ); 
		 printf("Sa%u Sb%u Sy%u \n", (INT16)sensor_a, (INT16)sensor_b, (INT16)sensor_y ); 
		}
		
		if (CLICKED(J_SELECT) ){
			//init();
			set_bkg_data(0, 126, maptiles);
			set_bkg_tiles(0, 0, 20, 19, map);
		}
		
	
}
	


void main() {
    init();
	
	
    while (1) {
		wait_vbl_done();
		
	
		
		if(stepCounter > 0x02){
			stepCounter = 0x00;
			checkInput();
			map_collision();	
			
			
			if(sensor_a || sensor_b){//ground				
				onGround = 0x01;
				if(pldir == 0x02){
					set_pl_sprites_prop(0x02, 0x03, 0x00, 0x01, 0x20);
				}else{
					set_pl_sprites_prop(0x00, 0x01, 0x02, 0x03, 0x00);
				}
			}else{
				onGround = 0x00;				
				if(pldir == 0x04){
					set_pl_sprites_prop(0x04, 0x05, 0x06, 0x07, 0x00);
				}else{
					set_pl_sprites_prop(0x06, 0x07, 0x04, 0x05, 0x20);
				}
			}
			
			
			move_sprite(0, xpos, ypos);
			move_sprite(1, xpos, ypos + 0x08);
			move_sprite(2, xpos + 0x08, ypos );
			move_sprite(3, xpos + 0x08, ypos + 0x08);
			
			ypos-= ysp;
			
			
			if(onGround){
				ysp = 0x00;
			}else{
				ypos+= gravity;
			}	
			
		}else{
			stepCounter+= 0x01;
		}
    }

}
