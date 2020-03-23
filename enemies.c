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


void deactiveEnemie(UINT8 i, UINT8 move){	
	enemies_x[i] = 0;
	enemies_y[i] = 0;
	enemies_active[i] = 0;
	enemies_direction[i] = 0;
	enemies_jumps[i] = 0;

	//enemies_type[i] = 0;
	if(move){
		move_sprite(16+i , 0, 0);
		move_sprite(28+i , 0, 0);	
	}
	

	if(used_enemies != 0){
		used_enemies-=1U;
	}
}

void initEnemies(){		
	used_enemies = 0;
	for(i = 0; i < max_enemies_on_creen; i+=1){		
		deactiveEnemie(i, 0x01);
	}
}


void drawEnemie(UINT8 i){
	move_sprite(16+i , enemies_x[i], enemies_y[i]);
	move_sprite(28+i , enemies_x[i] + 8, enemies_y[i] );
}


void collidePlayer(){
	
	if(used_enemies){
		for( i = 0; i != used_enemies; i+=1u){
			c = collideEenemie(i, player.x+ 4, player.y + 4, 24u, 24u );
			if(c){ //collision		
				FX_Play(5);		

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
				
				
				GAMESTATE = GAMESTATE_PLAYER_DIE;
				break;
			}
		}
		
	}
}




void updateEnemies(){
	if(used_enemies){
		for( i = 0; i != max_enemies_on_creen; i+=1u){
			if(enemies_active[i]){ 
				if( enemies_x[i] < 168  || enemies_x[i] < 4){										
					

					switch(enemies_type[i]){
						case 2: //fish
							if(wave_fish < 16 ){
								enemies_y[i] += enemies_speed;			     	
							}else{
								enemies_y[i] -= enemies_speed;			     	

							}

							if(wave_fish == 32 ){
								wave_fish = 0;
							}else{
								wave_fish+= 1;
							}

							if(enemies_direction[i]){
				     			enemies_x[i] += enemies_speed;				     		
				     		}else{		     		
					     		enemies_x[i] -= enemies_speed;
				     		}
						break;

						case 3: //star
							if(enemies_y[i] < 96){
								enemies_direction[i] = 1;
								enemies_jumps[i]+=1;
								set_sprite_tile(16 + i, 0x6A );
			     				set_sprite_tile(28 + i, 0x6C );										
							}

							if( enemies_y[i] > 136){
								if(enemies_jumps[i] < 1){
									enemies_direction[i] = 0;
									set_sprite_tile(16 + i, 0x66 );
			     					set_sprite_tile(28 + i, 0x68 );											
			     				}else{
				     				deactiveEnemie(i);
				     				break;
				     			}
								
							}

							if(enemies_direction[i]){
				     			enemies_y[i] += enemies_speed;				     							     		
				     		}else{		     		
					     		enemies_y[i] -= enemies_speed;					     		
				     		}

				     	



						break;
						default : //bird
							if(enemies_direction[i]){
				     			enemies_x[i] += enemies_speed;			     	
				     		}else{		     		
					     		enemies_x[i] -= enemies_speed;
				     		}					
						break;
					}

					
				}else{
		  			deactiveEnemie(i, 0x01);
	    		}
	    		drawEnemie(i);    	
	    		
		 	}
	  	}
		
  	}
}


void newEnemie(){  

	for( i = 0; i != max_enemies_on_creen; i+=1u){
	    if( !enemies_active[i]){
    		 
    		 random_number = rand();
		     enemies_type[i] =  random_number >> 6; //0 - 3 
		     random_number = rand();
	     	 enemies_direction[i] = random_number >> 7; // 0- 1

		     switch(enemies_type[i]){		     	

		     	case 2 : //fish
			     	enemies_y[i] = 7;
			     	enemies_jumps[i] = 0;
			     	last_row = enemies_y[i];			     	
			     	enemies_y[i] = enemies_y[i] << 4;

			     	if(enemies_direction[i]){
			     		enemies_x[i] = 8;	
			     		set_sprite_tile(16 + i, 0x5E );
			     		set_sprite_tile(28 + i, 0x60 );
			     		set_sprite_prop(16 + i , 0x00);
			     		set_sprite_prop(28 + i , 0x00);
			     	}else{
			     		enemies_x[i] = 159;
			     		set_sprite_tile(28 + i, 0x5E );
			     		set_sprite_tile(16 + i, 0x60 );
			     		set_sprite_prop(16 + i, 0x20);
			     		set_sprite_prop(28 + i, 0x20);
			     	}			     	
		     	break;

		     	case 3: //star
			     	enemies_x[i] = random_number >> 4; // 0 - 8
		     		if (last_row == enemies_x[i]){
		     			enemies_x[i]+=1;
		     		}

		     		if(enemies_x[i] == 0){
		     			enemies_x[i] = 1;
		     		}

		     		if(enemies_x[i] > 10){
		     			enemies_x[i] = 10;
		     		}
			     	last_row = enemies_x[i];
			     	
			     	enemies_x[i] = enemies_x[i] << 4;		     	  	
	     			enemies_y[i] = 128;	
		     		set_sprite_tile(16 + i, 0x66 );
		     		set_sprite_tile(28 + i, 0x68 );	
		     		set_sprite_prop(16 + i , 0x00);
		     		set_sprite_prop(28 + i , 0x00);		     		
			    
		     	break;
		     	
		     	default :

		     		enemies_y[i] = random_number >> 5; // 0 - 8
		     		if (last_row == enemies_y[i]){
		     			enemies_y[i]+=1;
		     		}

		     		if(enemies_y[i] == 0){
		     			enemies_y[i] = 1;
		     		}

		     		if(enemies_y[i] > 6){
		     			enemies_y[i] = 6;
		     		}
			     	last_row = enemies_y[i];

			     	
			     	enemies_y[i] = enemies_y[i] << 4;		     	

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



void animateEnemies(){
	if(enemie_delay > 4u){			  	
	  	enemie_delay = 0;
	  	for(i = 0; i < used_enemies; i +=1){

	  		if(enemies_active[i]){

		  		switch(enemies_type[i]){
		 			case 2 :
						enemie_animation_b = enemie_animation_b ? 0 : 4;
						if(enemies_direction[i]){
							set_sprite_tile(16 + i, 0x5E + enemie_animation_b);
							set_sprite_tile(28 + i, 0x60 + enemie_animation_b);	
						}else{
							set_sprite_tile(28 + i, 0x5E + enemie_animation_b);
							set_sprite_tile(16 + i, 0x60 + enemie_animation_b);	
						}
						
					break;

					case 3:
						
					break;

					default:					
						enemie_animation_a = enemie_animation_a ? 0 : 4;
						if(enemies_direction[i]){
							set_sprite_tile(16 + i, 0x56 + enemie_animation_a);
							set_sprite_tile(28 + i, 0x58 + enemie_animation_a);
						}else{
							set_sprite_tile(28 + i, 0x56 + enemie_animation_a);
							set_sprite_tile(16 + i, 0x58 + enemie_animation_a);
						}
					break;	
				}
			}		  	
		}
	}else{
		enemie_delay+= 1u;
	}
}	