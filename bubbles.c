
/***********************************/
/************* BUBBLES *************/
/***********************************/
void deactiveBubble(UINT8 i){
	bubbles_active[i] = 0;
	bubbles_x[i] = 0;
	bubbles_y[i] = 0;
	move_sprite(8 + i, 0, 0);
	//move_sprite(8 + i, 0, 0); 

	if(player.used_bubbles != 0){
		player.used_bubbles-=1U;

	}
}


void initBubbles(){  
	for( i = 0; i != MAX_BUBBLES_ON_SCREEN; i ++){
     	bubbles_x[i] = 0;
     	bubbles_y[i] = 0;
     	bubbles_active[i] = 0;     
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
	if(player.used_bubbles < 3){
		for( i = 0; i != MAX_BUBBLES_ON_SCREEN; i+=1u){
		    if( !bubbles_active[i]){    
			     bubbles_y[i] = player.y + 8;
			     bubbles_active[i] = 1;
			     bubbles_direction[i] = player.direction;
			     player.used_bubbles+=1U;
			     

			     if(bubbles_direction[i] == 0x06){
			     	bubbles_x[i] = player.x + 16;
			     }else{
			     	bubbles_x[i] = player.x;
			     }		     		     
			     break;
		    }
	  	}
  	}
}






void updateBubbles(){
	if(player.used_bubbles){
		
		for( j = 0; j != MAX_BUBBLES_ON_SCREEN; j+=1u){
			if(bubbles_active[j]){
				if( bubbles_x[j] < 168  || bubbles_x[j] < 4){

					if(bubbles_direction[j] == 0x06){
     					bubbles_x[j]+= 2u;			     	
					     	}else{		     		
				     	bubbles_x[j]-= 2u;

			     	}	
			     	move_sprite(8 + j, bubbles_x[j], bubbles_y[j]);					
				}else{
		  			deactiveBubble(j);
	    		}
		 	}
		 	
		 	
	  	}	

	
  	}
	set_win_tiles(17, 0, 1U, 1U, &hub_bubble);
	set_win_tiles(18, 0, 1U, 1U, &hub_bubble);		
	set_win_tiles(19, 0, 1U, 1U, &hub_bubble);			
	for(j = 0; j < player.used_bubbles; j+=1u){				
		set_win_tiles(17 + j, 0, 1U, 1U, &hub_no_element);
	}  	

  	
	
}



