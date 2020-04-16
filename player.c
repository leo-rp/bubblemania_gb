
void drawPlayerlives(){
	set_win_tiles(0, 0, 1U, 1U, &hub_no_element);
	set_win_tiles(1, 0, 1U, 1U, &hub_no_element);		
	set_win_tiles(2, 0, 1U, 1U, &hub_no_element);
	
	for(i = 0; i < player.lives; i+=1u){				
		set_win_tiles(i, 0, 1U, 1U, &hub_live);
	}	
}

void initPlayer(){
	player.x = 0x58;
	player.y = 0x10;
	player.y_speed = 0x00;	
	player.sprite_hflip = 0x00;
	player.direction = 0x06;									
	player.lives-=1;
	player.is_dying = 0x00;
	drawPlayerlives();	
}

void drawPlayer(){
	if(player.sprite_hflip){
		set_sprite_tile(0, player.sprite_index + 10U);
		set_sprite_tile(1, player.sprite_index + 8U);	
		set_sprite_tile(2, player.sprite_index + 14U);
		set_sprite_tile(3, player.sprite_index + 12U);		
		set_sprite_tile(4, player.sprite_index + 2U);	
		set_sprite_tile(5, player.sprite_index);
		set_sprite_tile(6, player.sprite_index + 6U);		
		set_sprite_tile(7, player.sprite_index + 4U);			
	}else{	
		set_sprite_tile(0, player.sprite_index);
		set_sprite_tile(1, player.sprite_index + 2U);	
		set_sprite_tile(2, player.sprite_index + 4U);
		set_sprite_tile(3, player.sprite_index + 6U);		
		set_sprite_tile(4, player.sprite_index + 8U);	
		set_sprite_tile(5, player.sprite_index + 10U);
		set_sprite_tile(6, player.sprite_index + 12U);		
		set_sprite_tile(7, player.sprite_index + 14U);
	}
	set_sprite_prop(0, player.sprite_hflip);
	set_sprite_prop(1, player.sprite_hflip);
	set_sprite_prop(2, player.sprite_hflip);
	set_sprite_prop(3, player.sprite_hflip);
	set_sprite_prop(4, player.sprite_hflip);
	set_sprite_prop(5, player.sprite_hflip);
	set_sprite_prop(6, player.sprite_hflip);
	set_sprite_prop(7, player.sprite_hflip);
}


void movePlayer(){
	move_sprite(0, player.x, player.y);
	move_sprite(1, player.x + 8u, player.y);
	move_sprite(4, player.x + 16u, player.y);
	move_sprite(5, player.x + 24u, player.y);

	player.height = player.y + 16u;
	move_sprite(2, player.x, player.height);
	move_sprite(3, player.x + 8u, player.height);
	move_sprite(6, player.x + 16u, player.height);
	move_sprite(7, player.x + 24u, player.height);
}

void animatePlayer(){
	if(player.delay > 9u){
		player.delay = 0;
		if(!player.is_dying){
			player.sprite_index =  player.sprite_index ? 0 : 16u;
		}
	}else{
		player.delay+= 1u;
	}
}	



void movePlayerToLeft(){
	player.sprite_hflip= 0x20;
	player.direction = 0x04;
	if(player.x != 8u){
		player.x-= 0x02;	
	}
}

void movePlayerToRight(){
	player.sprite_hflip= 0x00;
	player.direction = 0x06;				
	if(player.x != 136u){
		player.x+= 0x02;	
	}	
}

void movePlayerToDown(){	
	
	if(player.y != 130u){
		player.y+= 0x02;	
	}	
}

void playerJump(UINT8 f){
	if( player.y > 14u){	
		player.y_speed = f;
	}
}

void playerShootBubble(){
	
	player.sprite_index = 32u;	
}


void updatePlayer(){
	if(player.y_speed != 0x00){
		 player.y_speed-= 0x01;
	}		

	player.y-= player.y_speed;				
	//if(player.y < 130u){  easy mode 
		player.y+= GRAVITY;	
	//}
	

	drawPlayer();
	movePlayer();
	animatePlayer();		
}

void playSoundJump(){
	/*NR10_REG = 0x77;
	NR11_REG = 0x41;
	NR12_REG = 0x82;
	NR13_REG = 0xC2;
	NR14_REG = 0xC6;*/

}