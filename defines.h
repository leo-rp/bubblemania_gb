


#define GAMESTATE_BOOT 0x00
#define GAMESTATE_INTRO 0x01
#define GAMESTATE_TITLE 0x02
#define GAMESTATE_PLAY  0x03
#define GAMESTATE_PAUSE 0x04
#define GAMESTATE_OVER  0x05

#define GAMESTATE_LOGO  0x06

#define GAMESTATE_LOAD_GAMEPLAY  0x08
#define GAMESTATE_PLAYER_DIE 0x09

#define BANK_GRAPHICS 0x01
#define BANK_MUSIC 0x02
#define BANK_SMUSIC 0x00
#define BANK_FX 0x03
#define MAX_BUBBLES_ON_SCREEN 0x03
#define BUBBLE_SPEED 0x02

#define ENEMIES_SPEED 0x03


#define MAXIMO(a,b) (a > b) ? a : b
#define SPRITE_LENGTH 16u
#define CLICKED(x) ((joystate & x) && (joystate & x) != (oldjoystate & x))
#define RELEASED(x) (!(joystate & x) && (joystate & x) != (oldjoystate & x))
#define ISDOWN(x) (joystate & (x))
#define GRAVITY 0x01;

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

extern const unsigned char bubblemania_map_data[];
extern const unsigned char bubblemania_tile_data[];
extern const int bubblemania_tile_data_size;
extern const int bubblemania_tile_count;

extern const unsigned char game_over;
extern const unsigned char player_sprites[];
extern const unsigned char bubble_sprites[];
extern const unsigned char water[];
extern const unsigned char enemies_sprites[];

//extern const unsigned char game_over[];

/*auxs*/
UINT8 i;
UINT8 j;



/*game vars*/
UINT8 GAMESTATE;
UINT8 game_play_counter;

UINT16 frame_counter; //delays
UINT8 oldjoystate, joystate;
UINT16 score;
UINT16 hi_score;





/* water*/
INT16 water_animation; /* does not work with UINT16 */
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
UINT8 c;


UINT8 wave_fish;
UINT8 wave_star;



/* ram*/
UINT16 *mbc_ram_pointer; 
UINT8 random_number; 
UINT16 random_seed; 

UINT8 last_row;
UINT8 delay_new_enemie;
UINT8 delay_dead_enemie;





struct Player player;  
struct Bubble bubbles[MAX_BUBBLES_ON_SCREEN];
struct Enemie enemies[10];

struct Bubble *p_bubble; //pointer
struct Enemie *p_enemie; //pointer


	UINT8 enemies_x[10];
UINT8 enemies_y[10];
UINT8 enemies_active[10];
UINT8 enemies_direction[10];
UINT8 enemies_type[10];
UINT8 enemies_sprite[10];
UINT8 enemies_jumps[10];