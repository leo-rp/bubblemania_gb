void enemieSplash(UINT8 x, UINT8 y){
	enemies_splash_delay = 100u;
	set_sprite_tile(11, 0x52 );
	set_sprite_tile(12, 0x54 );		
			
	move_sprite(11, x, y);
	move_sprite(12, x + 8, y);
	//add points 
}

void deactiveEnemie(UINT8 i){	
	enemies_x[i] = 0;
	enemies_y[i] = 0;
	enemies_active[i] = 0;
	enemies_direction[i] = 0;

}


void collideWithEnemie(UINT8 i){
	
	x1 = player.x+ 4;
	y1 = player.y + 4;
	w1 = 24u;
	h1 = 24u;
	x2 = enemies_x[i];							     		
	w2 = 15;
	y2 = enemies_y[i] + 4;
	h2 = 10;
	
	s1 = x1 + w1; // r1 right edge past r2 left
	s2 = x2 + w2; // r1 left edge past r2 right
	s3 = y1 + h1; // r1 top edge past r2 bottom
	s4 = y2 + h2; // r1 bottom edge past r2 top*/

	if( x2 >= s1 || s2 <= x1 || y2 >= s3 || s4 <= y1 ){
		collision_1 =  0;

		for( j = 0; j != MAX_BUBBLES_ON_SCREEN; j+=1u){
				if(bubbles_active[j]){
					x1 = bubbles_x[j];
					y1 = bubbles_y[j] + 4;
					w1 = 8u;
					h1 = 9u;
					/*x2 = enemies_x[i];							     		
					w2 = 15;
					y2 = enemies_y[i] + 4;
					h2 = 10;*/
		
					s1 = x1 + w1; // r1 right edge past r2 left
					s2 = x2 + w2; // r1 left edge past r2 right
					s3 = y1 + h1; // r1 top edge past r2 bottom
					s4 = y2 + h2; // r1 bottom edge past r2 top*/

					if( x2 >= s1 || s2 <= x1 || y2 >= s3 || s4 <= y1 ){
						//no collision
					}else{
						
						//FX_Play(8);							
						enemieSplash(enemies_x[i], enemies_y[i]);
						
																				
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
						deactiveEnemie(i);
						deactiveBubble(j);
					}
					


					
				}
			}
	}else{
		collision_1 = 1;
	}


}






void initEnemies(){		
	used_enemies = 0;
	for(i = 0; i < max_enemies_on_creen; i+=1){		
		deactiveEnemie(i);
	}
}




void enemieSplashUpdate(){
	if(enemies_splash_delay){
		

		if(enemies_splash_delay== 1){
			//points
		}
		enemies_splash_delay-= 1u;
	}else{
		move_sprite(11, 0, 0);
		move_sprite(12, 0, 0);
	}
}



void updateEnemies(){
	
		for( i = 0; i != max_enemies_on_creen; i+=1u){
			if(enemies_active[i]){ 

				if( enemies_x[i] < 170  || enemies_x[i] < 1){															
					
					collideWithEnemie(i);

					if(collision_1){ //collision		
						
						deactiveEnemie(i);
						enemieSplash(enemies_x[i], enemies_y[i]);
						GAMESTATE = GAMESTATE_PLAYER_DIE;
						return;
					}


					
					if(enemies_active[i]){ 



						// update enemie pos
						switch(enemies_type[i]){


							case 2: //fish
								if(wave_fish < 16 ){
									enemies_y[i]+= enemies_speed;			     	
								}else{
									enemies_y[i]-= enemies_speed;			     	

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
									enemies_direction[i] = 0;

									set_sprite_tile(16 + i, 0x6A );
				     				set_sprite_tile(28 + i, 0x6C );										
								}

								if( enemies_y[i] > 136){

										enemies_direction[i] = 1;
										set_sprite_tile(16 + i, 0x66 );
				     					set_sprite_tile(28 + i, 0x68 );									
								}

								if(enemies_direction[i]){
					     		 		enemies_y[i]-= enemies_speed;	//up				     			
					     		}else{		     		
						     	
						     		enemies_y[i]+= enemies_speed;	//down			     							     		
					     		}
					     	
							break;
							default : //bird
								if(enemies_direction[i]){
					     			enemies_x[i]+= enemies_speed;			     	
					     		}else{		     		
						     		enemies_x[i]-= enemies_speed;
					     		}
					     	
							break;
						}

						
					}

					
				}else{
		  			deactiveEnemie(i);

	    		}

	    		
	    	
		 	}
		move_sprite(16+i , enemies_x[i], enemies_y[i]);
		move_sprite(28+i , enemies_x[i] + 8, enemies_y[i] );
		enemieSplashUpdate();

	  	}
	  	
		
  	}


void animateEnemies(){
	if(enemie_delay > 4u){			  	
	  	enemie_delay = 0;
	  	for(i = 0; i < max_enemies_on_creen; i +=1){

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
						//animate the fucking star
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

void newEnemie(){  


	for( i = 0; i != max_enemies_on_creen; i+=1u){
	    if( !enemies_active[i]){
    		 
    		 random_number = rand();
		     enemies_type[i] =  random_number >> 6; //0 - 3 
		     random_number = rand();
	     	 enemies_direction[i] = random_number >> 7; // 0- 1*/

		     switch(enemies_type[i]){		     	

		     	case 2 : //fish
			     	enemies_y[i] = 7;
			     	

			     	last_row = enemies_y[i];			     	
			     	enemies_y[i] = enemies_y[i] << 4;

			     	if(enemies_direction[i]){
			     		enemies_x[i] = 0;	
			     		set_sprite_tile(16 + i, 0x5E );
			     		set_sprite_tile(28 + i, 0x60 );
			     		set_sprite_prop(16 + i , 0x00);
			     		set_sprite_prop(28 + i , 0x00);
			     	}else{
			     		enemies_x[i] = 168;
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
			     		enemies_x[i] = 0;	
			     		set_sprite_tile(16 + i, 0x56 );
			     		set_sprite_tile(28 + i, 0x58 );
			     		set_sprite_prop(16 + i , 0x00);
			     		set_sprite_prop(28 + i , 0x00);
			     	}else{
			     		enemies_x[i] = 168;
			     		set_sprite_tile(16 + i, 0x58 );
			     		set_sprite_tile(28 + i, 0x56 );			     					     		
			     		set_sprite_prop(16 + i, 0x20);
			     		set_sprite_prop(28 + i, 0x20);
			     	}

		     	break;
		     }	

		     enemies_active[i] = 1;
		     used_enemies+=1U;
		     
		     
		     break;
	    }
  	}

}



