
#include "defines.h"


/***********************************/
/************* SCORE *************/
/***********************************/

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

void drawScore(UINT8 x, UINT8 y, UINT8 offset, UINT16 value) {

	if(value >= 100U) {
		i = value / 100U;
		i+= offset;
		set_win_tiles(x+1u, y, 1U, 1U, &i);
	}
	if(value >= 10U) {
		i = (value / 10U) % 10;
		i+= offset;
		set_win_tiles(x+2u, y, 1U, 1U, &i);
	}
	if(value) {
		i = value % 10U;
		i+= offset;
		set_win_tiles(x+3U, y, 1U, 1U, &i);		
	}	
}


void updateScore(){
	drawScore(9, 0, 0x5C, score);   
}


UINT8 void collideEenemie(UINT8 i, UINT8 x1, UINT8 y1, UINT8 w1, UINT8 h1 ){
	UINT8 x2, y2, w2, h2;
	UINT8 s1, s2, s3, s4;	 

 	switch(enemies_type[i]){	     	
     	
		default :	
    		x2 = enemies_x[i];							     		
			w2 = 15;
			y2 = enemies_y[i] + 4;
			h2 = 10;
     	break;	
	}
	
	s1 = x1 + w1; // r1 right edge past r2 left
	s2 = x2 + w2; // r1 left edge past r2 right
	s3 = y1 + h1; // r1 top edge past r2 bottom
	s4 = y2 + h2; // r1 bottom edge past r2 top

	if( x2 >= s1 || s2 <= x1 || y2 >= s3 || s4 <= y1 ){
		return 0;
	}	
	return 1;
}




/***********************************/
/************* ENEMIES *************/
/***********************************/

void deactiveEenemie(UINT8 i){	
	enemies_x[i] = 0;
	enemies_y[i] = 0;
	enemies_active[i] = 0;
	enemies_direction[i] = 0;
	enemies_type[i] = 0;
	move_sprite(16+i , 0, 0);
	move_sprite(28+i , 0, 0);

	if(used_enemies != 0){
		used_enemies-=1U;
	}
}

void initEnemies(){		
	used_enemies = 0;
	for(i = 0; i < MAX_ENEMIES_ON_SCREEN; i+=1){		
		deactiveEenemie(i);
	}
}


void drawEnemie(UINT8 i){
	move_sprite(16+i , enemies_x[i], enemies_y[i]);
	move_sprite(28+i , enemies_x[i] + 8, enemies_y[i] );
}


void collidePlayer(){
	
	if(used_enemies){
		for( i = 0; i != used_enemies; i+=1u){
			c = collideEenemie(i, xpos+ 4, ypos + 4, 24u, 24u );
			if(c){ //collision				

				if(enemies_direction[i]){
					set_sprite_tile(16 + i, 0x52 );
					set_sprite_tile(28 + i, 0x54 );		
				}else{
					set_sprite_tile(16 + i, 0x54 );
					set_sprite_tile(28 + i, 0x52 );	
				}		
				
				game_state = STATE_GAME_PLAYERDIE;
				break;
			}
		}
		
	}
}

void updateEnemies(){
	if(used_enemies){
		for( i = 0; i != MAX_ENEMIES_ON_SCREEN; i+=1u){
			if(enemies_active[i]){ 
				if( enemies_x[i] < 168  || enemies_x[i] < 4){										
					
					if(enemies_direction[i]){
				     		enemies_x[i] += enemies_speed;			     	
		     		}else{		     		
				     		enemies_x[i] -= enemies_speed;
		     		}	
					
				}else{
		  			deactiveEenemie(i);
	    		}
	    		drawEnemie(i);    	
	    		
		 	}
	  	}
		
  	}
}


void newEnemie(){  

	for( i = 0; i != MAX_ENEMIES_ON_SCREEN; i+=1u){
	    if( !enemies_active[i]){
    		 
	    	 random_number = rand();
		     enemies_type[i] =  random_number >> 6; //0 - 3 

		     switch(enemies_type[i]){
		     	

		     	/*case 20: //fish
			     	enemies_y[i] = random_number >> 4; // 0 - 15
			     	enemies_direction[i] = random_number >> 7; // 0- 1
			     	set_sprite_tile(16 + i, 0x5E );
			     	set_sprite_tile(28 + i, 0x60 );
		     	break;

		     	case 25: //star
			     	enemies_x[i] = random_number >> 4; // 0 - 15
			     	enemies_x[i] += 3;  //offset
			     	enemies_y[i] = 0;
			     	enemies_direction[i] = random_number >> 7; // 0- 1
			     	set_sprite_tile(16 + i, 0x66 );
			     	set_sprite_tile(28 + i, 0x68 );
		     	break;*/

		     	default :

		     		enemies_y[i] = random_number >> 5; // 0 - 8
		     		if(enemies_y[i] == 0){
		     			enemies_y[i] = 1;
		     		}

		     		if(enemies_y[i] > 6){
		     			enemies_y[i] = 6;
		     		}
			     	
			     	enemies_y[i] = enemies_y[i] << 4;
			     	enemies_direction[i] = random_number >> 7; // 0- 1

			     	if(enemies_direction[i]){
			     		enemies_x[i] = 8;	
			     		set_sprite_tile(16 + i, 0x56 );
			     		set_sprite_tile(28 + i, 0x58 );
			     		set_sprite_prop(16 + i , 0x00);
			     		set_sprite_prop(28 + i , 0x00);
			     	}else{
			     		enemies_x[i] = 159;
			     		set_sprite_tile(16 + i, 0x58 );
			     		set_sprite_tile(28 + i, 0x56 );			     					     		
			     		set_sprite_prop(16 + i, 0x20);
			     		set_sprite_prop(28 + i, 0x20);
			     	}

		     	break;
		     }	

		     enemies_active[i] = 1;
		     used_enemies+=1U;
		     
		     drawEnemie(i);
		     break;
	    }
  	}

}



void animateBird(){
	if(bird_delay > 4u){		
	  	//~bird_animation; 
	  	bird_delay = 0;
	  	bird_animation = bird_animation ? 0 : 4;

	  	for(i = 0; i < 28; i +=1){
			///set_sprite_tile(12 + i, 0x52 + bird_animation);
			///set_sprite_tile(13 + i, 0x54 + bird_animation);
		}
		
			
			
		
	}else{
		bird_delay+= 1u;
	}
}	

/***********************************/
/************* PLAYER *************/
/***********************************/
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


void movePlayer(){
	move_sprite(0, xpos, ypos);
	move_sprite(1, xpos + 8u, ypos);
	move_sprite(4, xpos + 16u, ypos);
	move_sprite(5, xpos + 24u, ypos);

	ypos2 = ypos + 16u;
	move_sprite(2, xpos, ypos2);
	move_sprite(3, xpos + 8u, ypos2);
	move_sprite(6, xpos + 16u, ypos2);
	move_sprite(7, xpos + 24u, ypos2);
}

void animatePlayer(){
	if(player_delay > 9u){
		player_delay = 0;
		sprite_index =  sprite_index ? 0 : 16u;
		drawPlayer();
		
		
	}else{
		player_delay+= 1u;
	}
}	

/***********************************/
/************* BUBBLES *************/
/***********************************/
void initBubbles(){  
	for( i = 0; i != MAX_BUBBLES_ON_SCREEN; i ++){
     	bubbles_x[i] = 0;
     	bubbles_y[i] = 0;
     	bubbles_active[i] = 0;     
  	}
	used_bubbles = 0;
	set_sprite_tile(8, 0x50);
	set_sprite_tile(9, 0x50);
	set_sprite_tile(10, 0x50);
	
	move_sprite(8, 0, 0);
	move_sprite(9, 0, 0);
	move_sprite(10, 0, 0);
	
	set_win_tiles(17, 0, 1U, 1U, &hub_bubble);
	set_win_tiles(18, 0, 1U, 1U, &hub_bubble);		
	set_win_tiles(19, 0, 1U, 1U, &hub_bubble);		


}

void drawBubble(UINT8 i){
	if(bubbles_direction[i] == 0x06){
		set_sprite_prop(8 + i, 0x00);
     	//set_sprite_prop(11 + i, 0x00);
     	move_sprite(8 + i, bubbles_x[i], bubbles_y[i]);      
     	//move_sprite(11 + i, bubbles_x[i] + 8 , bubbles_y[i]); 
	}else{
		set_sprite_prop(8 + i, 0x20);
     	//set_sprite_prop(11 + i, 0x20);
     	move_sprite(8 + i, bubbles_x[i], bubbles_y[i]);      
     	//move_sprite(11 + i, bubbles_x[i] - 8 , bubbles_y[i]); 
	}
}

void newBubble(){   		
	for( i = 0; i != MAX_BUBBLES_ON_SCREEN; i+=1u){
	    if( !bubbles_active[i]){    
		     bubbles_y[i] = ypos + 8;
		     bubbles_active[i] = 1;
		     used_bubbles+=1U;
		     bubbles_direction[i] = player_direction;
		     if(bubbles_direction[i] == 0x06){
		     	bubbles_x[i] = xpos + 16;
		     }else{
		     	bubbles_x[i] = xpos;
		     }
		     drawBubble(i);
		     break;
	    }
  	}
}

void updateBubbles(){
	if(used_bubbles){
		for( i = 0; i != MAX_BUBBLES_ON_SCREEN; i+=1u){
			if(bubbles_active[i]){ 
				if( bubbles_x[i] < 168  || bubbles_x[i] < 4){
					if(bubbles_direction[i] == 0x06){
				     	bubbles_x[i] += BUBBLE_SPEED;			     	
			     	}else{		     		
				     	bubbles_x[i] -= BUBBLE_SPEED;
			     	}
			     	
				}else{
		  			bubbles_active[i] = 0;
		  			bubbles_x[i] = 0;
		  			bubbles_y[i] = 0;

		  			if(used_bubbles != 0){
		  				used_bubbles-=1U;
		  			}
		  			    
		      		bubbles_x[i] = 0;
	    		}
	    		drawBubble(i);    	
		 	}
	  	}
		set_win_tiles(17, 0, 1U, 1U, &hub_bubble);
		set_win_tiles(18, 0, 1U, 1U, &hub_bubble);		
		set_win_tiles(19, 0, 1U, 1U, &hub_bubble);		
		for(i = 0; i < used_bubbles; i+=1u){				
			set_win_tiles(17 + i, 0, 1U, 1U, &hub_no_element);
		}	
  	}
}

void collideBubbles(){
	UINT8 c;
	
	if(used_bubbles){
		if(used_enemies){
			for( j = 0; j != MAX_BUBBLES_ON_SCREEN; j+=1u){
				if(bubbles_active[j]){
					for( i = 0; i != MAX_ENEMIES_ON_SCREEN; i+=1u){
	    				if( enemies_active[i]){    					
	    					c = collideEenemie(i, bubbles_x[j], bubbles_y[j] + 4,  bubbles_x[j] + 8,  bubbles_y[j] + 13);

					     	if(c){
					     		enemies_x[i] = 0;
					     		enemies_y[i] = 0;
					     		enemies_active[i] = 0;
					     		if(!used_enemies){
					     			used_enemies=-1;
					     		}

							}
			     		}
    				}
				}
			}
		}		
	}
}

/****************************************/
/************* GAME EFECTS *************/
/****************************************/
void PlaySoundJump(){
	NR10_REG = 0x77;
	NR11_REG = 0x41;
	NR12_REG = 0x82;
	NR13_REG = 0xC2;
	NR14_REG = 0xC6;
}

void animateWater(){
	if(water_delay > 9u){
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
			water_delay = 10u;
		}
	}else{
		water_delay+= 1u;
	}
}	



/****************************************/
/************* GAME STATES *************/
/****************************************/


/* game boot*/
void stateGameBoot() {	
    //STAT_REG = 8;
    
    disable_interrupts();
    SPRITES_8x16;    
    //add_LCD(LCD_Interrupt);
	//add_VBL(VBL_Interrupt);
    enable_interrupts();
	//bank, sample,song
	
	/*if((_cpu == 0x01 )  || (_cpu == 0xFF)){
	  BGP_REG = 0x01B; //classic and pocket	
	}*/
	
	//game_state = STATE_GAME_LOGO;
	random_seed = DIV_REG;
	game_state = STATE_GAME_LOADGAMEPLAY;
}
	
/*developer logo*/	
void stateGameLogo(){	
	if(!frame_counter){	
		HIDE_SPRITES;
		HIDE_WIN;
    	HIDE_BKG;
		SWITCH_ROM_MBC1(BANK_GRAPHICS);
		set_bkg_data(0, oldrobotto_tile_count, &oldrobotto_tile_data);
	    set_bkg_tiles(0, 0, 20, 18, &oldrobotto_map_data);
	    SWITCH_ROM_MBC1(0x01);
		SHOW_BKG;
		SHOW_SPRITES;
	}

	if(frame_counter != 300u){
		frame_counter+= 1u;
	}else{
		game_state = STATE_GAME_CONTEST;	
		frame_counter = 0;		
	}
}


/*contest logo*/	
void stateGameContest(){
	if(!frame_counter){	
		HIDE_SPRITES;
		HIDE_WIN;
    	HIDE_BKG;	
		SWITCH_ROM_MBC1(BANK_GRAPHICS);
		set_bkg_data(0, logo_2_a_tile_count, &logo_2_a_tile_data);
	    set_bkg_tiles(0, 0, 20, 18, &logo_2_a_map_data);

	    set_win_data(0x34, logo_2_b_tile_count, logo_2_b_tile_data);
	    set_win_tiles(0, 0, 20, 9, logo_2_b_map_data);  

    	set_sprite_data(0, 8, &year);
		set_sprite_tile(0, 0);	
		set_sprite_tile(1, 2);	
		set_sprite_tile(2, 4);	
		set_sprite_tile(3, 6);	
		
		move_sprite(0, 72, 84 );
		move_sprite(1, 80, 84 );
		move_sprite(2, 88, 84 );
		move_sprite(3, 96, 84 );

	    SWITCH_ROM_MBC1(0x01);
	    SCX_REG = 72u;
	    WY_REG = 144;
		SHOW_BKG;
		SHOW_WIN;		
	}

	if(frame_counter != 300u){
		frame_counter+= 1u;
		if(SCX_REG > 0){
			SCX_REG-=1u;
		}

		if( WY_REG > 72){
			WY_REG -= 1u;	
		}else{
			SHOW_SPRITES;
		}
	}else{
		game_state = STATE_GAME_LOADGAMEPLAY;			
		frame_counter = 0;
	}
}



/**/
void stateGameIntro(){
	game_state = STATE_GAME_TITLE;
}

/*GAME TTILE*/
void stateGameTitle(){
}

void stateGameLoadGameplay(){
	/*config gameplay*/
	if(!frame_counter){
		wait_vbl_done();
		
		HIDE_BKG;
		HIDE_WIN;
		HIDE_SPRITES;
		SWITCH_ROM_MBC1(BANK_GRAPHICS);
		set_bkg_data(0, background_tile_count, background_tile_data);
		set_win_data(0x5C, 19, hub); //hub
	    set_bkg_tiles(0, 0, 20, 18, background_map_data);
	    set_win_tiles(0, 0, 20, 1, hub_map);
	    set_sprite_data(0, 80, &player);
		set_sprite_data(80, 2, &bubble);
		set_sprite_data(82, 32, &enemies);

	    move_win(7u, 136u);	
		OBP0_REG = 0xC4; //11 00 01 00
		
		SWITCH_ROM_MBC1(0x01);
		CP_LoadMusic(3, 0, 0 );	
		CP_Play();

		lives = 3u;
		gravity = 0x02;
		jump_force = 0x06;	
		speed_movement = 0x02;
	    xpos = 0x58;
	    ypos = 0x10;
		ysp = 0x00;
		xsp = 0x00;
		sflip = 0x00;
		fx_jump_finished = 0x01;
		player_direction = 0x06;

		enemies_speed = 1;

		random_seed |= (UWORD)DIV_REG << 8;
		initrand(random_seed);
		
		drawPlayer();
		movePlayer();
		initBubbles();
		initEnemies();

		SHOW_BKG;
    	SHOW_WIN;
	}

	if(frame_counter != 20){
		frame_counter+= 1u;
	}else{		
    	SHOW_SPRITES;
		game_state = STATE_GAME_PLAY;	
		frame_counter = 0;		
	}
}