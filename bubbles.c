
/***********************************/
/************* BUBBLES *************/
/***********************************/
void deactiveBubble(UINT8 i){
	bubbles[i].active = 0;
	bubbles[i].x = 0;
	bubbles[i].y = 0;
	//move_sprite(8 + i, 0, 0); 

	if(player.used_bubbles != 0){
		player.used_bubbles-=1U;
	}
}


void initBubbles(){  
	for( i = 0; i != MAX_BUBBLES_ON_SCREEN; i ++){
     	bubbles[i].x = 0;
     	bubbles[i].y = 0;
     	bubbles[i].active = 0;     
  	}
	player.used_bubbles = 0;
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

void newBubble(){   
	p_bubble = &bubbles[0];
	for( i = 0; i != MAX_BUBBLES_ON_SCREEN; i+=1u){
	    if( !p_bubble->active){    
		     p_bubble->y = player.y + 8;
		     p_bubble->active = 1;
		     player.used_bubbles+=1U;
		     p_bubble->direction = player.direction;
		     //playSoundShoot();
		     if(p_bubble->direction == 0x06){
		     	p_bubble->x = player.x + 16;
		     }else{
		     	p_bubble->x = player.x;
		     }		     		     
		     break;
	    }
	    p_bubble++;
  	}
}






void updateBubbles(){
	if(player.used_bubbles){
		p_bubble = &bubbles[0];
		for( j = 0; j != MAX_BUBBLES_ON_SCREEN; j+=1u){
			if(p_bubble->active){
				if( p_bubble->x < 168  || p_bubble->x < 4){

					if(p_bubble->direction == 0x06){
     					p_bubble->x+= 2u;			     	
					     	}else{		     		
				     	p_bubble->x-= 2u;
			     	}

					if(used_enemies){
						p_enemie = &enemies[0];
						for( i = 0; i != used_enemies; i+=1u){
							c = collideEenemie(i, p_bubble->x, p_bubble->y + 4, 8u, 9u );
							if(c){ //collision
								FX_Play(8);		
								if(enemies_direction[i]){
									set_sprite_tile(16 + i, 0x52 );
									set_sprite_tile(28 + i, 0x54 );		
								}else{
									set_sprite_tile(16 + i, 0x54 );
									set_sprite_tile(28 + i, 0x52 );	
								}

								if( enemies_type[i] == 3){
									set_sprite_tile(16 + i, 0x52 );
									set_sprite_tile(28 + i, 0x54 );		
								}
								deactiveEnemie(i, 0x00);								
								deactiveBubble(j);														
								if(score != 999u){
									switch(enemies_type[i]){
										case 2://fish
											score+=3U;
										break;
										case 3:
											score+=2U;//star
										break;
										default :
											score+=1U;//bird
										break;
									}									
									updateScore();							
								}	
								break;					
							}
						}
					}						
				}else{
		  			deactiveBubble(j);
	    		}
	    			

				if(p_bubble->direction == 0x06){
					set_sprite_prop(8 + j, 0x00);
				}else{
					set_sprite_prop(8 + j, 0x20);
			     	
				}
				move_sprite(8 + j, p_bubble->x, p_bubble->y);
		 	}
		 	p_bubble++;
	  	}
		/*set_win_tiles(17, 0, 1U, 1U, &hub_bubble);
		set_win_tiles(18, 0, 1U, 1U, &hub_bubble);		
		set_win_tiles(19, 0, 1U, 1U, &hub_bubble);		
		for(j = 0; j < player.used_bubbles; j+=1u){				
			set_win_tiles(17 + j, 0, 1U, 1U, &hub_no_element);
		}*/	
  	}
}



