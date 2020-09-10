


#define GAMESTATE_BOOT 0x00
#define GAMESTATE_INTRO 0x01
#define GAMESTATE_TITLE 0x02
#define GAMESTATE_PLAY  0x03
#define GAMESTATE_PAUSE 0x04
#define GAMESTATE_OVER  0x05

#define GAMESTATE_LOGO  0x06

#define GAMESTATE_LOAD_GAMEPLAY  0x08
#define GAMESTATE_PLAYER_DIE 0x09




#define MAX_BUBBLES_ON_SCREEN 0x03
#define BUBBLE_SPEED 0x02

#define ENEMIES_SPEED 0x03


#define MAXIMO(a,b) (a > b) ? a : b
#define SPRITE_LENGTH 16u
#define CLICKED(x) ((joystate & x) && (joystate & x) != (oldjoystate & x))
#define RELEASED(x) (!(joystate & x) && (joystate & x) != (oldjoystate & x))
#define ISDOWN(x) (joystate & (x))
#define GRAVITY 0x01;



const unsigned char hub_no_element = 0x66;
const unsigned char hub_bubble = 0x6E;
const unsigned char hub_live = 0x67;
/*auxs*/
UINT8 i;
UINT8 j;



/*game vars*/
UINT8 GAMESTATE;
UINT8 game_play_counter;

UINT16 frame_counter; //delays
UINT8 oldjoystate, joystate;

UINT16 temp_score;
UINT16 score;
UINT16 hi_score;
UINT8 easy_mode;





/* water*/
INT16 water_animation; /* does not work with UINT8 */
UINT8 water_delay;

/* enemie*/
UINT8 enemie_animation_a; 
UINT8 enemie_animation_b; 
UINT8 enemie_animation_c; 
UINT8 enemie_delay;



/*fx*/
UINT8 fx_jump_finished;

/*sprite vars*/


/*bubbles*/


/*enemies*/
UINT8 max_enemies_on_creen; 

UINT8 enemies_speed;
UINT8 used_enemies;
UINT8 collision_1;



UINT8 wave_fish;
UINT8 wave_star;



/* ram*/
UINT16 *mbc_ram_pointer; 
UINT8 random_number; 
UINT16 random_seed; 

UINT8 last_row;
UINT8 delay_new_enemie;





struct Player player;  



UINT8 enemies_x[8];
UINT8 enemies_y[8];
UINT8 enemies_active[8];
UINT8 enemies_direction[8];
UINT8 enemies_type[8];
UINT8 enemies_sprite[8];
UINT8 enemies_jumps[8];

UINT8 enemies_splash;
UINT8 enemies_splash_delay;


UINT8 bubbles_x[3];
UINT8 bubbles_y[3];
UINT8 bubbles_active[3];
UINT8 bubbles_direction[3];

UINT8 x1, y1, w1, h1; 
UINT8 x2, y2, w2, h2;
UINT8 s1, s2, s3, s4;	 
