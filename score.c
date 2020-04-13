

void save_score(){
	ENABLE_RAM_MBC1;
	mbc_ram_pointer = (UINT16 *)0xA000;
	mbc_ram_pointer[0] = hi_score;
	
	DISABLE_RAM_MBC1;
}

void load_score(){
	ENABLE_RAM_MBC1;
	mbc_ram_pointer = (	UINT16 *)0xA000;
	hi_score = mbc_ram_pointer[0];
	if( (hi_score < 1u) || (hi_score > 999u)  ){
		hi_score = 1;
	}
	DISABLE_RAM_MBC1;
}



/*void updateScore(){
	drawScore(9, 0, 0x5C, score);   
}*/

void updateScore(){

	if(score == 20u){
		max_enemies_on_creen = 3;
	}

	if(score == 40u){
		max_enemies_on_creen = 4;
	}

	if(score == 60u){
		max_enemies_on_creen = 5;
	}

	if(score == 80u){
		max_enemies_on_creen = 6;
	}

	if(score == 100u){
		max_enemies_on_creen = 7;
	}

	if(score == 120u){
		max_enemies_on_creen = 8;
	}

	if(score == 140u){
		max_enemies_on_creen = 9;
	}

	temp_score = score;

	if(score >= 100U) {
		temp_score = score / 100U;
		temp_score+= 0x5C;		
		set_win_tiles(10u, 0, 1U, 1U, &temp_score);
	}
	if(score >= 10U) {
		temp_score = (score / 10U) % 10;
		temp_score+= 0x5C;
		set_win_tiles(11u, 0, 1U, 1U, &temp_score);
	}
	if(score) {
		temp_score = score % 10U;
		temp_score+= 0x5C;
		set_win_tiles(12U, 0, 1U, 1U, &temp_score);		
	}	
	
}




