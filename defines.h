#include <gb/gb.h>
#include <string.h>
#include <stdio.h> 
#include <rand.h> 
/*audio*/
#include "libs/carillon_funcs.c"


#define STATE_GAME_BOOT 0x00
#define STATE_GAME_INTRO 0x01
#define STATE_GAME_TITLE 0x02
#define STATE_GAME_PLAY  0x03
#define STATE_GAME_PAUSE 0x04
#define STATE_GAME_OVER  0x05

#define STATE_GAME_LOGO  0x06
#define STATE_GAME_CONTEST  0x07
#define STATE_GAME_LOADGAMEPLAY  0x08
#define STATE_GAME_PLAYERDIE 0x09

#define BANK_GRAPHICS 0X02
#define MAX_BUBBLES_ON_SCREEN 0x03
#define BUBBLE_SPEED 0x03

#define MAX_ENEMIES_ON_SCREEN 0x01
#define ENEMIES_SPEED 0x03


#define MAXIMO(a,b) (a > b) ? a : b
#define SPRITE_LENGTH 16u
#define CLICKED(x) ((joystate & x) && (joystate & x) != (oldjoystate & x))
#define RELEASED(x) (!(joystate & x) && (joystate & x) != (oldjoystate & x))
#define ISDOWN(x) (joystate & (x))



extern const int oldrobotto_tile_count;
extern const unsigned char oldrobotto_map_data[];
extern const unsigned char oldrobotto_tile_data[]; 

extern const int logo_2_a_tile_count;
extern const unsigned char logo_2_a_map_data[];
extern const unsigned char logo_2_a_tile_data[]; 

extern const int logo_2_b_tile_count;
extern const unsigned char logo_2_b_map_data[];
extern const unsigned char logo_2_b_tile_data[]; 
extern const unsigned char year[];

extern const int background_tile_count;
extern const unsigned char background_map_data[];
extern const unsigned char background_tile_data[]; 
extern const unsigned char hub[];
extern const unsigned char hub_map[];
const unsigned char hub_no_element = 0x66;
const unsigned char hub_bubble = 0x6E;
const unsigned char hub_live = 0x67;

extern const unsigned char player[];
extern const unsigned char bubble[];
extern const unsigned char water[];
extern const unsigned char enemies[];

/*auxs*/
UINT8 i;
UINT8 j;

/*game vars*/
UINT8 game_state;
UINT8 game_play_counter;

UINT16 frame_counter; //delays
UINT8 oldjoystate, joystate;
UINT16 score;


/* player*/
UINT8 player_animation; /* does not work with UINT16 */
UINT8 player_delay;


/* water*/
INT16 water_animation; /* does not work with UINT16 */
UINT8 water_delay;

/* bird*/
UINT8 bird_animation; /* does not work with UINT16 */
UINT8 bird_delay;

/* player vars*/ 
UINT8 xpos, ypos, ypos2; 
UINT8 ysp, xsp, gravity, jump_force, speed_movement, player_direction;
UINT8 lives; 
UINT8 used_bubbles; 

UINT8 distance;

/*fx*/
UINT8 fx_jump_finished;

/*sprite vars*/
UINT8 sflip, sprite_index;

/*bubbles*/
UINT8 bubbles_x[MAX_BUBBLES_ON_SCREEN];
UINT8 bubbles_y[MAX_BUBBLES_ON_SCREEN];
UINT8 bubbles_active[MAX_BUBBLES_ON_SCREEN];
UINT8 bubbles_direction[MAX_BUBBLES_ON_SCREEN];

/*enemies*/
UINT8 enemies_x[12];
UINT8 enemies_y[12];
UINT8 enemies_active[12];
UINT8 enemies_direction[12];
UINT8 enemies_type[12];
UINT8 enemies_speed;
UINT8 used_enemies;
UINT8 c;





/* ram*/
UINT16 *mbc_ram_pointer; 
UINT8 random_number; 
UINT8 old_random_number; 
UINT16 random_seed; 



