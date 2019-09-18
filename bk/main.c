#include <gb/gb.h>
#include "face.c"
#include "map.c"
#include "maptiles.c"
#include <stdio.h>
#include <string.h>

#define mapSize 0x14
#define gravity 0x02
#define screen_height 0x88
#define screen_width 0xA0

#define min_x 0x08
#define max_x 0x98


#define solid 0x01

INT16 playerxy[2];
INT16 _playerxy[2];
UINT8 col_mapxy[18][20];
UINT8 c0, c1, c2, c3;

INT8 velocityY = 0;
UINT8 onGround = 0;
UINT8 stepCounter = 0;





void init() {
    //memcpy(&col_mapxy, &map, sizeof(unsigned char) * 360);
    DISPLAY_ON;
    set_bkg_data(0, 4, maptiles);
    set_bkg_tiles(0, 0, 20, 19, map);
    set_sprite_data(0, 2, face);
    set_sprite_tile(0, 0);
	set_sprite_tile(1, 0);
	set_sprite_tile(2, 0);
	set_sprite_tile(3, 0);
    playerxy[0] = 0x0F;
    playerxy[1] = 0x00;
	
	
	HIDE_WIN;
    SHOW_BKG;
    SHOW_SPRITES;
}




/* x,y , widht , heigth, tile number*/
void  map_collision(UINT16 left, UINT16 top, UINT16 right, UINT16 bottom){		
		
	UINT8 tile_0, tile_1, tile_2, tile_3;	
	UINT16 index = 0x00;	
	
	bottom+= top;
	right+= left;	
	
	left = left >> 3;
	top = top >> 3;	
	
	right = right >> 3;	
	bottom = bottom >> 3;

	bottom-= top;
	right-= left;
		
	index = ((mapSize * top ) + left );
	
	tile_0 = map[index];
	tile_1 = map[index+right];
	
	index = ((mapSize * (top + bottom)) + left );
	
	tile_2 = map[index];
	tile_3 = map[index+right];
	
	
	//up
	if( ( tile_0 == solid ) || ( tile_1 == solid )){
		c0 = 0x01;
	}else{
		c0 = 0x00;
	}
	//up
	
	
	/*//left
	if( ( tile_2 == solid ) && ( tile_0 == solid )){
		c3 = 0x01;
	}else{
		c3 = 0x00;
	}
	//left
	
	
	//right
	if( ( tile_1 == solid ) && ( tile_3 == solid )){
		c1 = 0x01;
	}else{
		c1 = 0x00;
	}
	//right
	*/
	
	//down
	if( ( tile_3 == solid ) || ( tile_2 == solid )){
		c2 = 0x01;
		//left
		if( tile_0 == solid ){
			c3 = 0x01;
		}else{
			c3 = 0x00;
		}
		//left
	
	
		//right
		if( tile_1 == solid ){
			c1 = 0x01;
		}else{
			c1 = 0x00;
		}
		//right
	}else{
		c2 = 0x00;
	}
	//down
	
	
	

	
	

	
	
}






void checkInput() { 
	
		if (joypad() & J_UP){

		}			
		
		
		if (joypad() & J_DOWN){			
				
		} 
		if (joypad() & J_LEFT){
			//if(onGround == 0x01){
				if( playerxy[0] > 0x01) {
					map_collision( (playerxy[0]-1) , playerxy[1], 0x07, 0x08);
						if(c3 == 0x00){
							playerxy[0]-=1;
						}
				}
			//}
				
			
		}
		if (joypad() & J_RIGHT){	
			//if(onGround == 0x01){
				if( playerxy[0] < max_x)  {
				map_collision( playerxy[0] , playerxy[1], 0x08, 0x08);
					if(c1 == 0x00){
						playerxy[0]+=1;
					}
				}
			//}
		}
		
		if (joypad() & J_START){		 
		 printf("X%u Y%u \n", (UINT16)playerxy[0], (UINT16)playerxy[1] ); 
		 printf("C 0:%u 1:%u 2:%u 3:%u  \n", (UINT16)c0, (UINT16)c1, (UINT16)c2, (UINT16)c3); 
		}
		
		if (joypad() & J_A ){
	
			if(onGround == 0x01){
				if(c0 == 0x00){
					playerxy[1]-= 24u;
					onGround = 0x00; 
				}
			}
			
			
	
			
		}

	
		
		
			
		
	
}


	
	


void main() {
    init();
	
    while (1) {
		wait_vbl_done();
		/*if( (playerxy[0] > screen_width ) ){
			playerxy[0] = -0x08;
		}*/
	
		if( (playerxy[1] > 150u ) ){
			playerxy[1] = 0x0f;
		}
				
		
		checkInput();			
		
		map_collision( playerxy[0] , playerxy[1], 0x07, 0x08);				
		
		if(c2 != 0x00){
			set_sprite_tile(0, 0);
			velocityY = 0;
			playerxy[1] = _playerxy[1];
			onGround = 0x01;
		}else{//falling
			//playerxy[0] = _playerxy[0];
			set_sprite_tile(0, 1);
			
			playerxy[1]+= gravity;
		}
		
		move_sprite(0, (playerxy[0] + 0x08), (playerxy[1]+ 0x10));
		
		_playerxy[0] = playerxy[0];
		_playerxy[1] = playerxy[1];
    }

}
