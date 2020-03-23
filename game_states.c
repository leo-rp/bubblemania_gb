


void animateWater(){
	if(water_delay > 9u){
		water_delay = 0;
		if(water_animation < 512u){		
			SWITCH_ROM_MBC1(BANK_GRAPHICS);
			memcpy(0x9580, &water[water_animation], SPRITE_LENGTH);
			memcpy(0x95A0, &water[water_animation + 16u ], SPRITE_LENGTH);
			memcpy(0x9590, &water[water_animation + 32u ], SPRITE_LENGTH);
			memcpy(0x95B0, &water[water_animation + 48u ], SPRITE_LENGTH);
			
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
	
	//GAMESTATE = GAMESTATE_LOGO;
	//turnOnSound();
	random_seed = DIV_REG;
	GAMESTATE = GAMESTATE_LOGO;
	FX_Bank(BANK_FX);
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
	  
		SHOW_BKG;
		SHOW_SPRITES;
	}

	if(frame_counter != 30u){
		frame_counter+= 1u;
	}else{
		GAMESTATE = GAMESTATE_TITLE;	
		frame_counter = 0;		
	}
}



/**/
void stateGameIntro(){
	GAMESTATE = GAMESTATE_TITLE;
	frame_counter = 0;
}

/*GAME TTILE*/
void stateGameTitle(){
	if(frame_counter == 0){
		HIDE_BKG;
		HIDE_WIN;
		HIDE_SPRITES;
		SWITCH_ROM_MBC1(BANK_GRAPHICS);
		set_bkg_data(0, bubblemania_tile_count, bubblemania_tile_data);
		set_bkg_tiles(0, 0, 20, 18, bubblemania_map_data); 
		SHOW_BKG;
		frame_counter = 1;
		CP_LoadMusic(BANK_MUSIC, BANK_SMUSIC, 0 );		
		CP_Play();
	}

	if(joypad() & J_START){
		//FX_Play(3);
		CP_Pause();
		
		GAMESTATE = GAMESTATE_LOAD_GAMEPLAY;
		frame_counter = 0;
	}
}

void stateGameGameOver(){	

	if( frame_counter == 0){
		frame_counter = 1;
		
		HIDE_WIN;
		HIDE_SPRITES;
		SWITCH_ROM_MBC1(BANK_GRAPHICS);
		set_sprite_data(0, 28, &game_over);
		set_sprite_tile(0, 0); //G
		set_sprite_tile(1, 2); //A
		set_sprite_tile(2, 4); //M
		set_sprite_tile(3, 6); //E

		set_sprite_tile(4, 8); //O
		set_sprite_tile(5, 10); //V
		set_sprite_tile(6, 6); //E
		set_sprite_tile(7, 12); //R

		set_sprite_prop(0, 0x00); //G
		set_sprite_prop(1, 0x00); //A
		set_sprite_prop(2, 0x00); //M
		set_sprite_prop(3, 0x00); //E
		set_sprite_prop(4, 0x00); //O
		set_sprite_prop(5, 0x00); //V
		set_sprite_prop(6, 0x00); //E
		set_sprite_prop(7, 0x00); //R

		move_sprite(0, 56, 48);
		move_sprite(1, 64, 48);
		move_sprite(2, 72, 48);
		move_sprite(3, 80, 48);
		move_sprite(4, 92, 48);
		move_sprite(5, 100, 48);
		move_sprite(6, 108, 48);
		move_sprite(7, 116, 48);


		if (score > hi_score){		

				hi_score = score;
				save_score();
			
				set_sprite_tile(8, 0x16); //N
				set_sprite_tile(9, 0x06); //E
				set_sprite_tile(10, 0x18); //W				
				set_sprite_tile(11, 0x12); //S
				set_sprite_tile(12, 0x14); //C
				set_sprite_tile(13, 8); //O
				set_sprite_tile(14, 12); //R
				set_sprite_tile(15, 6); //E
				set_sprite_tile(16, 0x1A); //!
				set_sprite_tile(16, 0x1A); //!

				set_sprite_prop(8, 0x00); 
				set_sprite_prop(9, 0x00); 
				set_sprite_prop(10, 0x00); 
				set_sprite_prop(11, 0x00); 
				set_sprite_prop(12, 0x00); 
				set_sprite_prop(13, 0x00); 
				set_sprite_prop(14, 0x00); 
				set_sprite_prop(15, 0x00); 
				set_sprite_prop(16, 0x00); 


				move_sprite(8, 56, 64);
				move_sprite(9, 64, 64);
				move_sprite(10, 72, 64);
				move_sprite(11, 84, 64);
				move_sprite(12, 92, 64);
				move_sprite(13, 100, 64);
				move_sprite(14, 108, 64);
				move_sprite(15, 116, 64);			
				move_sprite(16, 124, 64);			
		}		

		SHOW_SPRITES;
		SHOW_WIN;

	}
	animateWater();	

	if(joypad() & J_START){		
		set_sprite_tile(11, 0x72); //S
		set_sprite_tile(12, 0x72); //C
		set_sprite_tile(13, 0x72); //O
		set_sprite_tile(14, 0x72); //R
		set_sprite_tile(15, 0x72); //E
		set_sprite_tile(16, 0x72); //!

		move_sprite(11, 0,0); //S
		move_sprite(12, 0,0); //C
		move_sprite(13, 0,0); //O
		move_sprite(14, 0,0); //R
		move_sprite(15, 0,0); //E
		move_sprite(16, 0,0); //!
		GAMESTATE = GAMESTATE_LOAD_GAMEPLAY;
		frame_counter = 0;
	}
	
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
	    set_sprite_data(0, 80, &player_sprites);
		set_sprite_data(80, 2, &bubble_sprites);
		set_sprite_data(82, 32, &enemies_sprites);

	    move_win(7u, 136u);	
		OBP0_REG = 0xC4; //11 00 01 00
		
		//SWITCH_ROM_MBC1(0x01);
		CP_LoadMusic(BANK_MUSIC, BANK_SMUSIC, 0 );	
		CP_Play();
		//CP_FxPlay(1u);

		player.lives = 3u;

		player.jump_force = 0x04;	
		
	    player.x = 0x58;
	    player.y = 0x10;
		player.y_speed = 0x00;
		
		player.sprite_hflip = 0x00;
		fx_jump_finished = 0x01;
		player.direction = 0x06;
		score = 0x00;
		load_score();
		max_enemies_on_creen = 2;


		enemies_speed = 1;

		random_seed |= (UWORD)DIV_REG << 8;
		initrand(random_seed);
		
		drawPlayer();
		movePlayer();
		initBubbles();
		initEnemies();
	 	CP_Play();

		SHOW_BKG;
    	SHOW_WIN;
	}

	if(frame_counter != 20){
		frame_counter+= 1u;
	}else{		
    	SHOW_SPRITES;
		GAMESTATE = GAMESTATE_PLAY;	
		frame_counter = 0;		
	}
}

