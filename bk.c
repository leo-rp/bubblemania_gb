//backup



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


INT16 map_down_collision(INT16 x, INT16 y){
	INT16 a, b, x2;
	
	x2 = x + 0x06;
	x = x - 0x06;
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
		case 0x08:
			y = y - 0x0D;
		break;
		
		case 0x06: //right
			//x-= 0x01;
			//x+= xsp;
			b = 0x02;
			a = 0x02;
			
		break;
		
		case 0x02: //down
		break;
		
		
		case 0x04: //left			
			//x-= xsp;
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