;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.0.3 #11875 (MINGW64)
;--------------------------------------------------------
	.module main
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _stateGamePlay
	.globl _stateGamePlayerDie
	.globl _stateGameLoadGameplay
	.globl _stateGameGameOver
	.globl _stateGameTitle
	.globl _stateGameIntro
	.globl _stateGameLogo
	.globl _stateGameBoot
	.globl _animateWater
	.globl _playSoundJump
	.globl _updatePlayer
	.globl _playerJump
	.globl _movePlayerToRight
	.globl _movePlayerToLeft
	.globl _animatePlayer
	.globl _movePlayer
	.globl _drawPlayer
	.globl _initPlayer
	.globl _drawPlayerlives
	.globl _newEnemie
	.globl _animateEnemies
	.globl _updateEnemies
	.globl _enemieSplashUpdate
	.globl _initEnemies
	.globl _collideWithEnemie
	.globl _deactiveEnemie
	.globl _enemieSplash
	.globl _updateScore
	.globl _updateBubbles
	.globl _newBubble
	.globl _initBubbles
	.globl _deactiveBubble
	.globl _rand
	.globl _initrand
	.globl _memcpy
	.globl _set_sprite_data
	.globl _set_win_tiles
	.globl _set_win_data
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _wait_vbl_done
	.globl _disable_interrupts
	.globl _enable_interrupts
	.globl _joypad
	.globl _s4
	.globl _s3
	.globl _s2
	.globl _s1
	.globl _h2
	.globl _w2
	.globl _y2
	.globl _x2
	.globl _h1
	.globl _w1
	.globl _y1
	.globl _x1
	.globl _bubbles_direction
	.globl _bubbles_active
	.globl _bubbles_y
	.globl _bubbles_x
	.globl _enemies_splash_delay
	.globl _enemies_splash
	.globl _enemies_jumps
	.globl _enemies_sprite
	.globl _enemies_type
	.globl _enemies_direction
	.globl _enemies_active
	.globl _enemies_y
	.globl _enemies_x
	.globl _player
	.globl _delay_new_enemie
	.globl _last_row
	.globl _random_seed
	.globl _random_number
	.globl _mbc_ram_pointer
	.globl _wave_star
	.globl _wave_fish
	.globl _collision_1
	.globl _used_enemies
	.globl _enemies_speed
	.globl _max_enemies_on_creen
	.globl _fx_jump_finished
	.globl _enemie_delay
	.globl _enemie_animation_c
	.globl _enemie_animation_b
	.globl _enemie_animation_a
	.globl _water_delay
	.globl _water_animation
	.globl _easy_mode
	.globl _hi_score
	.globl _score
	.globl _temp_score
	.globl _joystate
	.globl _oldjoystate
	.globl _frame_counter
	.globl _game_play_counter
	.globl _GAMESTATE
	.globl _j
	.globl _i
	.globl _hub
	.globl _hub_live
	.globl _hub_bubble
	.globl _hub_no_element
	.globl _game_over
	.globl _enemies_sprites
	.globl _bubble_sprites
	.globl _hub_map
	.globl _background_tile_data
	.globl _background_map_data
	.globl _background_tile_count
	.globl _background_tile_data_size
	.globl _background_tile_map_height
	.globl _background_tile_map_width
	.globl _background_tile_map_size
	.globl _water
	.globl _player_sprites
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_hub::
	.ds 304
_i::
	.ds 1
_j::
	.ds 1
_GAMESTATE::
	.ds 1
_game_play_counter::
	.ds 1
_frame_counter::
	.ds 2
_oldjoystate::
	.ds 1
_joystate::
	.ds 1
_temp_score::
	.ds 2
_score::
	.ds 2
_hi_score::
	.ds 2
_easy_mode::
	.ds 1
_water_animation::
	.ds 2
_water_delay::
	.ds 1
_enemie_animation_a::
	.ds 1
_enemie_animation_b::
	.ds 1
_enemie_animation_c::
	.ds 1
_enemie_delay::
	.ds 1
_fx_jump_finished::
	.ds 1
_max_enemies_on_creen::
	.ds 1
_enemies_speed::
	.ds 1
_used_enemies::
	.ds 1
_collision_1::
	.ds 1
_wave_fish::
	.ds 1
_wave_star::
	.ds 1
_mbc_ram_pointer::
	.ds 2
_random_number::
	.ds 1
_random_seed::
	.ds 2
_last_row::
	.ds 1
_delay_new_enemie::
	.ds 1
_player::
	.ds 12
_enemies_x::
	.ds 8
_enemies_y::
	.ds 8
_enemies_active::
	.ds 8
_enemies_direction::
	.ds 8
_enemies_type::
	.ds 8
_enemies_sprite::
	.ds 8
_enemies_jumps::
	.ds 8
_enemies_splash::
	.ds 1
_enemies_splash_delay::
	.ds 1
_bubbles_x::
	.ds 3
_bubbles_y::
	.ds 3
_bubbles_active::
	.ds 3
_bubbles_direction::
	.ds 3
_x1::
	.ds 1
_y1::
	.ds 1
_w1::
	.ds 1
_h1::
	.ds 1
_x2::
	.ds 1
_y2::
	.ds 1
_w2::
	.ds 1
_h2::
	.ds 1
_s1::
	.ds 1
_s2::
	.ds 1
_s3::
	.ds 1
_s4::
	.ds 1
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;graphics.c:623: unsigned char hub[] =
	ld	bc, #_hub+0
	ld	e, c
	ld	d, b
	call	__initrleblock
	.db	#24
	.db	#0xFF, #0xFF, #0xC3, #0xC3, #0xB9, #0xB9, #0x99, #0x99
	.db	#0xA9, #0xA9, #0xB1, #0xB1, #0xB9, #0xB9, #0xC3, #0xC3
	.db	#0xFF, #0xFF, #0xE3, #0xE3, #0xC3, #0xC3, #0xC3, #0xC3
	.db	#-6, #0xe3
	.db	#36
	.db	#0xC1, #0xC1, #0xFF, #0xFF, #0xC3, #0xC3, #0x99, #0x99
	.db	#0xF9, #0xF9, #0xE3, #0xE3, #0xCF, #0xCF, #0x9F, #0x9F
	.db	#0x81, #0x81, #0xFF, #0xFF, #0xC3, #0xC3, #0x99, #0x99
	.db	#0xF9, #0xF9, #0xE3, #0xE3, #0xF9, #0xF9, #0x99, #0x99
	.db	#0xC3, #0xC3, #0xFF, #0xFF
	.db	#-8, #0x99
	.db	#46
	.db	#0xC1, #0xC1, #0xF9, #0xF9, #0xF9, #0xF9, #0xFF, #0xFF
	.db	#0x81, #0x81, #0x9F, #0x9F, #0x83, #0x83, #0xF9, #0xF9
	.db	#0xF9, #0xF9, #0x99, #0x99, #0xC3, #0xC3, #0xFF, #0xFF
	.db	#0xC3, #0xC3, #0x99, #0x99, #0x9F, #0x9F, #0x83, #0x83
	.db	#0x99, #0x99, #0x99, #0x99, #0xC3, #0xC3, #0xFF, #0xFF
	.db	#0x81, #0x81, #0xF9, #0xF9, #0xF3, #0xF3
	.db	#-8, #0xe7
	.db	#32
	.db	#0xFF, #0xFF, #0xC3, #0xC3, #0x99, #0x99, #0x99, #0x99
	.db	#0xC3, #0xC3, #0x99, #0x99, #0x99, #0x99, #0xC3, #0xC3
	.db	#0xFF, #0xFF, #0xC3, #0xC3, #0x99, #0x99, #0x99, #0x99
	.db	#0xC1, #0xC1, #0xF9, #0xF9, #0x99, #0x99, #0xC3, #0xC3
	.db	#-18, #0xff
	.db	#36
	.db	#0xBB, #0xBB, #0x11, #0x11, #0x01, #0x01, #0x83, #0x83
	.db	#0xC7, #0xC7, #0xEF, #0xEF, #0xFF, #0xFF, #0xFF, #0xFF
	.db	#0xC1, #0xC1, #0x9C, #0x9C, #0x9F, #0x9F, #0xC1, #0xC1
	.db	#0xFC, #0xFC, #0x9C, #0x9C, #0xC1, #0xC1, #0xFF, #0xFF
	.db	#0xC1, #0xC1, #0x9C, #0x9C
	.db	#-6, #0x9f
	.db	#8
	.db	#0x9C, #0x9C, #0xC1, #0xC1, #0xFF, #0xFF, #0xC1, #0xC1
	.db	#-10, #0x9c
	.db	#12
	.db	#0xC1, #0xC1, #0xFF, #0xFF, #0x81, #0x81, #0x9C, #0x9C
	.db	#0x9C, #0x9C, #0x81, #0x81
	.db	#-6, #0x9c
	.db	#48
	.db	#0xFF, #0xFF, #0x80, #0x80, #0x9F, #0x9F, #0x9F, #0x9F
	.db	#0x83, #0x83, #0x9F, #0x9F, #0x9F, #0x9F, #0x80, #0x80
	.db	#0xFF, #0xFF, #0xFF, #0xFF, #0xE7, #0xE7, #0xE7, #0xE7
	.db	#0xFF, #0xFF, #0xE7, #0xE7, #0xE7, #0xE7, #0xFF, #0xFF
	.db	#0xC3, #0xC3, #0xBD, #0xBD, #0x6E, #0x6E, #0x5E, #0x5E
	.db	#0x7A, #0x7A, #0x76, #0x76, #0xBD, #0xBD, #0xC3, #0xC3
	.db	#0
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;bubbles.c:5: void deactiveBubble(UINT8 i){
;	---------------------------------
; Function deactiveBubble
; ---------------------------------
_deactiveBubble::
;bubbles.c:6: bubbles_active[i] = 0;
	ld	bc, #_bubbles_active+0
	ldhl	sp,	#2
	ld	l, (hl)
	ld	h, #0x00
	add	hl, bc
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
;bubbles.c:7: bubbles_x[i] = 0;
	ld	bc, #_bubbles_x+0
	ldhl	sp,	#2
	ld	l, (hl)
	ld	h, #0x00
	add	hl, bc
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
;bubbles.c:8: bubbles_y[i] = 0;
	ld	bc, #_bubbles_y+0
	ldhl	sp,	#2
	ld	l, (hl)
	ld	h, #0x00
	add	hl, bc
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
;bubbles.c:9: move_sprite(8 + i, 0, 0);
	ldhl	sp,	#2
	ld	a, (hl)
	add	a, #0x08
	ld	e, a
;c:/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM+0
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, bc
;c:/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	ld	a, #0x00
	ld	(hl+), a
	ld	(hl), #0x00
;bubbles.c:12: if(player.used_bubbles != 0){
	ld	bc, #_player+8
	ld	a, (bc)
	or	a, a
	ret	Z
;bubbles.c:13: player.used_bubbles-=1U;
	dec	a
	ld	(bc), a
;bubbles.c:16: }
	ret
_player_sprites:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x1f	; 31
	.db #0x24	; 36
	.db #0x3b	; 59
	.db #0x28	; 40
	.db #0x37	; 55	'7'
	.db #0x48	; 72	'H'
	.db #0x77	; 119	'w'
	.db #0x51	; 81	'Q'
	.db #0x6f	; 111	'o'
	.db #0x51	; 81	'Q'
	.db #0x6f	; 111	'o'
	.db #0x91	; 145
	.db #0xef	; 239
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0xb0	; 176
	.db #0xff	; 255
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x70	; 112	'p'
	.db #0x7f	; 127
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x03	; 3
	.db #0xff	; 255
	.db #0x07	; 7
	.db #0xff	; 255
	.db #0x1f	; 31
	.db #0xff	; 255
	.db #0x3f	; 63
	.db #0xff	; 255
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x7c	; 124
	.db #0xfc	; 252
	.db #0x1b	; 27
	.db #0xf8	; 248
	.db #0x97	; 151
	.db #0xf8	; 248
	.db #0x97	; 151
	.db #0xb0	; 176
	.db #0xff	; 255
	.db #0xb0	; 176
	.db #0xff	; 255
	.db #0x98	; 152
	.db #0xff	; 255
	.db #0x99	; 153
	.db #0xff	; 255
	.db #0x59	; 89	'Y'
	.db #0x7f	; 127
	.db #0x4c	; 76	'L'
	.db #0x7f	; 127
	.db #0x46	; 70	'F'
	.db #0x7f	; 127
	.db #0x23	; 35
	.db #0x3f	; 63
	.db #0x21	; 33
	.db #0x3f	; 63
	.db #0x10	; 16
	.db #0x1f	; 31
	.db #0x08	; 8
	.db #0x0f	; 15
	.db #0x04	; 4
	.db #0x07	; 7
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x78	; 120	'x'
	.db #0xf7	; 247
	.db #0x7f	; 127
	.db #0xf8	; 248
	.db #0xff	; 255
	.db #0x9c	; 156
	.db #0xff	; 255
	.db #0x0e	; 14
	.db #0xff	; 255
	.db #0x07	; 7
	.db #0xff	; 255
	.db #0x8f	; 143
	.db #0x7f	; 127
	.db #0xdf	; 223
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0x1f	; 31
	.db #0xfc	; 252
	.db #0x0f	; 15
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x70	; 112	'p'
	.db #0x7f	; 127
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x0e	; 14
	.db #0xfe	; 254
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xc0	; 192
	.db #0xff	; 255
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf7	; 247
	.db #0xff	; 255
	.db #0xf3	; 243
	.db #0x73	; 115	's'
	.db #0xff	; 255
	.db #0xfa	; 250
	.db #0xaf	; 175
	.db #0xfa	; 250
	.db #0x8f	; 143
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x40	; 64
	.db #0xc0	; 192
	.db #0xa0	; 160
	.db #0x60	; 96
	.db #0x50	; 80	'P'
	.db #0xb0	; 176
	.db #0x28	; 40
	.db #0xd8	; 216
	.db #0x14	; 20
	.db #0xec	; 236
	.db #0x94	; 148
	.db #0xec	; 236
	.db #0x8a	; 138
	.db #0xf6	; 246
	.db #0xca	; 202
	.db #0xf6	; 246
	.db #0xc6	; 198
	.db #0xfa	; 250
	.db #0x85	; 133
	.db #0xfb	; 251
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xfb	; 251
	.db #0x8d	; 141
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x41	; 65	'A'
	.db #0xff	; 255
	.db #0x32	; 50	'2'
	.db #0xff	; 255
	.db #0x0c	; 12
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x9c	; 156
	.db #0xff	; 255
	.db #0x08	; 8
	.db #0xff	; 255
	.db #0x08	; 8
	.db #0xff	; 255
	.db #0x08	; 8
	.db #0xff	; 255
	.db #0x10	; 16
	.db #0xff	; 255
	.db #0x63	; 99	'c'
	.db #0x9e	; 158
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x0e	; 14
	.db #0xfe	; 254
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x05	; 5
	.db #0xfb	; 251
	.db #0x85	; 133
	.db #0xfb	; 251
	.db #0xc6	; 198
	.db #0x7a	; 122	'z'
	.db #0xca	; 202
	.db #0x76	; 118	'v'
	.db #0x8a	; 138
	.db #0xf6	; 246
	.db #0xd4	; 212
	.db #0x6c	; 108	'l'
	.db #0xc4	; 196
	.db #0x7c	; 124
	.db #0xc8	; 200
	.db #0x78	; 120	'x'
	.db #0x90	; 144
	.db #0xf0	; 240
	.db #0x20	; 32
	.db #0xe0	; 224
	.db #0x40	; 64
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x0f	; 15
	.db #0x14	; 20
	.db #0x1b	; 27
	.db #0x18	; 24
	.db #0x17	; 23
	.db #0x28	; 40
	.db #0x37	; 55	'7'
	.db #0x31	; 49	'1'
	.db #0x2f	; 47
	.db #0x31	; 49	'1'
	.db #0x2f	; 47
	.db #0x51	; 81	'Q'
	.db #0x6f	; 111	'o'
	.db #0x41	; 65	'A'
	.db #0x7f	; 127
	.db #0x41	; 65	'A'
	.db #0x7f	; 127
	.db #0x70	; 112	'p'
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x70	; 112	'p'
	.db #0x7f	; 127
	.db #0x83	; 131
	.db #0xff	; 255
	.db #0x07	; 7
	.db #0xff	; 255
	.db #0x1f	; 31
	.db #0xff	; 255
	.db #0x3f	; 63
	.db #0xff	; 255
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x7c	; 124
	.db #0xfc	; 252
	.db #0x1b	; 27
	.db #0xf8	; 248
	.db #0x97	; 151
	.db #0xf8	; 248
	.db #0x97	; 151
	.db #0x70	; 112	'p'
	.db #0x7f	; 127
	.db #0x70	; 112	'p'
	.db #0x7f	; 127
	.db #0x58	; 88	'X'
	.db #0x7f	; 127
	.db #0x59	; 89	'Y'
	.db #0x7f	; 127
	.db #0x19	; 25
	.db #0x3f	; 63
	.db #0x2c	; 44
	.db #0x3f	; 63
	.db #0x26	; 38
	.db #0x3f	; 63
	.db #0x13	; 19
	.db #0x1f	; 31
	.db #0x11	; 17
	.db #0x1f	; 31
	.db #0x08	; 8
	.db #0x0f	; 15
	.db #0x04	; 4
	.db #0x07	; 7
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x78	; 120	'x'
	.db #0xf7	; 247
	.db #0x7f	; 127
	.db #0xf8	; 248
	.db #0xff	; 255
	.db #0x9c	; 156
	.db #0xff	; 255
	.db #0x0e	; 14
	.db #0xff	; 255
	.db #0x07	; 7
	.db #0xff	; 255
	.db #0x8f	; 143
	.db #0x7f	; 127
	.db #0xdf	; 223
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0x1f	; 31
	.db #0xfc	; 252
	.db #0x0f	; 15
	.db #0xfc	; 252
	.db #0x83	; 131
	.db #0xff	; 255
	.db #0x70	; 112	'p'
	.db #0x7f	; 127
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x0f	; 15
	.db #0xff	; 255
	.db #0xc1	; 193
	.db #0xff	; 255
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf7	; 247
	.db #0xff	; 255
	.db #0xf3	; 243
	.db #0x73	; 115	's'
	.db #0xff	; 255
	.db #0xfa	; 250
	.db #0xaf	; 175
	.db #0xfa	; 250
	.db #0x8f	; 143
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xc0	; 192
	.db #0x40	; 64
	.db #0x60	; 96
	.db #0xa0	; 160
	.db #0x30	; 48	'0'
	.db #0xd0	; 208
	.db #0x18	; 24
	.db #0xe8	; 232
	.db #0x98	; 152
	.db #0xe8	; 232
	.db #0x8c	; 140
	.db #0xf4	; 244
	.db #0xcc	; 204
	.db #0xf4	; 244
	.db #0xc4	; 196
	.db #0xfc	; 252
	.db #0x86	; 134
	.db #0xfa	; 250
	.db #0x02	; 2
	.db #0xfe	; 254
	.db #0x02	; 2
	.db #0xfe	; 254
	.db #0x02	; 2
	.db #0xfe	; 254
	.db #0xfb	; 251
	.db #0x8d	; 141
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x41	; 65	'A'
	.db #0xff	; 255
	.db #0x32	; 50	'2'
	.db #0xff	; 255
	.db #0x0c	; 12
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x9c	; 156
	.db #0xff	; 255
	.db #0x08	; 8
	.db #0xff	; 255
	.db #0x08	; 8
	.db #0xff	; 255
	.db #0x08	; 8
	.db #0xff	; 255
	.db #0x10	; 16
	.db #0xff	; 255
	.db #0x63	; 99	'c'
	.db #0x9f	; 159
	.db #0xff	; 255
	.db #0x0e	; 14
	.db #0xfe	; 254
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0xfe	; 254
	.db #0x02	; 2
	.db #0xfe	; 254
	.db #0x02	; 2
	.db #0xfe	; 254
	.db #0x86	; 134
	.db #0xfa	; 250
	.db #0xc4	; 196
	.db #0x7c	; 124
	.db #0xcc	; 204
	.db #0x74	; 116	't'
	.db #0x8c	; 140
	.db #0xf4	; 244
	.db #0xd8	; 216
	.db #0x68	; 104	'h'
	.db #0xc8	; 200
	.db #0x78	; 120	'x'
	.db #0xd0	; 208
	.db #0x70	; 112	'p'
	.db #0xa0	; 160
	.db #0xe0	; 224
	.db #0x40	; 64
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x1f	; 31
	.db #0x24	; 36
	.db #0x3b	; 59
	.db #0x28	; 40
	.db #0x37	; 55	'7'
	.db #0x48	; 72	'H'
	.db #0x77	; 119	'w'
	.db #0x51	; 81	'Q'
	.db #0x6f	; 111	'o'
	.db #0x51	; 81	'Q'
	.db #0x6f	; 111	'o'
	.db #0x91	; 145
	.db #0xef	; 239
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0xb0	; 176
	.db #0xff	; 255
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x70	; 112	'p'
	.db #0x7f	; 127
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x03	; 3
	.db #0xff	; 255
	.db #0x07	; 7
	.db #0xff	; 255
	.db #0x1f	; 31
	.db #0xff	; 255
	.db #0x3f	; 63
	.db #0xff	; 255
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x7c	; 124
	.db #0xfc	; 252
	.db #0x1b	; 27
	.db #0xf8	; 248
	.db #0x97	; 151
	.db #0xf8	; 248
	.db #0x97	; 151
	.db #0xb0	; 176
	.db #0xff	; 255
	.db #0xb0	; 176
	.db #0xff	; 255
	.db #0x98	; 152
	.db #0xff	; 255
	.db #0x99	; 153
	.db #0xff	; 255
	.db #0x59	; 89	'Y'
	.db #0x7f	; 127
	.db #0x4c	; 76	'L'
	.db #0x7f	; 127
	.db #0x46	; 70	'F'
	.db #0x7f	; 127
	.db #0x23	; 35
	.db #0x3f	; 63
	.db #0x21	; 33
	.db #0x3f	; 63
	.db #0x10	; 16
	.db #0x1f	; 31
	.db #0x08	; 8
	.db #0x0f	; 15
	.db #0x04	; 4
	.db #0x07	; 7
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0xf0	; 240
	.db #0x7f	; 127
	.db #0xf8	; 248
	.db #0xff	; 255
	.db #0x9c	; 156
	.db #0xff	; 255
	.db #0x0e	; 14
	.db #0xff	; 255
	.db #0x07	; 7
	.db #0xff	; 255
	.db #0x8f	; 143
	.db #0x7f	; 127
	.db #0xdf	; 223
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0x1f	; 31
	.db #0xfc	; 252
	.db #0x0f	; 15
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x70	; 112	'p'
	.db #0x7f	; 127
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x0e	; 14
	.db #0xfe	; 254
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xc0	; 192
	.db #0xff	; 255
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf7	; 247
	.db #0xff	; 255
	.db #0xf3	; 243
	.db #0x73	; 115	's'
	.db #0xff	; 255
	.db #0xfa	; 250
	.db #0xaf	; 175
	.db #0xfa	; 250
	.db #0x8f	; 143
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x40	; 64
	.db #0xc0	; 192
	.db #0xa0	; 160
	.db #0x60	; 96
	.db #0x50	; 80	'P'
	.db #0xb0	; 176
	.db #0x28	; 40
	.db #0xd8	; 216
	.db #0x14	; 20
	.db #0xec	; 236
	.db #0x94	; 148
	.db #0xec	; 236
	.db #0x82	; 130
	.db #0xfe	; 254
	.db #0xc2	; 194
	.db #0xfe	; 254
	.db #0xc2	; 194
	.db #0xfe	; 254
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x0d	; 13
	.db #0xff	; 255
	.db #0x0d	; 13
	.db #0xff	; 255
	.db #0x02	; 2
	.db #0xff	; 255
	.db #0x04	; 4
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x9c	; 156
	.db #0xff	; 255
	.db #0x08	; 8
	.db #0xff	; 255
	.db #0x08	; 8
	.db #0xff	; 255
	.db #0x08	; 8
	.db #0xff	; 255
	.db #0x10	; 16
	.db #0xff	; 255
	.db #0x63	; 99	'c'
	.db #0x9e	; 158
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x0e	; 14
	.db #0xfe	; 254
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x85	; 133
	.db #0xfb	; 251
	.db #0xc6	; 198
	.db #0x7a	; 122	'z'
	.db #0xca	; 202
	.db #0x76	; 118	'v'
	.db #0x8a	; 138
	.db #0xf6	; 246
	.db #0xd4	; 212
	.db #0x6c	; 108	'l'
	.db #0xc4	; 196
	.db #0x7c	; 124
	.db #0xc8	; 200
	.db #0x78	; 120	'x'
	.db #0x90	; 144
	.db #0xf0	; 240
	.db #0x20	; 32
	.db #0xe0	; 224
	.db #0x40	; 64
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x84	; 132
	.db #0x01	; 1
	.db #0xc1	; 193
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xbe	; 190
	.db #0xfe	; 254
	.db #0x8d	; 141
	.db #0xfc	; 252
	.db #0xcb	; 203
	.db #0x7c	; 124
	.db #0x4b	; 75	'K'
	.db #0x3c	; 60
	.db #0x3b	; 59
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x19	; 25
	.db #0x19	; 25
	.db #0x0d	; 13
	.db #0x4d	; 77	'M'
	.db #0x0c	; 12
	.db #0xcc	; 204
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x31	; 49	'1'
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x3c	; 60
	.db #0x1f	; 31
	.db #0x1e	; 30
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x9f	; 159
	.db #0xff	; 255
	.db #0x0f	; 15
	.db #0xff	; 255
	.db #0x8f	; 143
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0x7f	; 127
	.db #0x7c	; 124
	.db #0x0f	; 15
	.db #0x0c	; 12
	.db #0x07	; 7
	.db #0x06	; 6
	.db #0x03	; 3
	.db #0x13	; 19
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x7b	; 123
	.db #0xff	; 255
	.db #0x39	; 57	'9'
	.db #0x7d	; 125
	.db #0xd7	; 215
	.db #0x7d	; 125
	.db #0xc7	; 199
	.db #0x39	; 57	'9'
	.db #0xc7	; 199
	.db #0x39	; 57	'9'
	.db #0xc6	; 198
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x84	; 132
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x81	; 129
	.db #0xc0	; 192
	.db #0xc3	; 195
	.db #0xc0	; 192
	.db #0xc6	; 198
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x80	; 128
	.db #0x87	; 135
	.db #0xff	; 255
	.db #0x18	; 24
	.db #0xff	; 255
	.db #0x38	; 56	'8'
	.db #0xff	; 255
	.db #0x39	; 57	'9'
	.db #0xff	; 255
	.db #0x83	; 131
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xef	; 239
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x39	; 57	'9'
	.db #0xff	; 255
	.db #0x38	; 56	'8'
	.db #0xff	; 255
	.db #0x38	; 56	'8'
	.db #0xef	; 239
	.db #0x28	; 40
	.db #0xef	; 239
	.db #0x6c	; 108	'l'
	.db #0xc7	; 199
	.db #0xc7	; 199
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf8	; 248
	.db #0xd8	; 216
	.db #0xf8	; 248
	.db #0x88	; 136
	.db #0xf8	; 248
	.db #0x98	; 152
	.db #0xf0	; 240
	.db #0xf2	; 242
	.db #0xf0	; 240
	.db #0xf3	; 243
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x40	; 64
	.db #0xc0	; 192
	.db #0x48	; 72	'H'
	.db #0x80	; 128
	.db #0x8c	; 140
	.db #0x80	; 128
	.db #0xc6	; 198
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x7c	; 124
	.db #0xfc	; 252
	.db #0x1b	; 27
	.db #0xf8	; 248
	.db #0x97	; 151
	.db #0xf8	; 248
	.db #0x97	; 151
	.db #0x78	; 120	'x'
	.db #0x77	; 119	'w'
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x37	; 55	'7'
	.db #0x34	; 52	'4'
	.db #0x37	; 55	'7'
	.db #0x34	; 52	'4'
	.db #0x37	; 55	'7'
	.db #0x34	; 52	'4'
	.db #0x17	; 23
	.db #0x16	; 22
	.db #0x1b	; 27
	.db #0x1b	; 27
	.db #0x1b	; 27
	.db #0x1b	; 27
	.db #0x09	; 9
	.db #0x09	; 9
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7c	; 124
	.db #0x7b	; 123
	.db #0xbd	; 189
	.db #0xbe	; 190
	.db #0xf9	; 249
	.db #0xfe	; 254
	.db #0xf9	; 249
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3e	; 62
	.db #0xff	; 255
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0xf8	; 248
	.db #0x1f	; 31
	.db #0x18	; 24
	.db #0x0f	; 15
	.db #0x0c	; 12
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf7	; 247
	.db #0xff	; 255
	.db #0x73	; 115	's'
	.db #0x73	; 115	's'
	.db #0xaf	; 175
	.db #0xfa	; 250
	.db #0x8e	; 142
	.db #0xfa	; 250
	.db #0x8e	; 142
	.db #0xf9	; 249
	.db #0x8f	; 143
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf9	; 249
	.db #0x07	; 7
	.db #0xfd	; 253
	.db #0x73	; 115	's'
	.db #0xfc	; 252
	.db #0x73	; 115	's'
	.db #0xfc	; 252
	.db #0x77	; 119	'w'
	.db #0xff	; 255
	.db #0x77	; 119	'w'
	.db #0xff	; 255
	.db #0x8f	; 143
	.db #0xff	; 255
	.db #0xdf	; 223
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x73	; 115	's'
	.db #0xff	; 255
	.db #0x71	; 113	'q'
	.db #0xff	; 255
	.db #0x70	; 112	'p'
	.db #0xdf	; 223
	.db #0x50	; 80	'P'
	.db #0xdf	; 223
	.db #0xd9	; 217
	.db #0x8f	; 143
	.db #0x8f	; 143
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xb0	; 176
	.db #0xb0	; 176
	.db #0xf8	; 248
	.db #0xc8	; 200
	.db #0xf8	; 248
	.db #0x88	; 136
	.db #0xf8	; 248
	.db #0x88	; 136
	.db #0xf0	; 240
	.db #0x90	; 144
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_water:
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x86	; 134
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xcf	; 207
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0xe1	; 225
	.db #0x00	; 0
	.db #0x37	; 55	'7'
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0xe1	; 225
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0xe1	; 225
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xcc	; 204
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0xc3	; 195
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf3	; 243
	.db #0x00	; 0
	.db #0x87	; 135
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x87	; 135
	.db #0x00	; 0
	.db #0x0d	; 13
	.db #0x00	; 0
	.db #0xe1	; 225
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0xc1	; 193
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x73	; 115	's'
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xc3	; 195
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x61	; 97	'a'
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xc3	; 195
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x81	; 129
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x87	; 135
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0xdc	; 220
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x81	; 129
	.db #0x00	; 0
	.db #0x87	; 135
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xcf	; 207
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0xe1	; 225
	.db #0x00	; 0
	.db #0x37	; 55	'7'
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0xe1	; 225
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x86	; 134
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xc3	; 195
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf3	; 243
	.db #0x00	; 0
	.db #0x87	; 135
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x87	; 135
	.db #0x00	; 0
	.db #0x0d	; 13
	.db #0x00	; 0
	.db #0xe1	; 225
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0xe1	; 225
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xcc	; 204
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x61	; 97	'a'
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xc3	; 195
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x81	; 129
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x87	; 135
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0xc1	; 193
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x73	; 115	's'
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xc3	; 195
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0xdc	; 220
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x81	; 129
	.db #0x00	; 0
	.db #0x87	; 135
_background_tile_map_size:
	.dw #0x0168
_background_tile_map_width:
	.dw #0x0014
_background_tile_map_height:
	.dw #0x0012
_background_tile_data_size:
	.dw #0x05c0
_background_tile_count:
	.dw #0x005c
_background_map_data:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x09	; 9
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0x0d	; 13
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0x11	; 17
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x09	; 9
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x12	; 18
	.db #0x13	; 19
	.db #0x14	; 20
	.db #0x15	; 21
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x16	; 22
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x17	; 23
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x19	; 25
	.db #0x1a	; 26
	.db #0x1b	; 27
	.db #0x1c	; 28
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x09	; 9
	.db #0x0a	; 10
	.db #0x1d	; 29
	.db #0x1e	; 30
	.db #0x1f	; 31
	.db #0x20	; 32
	.db #0x21	; 33
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x22	; 34
	.db #0x23	; 35
	.db #0x24	; 36
	.db #0x25	; 37
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x26	; 38
	.db #0x27	; 39
	.db #0x28	; 40
	.db #0x20	; 32
	.db #0x29	; 41
	.db #0x2a	; 42
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x2b	; 43
	.db #0x2c	; 44
	.db #0x2d	; 45
	.db #0x2e	; 46
	.db #0x2f	; 47
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x31	; 49	'1'
	.db #0x32	; 50	'2'
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x33	; 51	'3'
	.db #0x00	; 0
	.db #0x34	; 52	'4'
	.db #0x35	; 53	'5'
	.db #0x36	; 54	'6'
	.db #0x37	; 55	'7'
	.db #0x38	; 56	'8'
	.db #0x39	; 57	'9'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3a	; 58
	.db #0x3b	; 59
	.db #0x3c	; 60
	.db #0x3d	; 61
	.db #0x3e	; 62
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x41	; 65	'A'
	.db #0x42	; 66	'B'
	.db #0x43	; 67	'C'
	.db #0x00	; 0
	.db #0x44	; 68	'D'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x45	; 69	'E'
	.db #0x46	; 70	'F'
	.db #0x47	; 71	'G'
	.db #0x48	; 72	'H'
	.db #0x47	; 71	'G'
	.db #0x49	; 73	'I'
	.db #0x4a	; 74	'J'
	.db #0x00	; 0
	.db #0x4b	; 75	'K'
	.db #0x4c	; 76	'L'
	.db #0x4d	; 77	'M'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x4e	; 78	'N'
	.db #0x4f	; 79	'O'
	.db #0x50	; 80	'P'
	.db #0x51	; 81	'Q'
	.db #0x50	; 80	'P'
	.db #0x50	; 80	'P'
	.db #0x52	; 82	'R'
	.db #0x53	; 83	'S'
	.db #0x54	; 84	'T'
	.db #0x55	; 85	'U'
	.db #0x56	; 86	'V'
	.db #0x57	; 87	'W'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x58	; 88	'X'
	.db #0x59	; 89	'Y'
	.db #0x58	; 88	'X'
	.db #0x59	; 89	'Y'
	.db #0x58	; 88	'X'
	.db #0x59	; 89	'Y'
	.db #0x58	; 88	'X'
	.db #0x59	; 89	'Y'
	.db #0x58	; 88	'X'
	.db #0x59	; 89	'Y'
	.db #0x58	; 88	'X'
	.db #0x59	; 89	'Y'
	.db #0x58	; 88	'X'
	.db #0x59	; 89	'Y'
	.db #0x58	; 88	'X'
	.db #0x59	; 89	'Y'
	.db #0x58	; 88	'X'
	.db #0x59	; 89	'Y'
	.db #0x58	; 88	'X'
	.db #0x59	; 89	'Y'
	.db #0x5a	; 90	'Z'
	.db #0x5b	; 91
	.db #0x5a	; 90	'Z'
	.db #0x5b	; 91
	.db #0x5a	; 90	'Z'
	.db #0x5b	; 91
	.db #0x5a	; 90	'Z'
	.db #0x5b	; 91
	.db #0x5a	; 90	'Z'
	.db #0x5b	; 91
	.db #0x5a	; 90	'Z'
	.db #0x5b	; 91
	.db #0x5a	; 90	'Z'
	.db #0x5b	; 91
	.db #0x5a	; 90	'Z'
	.db #0x5b	; 91
	.db #0x5a	; 90	'Z'
	.db #0x5b	; 91
	.db #0x5a	; 90	'Z'
	.db #0x5b	; 91
	.db #0x58	; 88	'X'
	.db #0x59	; 89	'Y'
	.db #0x58	; 88	'X'
	.db #0x59	; 89	'Y'
	.db #0x58	; 88	'X'
	.db #0x59	; 89	'Y'
	.db #0x58	; 88	'X'
	.db #0x59	; 89	'Y'
	.db #0x58	; 88	'X'
	.db #0x59	; 89	'Y'
	.db #0x58	; 88	'X'
	.db #0x59	; 89	'Y'
	.db #0x58	; 88	'X'
	.db #0x59	; 89	'Y'
	.db #0x58	; 88	'X'
	.db #0x59	; 89	'Y'
	.db #0x58	; 88	'X'
	.db #0x59	; 89	'Y'
	.db #0x58	; 88	'X'
	.db #0x59	; 89	'Y'
_background_tile_data:
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x01	; 1
	.db #0xfc	; 252
	.db #0x02	; 2
	.db #0xf8	; 248
	.db #0x04	; 4
	.db #0xf8	; 248
	.db #0x04	; 4
	.db #0xf0	; 240
	.db #0x08	; 8
	.db #0xf0	; 240
	.db #0x08	; 8
	.db #0xc0	; 192
	.db #0x3c	; 60
	.db #0x07	; 7
	.db #0xf8	; 248
	.db #0x01	; 1
	.db #0x06	; 6
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0xf0	; 240
	.db #0x03	; 3
	.db #0x0c	; 12
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x80	; 128
	.db #0x3f	; 63
	.db #0xc0	; 192
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x20	; 32
	.db #0xa0	; 160
	.db #0x40	; 64
	.db #0x60	; 96
	.db #0x80	; 128
	.db #0x60	; 96
	.db #0x80	; 128
	.db #0x71	; 113	'q'
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x80	; 128
	.db #0xbf	; 191
	.db #0x40	; 64
	.db #0xc0	; 192
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x82	; 130
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x38	; 56	'8'
	.db #0x40	; 64
	.db #0xbf	; 191
	.db #0x40	; 64
	.db #0x7f	; 127
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x3f	; 63
	.db #0x40	; 64
	.db #0x0f	; 15
	.db #0x30	; 48	'0'
	.db #0x01	; 1
	.db #0x0e	; 14
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0xb0	; 176
	.db #0x01	; 1
	.db #0xf9	; 249
	.db #0x06	; 6
	.db #0xe7	; 231
	.db #0x18	; 24
	.db #0x1f	; 31
	.db #0xe0	; 224
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0xf8	; 248
	.db #0x04	; 4
	.db #0xf0	; 240
	.db #0x08	; 8
	.db #0xe0	; 224
	.db #0x10	; 16
	.db #0xe0	; 224
	.db #0x10	; 16
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x06	; 6
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x01	; 1
	.db #0xfe	; 254
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x03	; 3
	.db #0xff	; 255
	.db #0x03	; 3
	.db #0x86	; 134
	.db #0x7f	; 127
	.db #0x3c	; 60
	.db #0xc7	; 199
	.db #0xcc	; 204
	.db #0x0f	; 15
	.db #0xff	; 255
	.db #0x3c	; 60
	.db #0xff	; 255
	.db #0xc3	; 195
	.db #0xf9	; 249
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x7c	; 124
	.db #0x80	; 128
	.db #0x3f	; 63
	.db #0xc0	; 192
	.db #0x1f	; 31
	.db #0xe0	; 224
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x40	; 64
	.db #0xff	; 255
	.db #0x40	; 64
	.db #0xff	; 255
	.db #0x40	; 64
	.db #0xff	; 255
	.db #0x20	; 32
	.db #0xff	; 255
	.db #0x20	; 32
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x3f	; 63
	.db #0xbf	; 191
	.db #0x40	; 64
	.db #0x20	; 32
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0xc1	; 193
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0xf9	; 249
	.db #0x06	; 6
	.db #0x1a	; 26
	.db #0xe4	; 228
	.db #0xc6	; 198
	.db #0x38	; 56	'8'
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x88	; 136
	.db #0x0f	; 15
	.db #0x08	; 8
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x1f	; 31
	.db #0x10	; 16
	.db #0x1f	; 31
	.db #0x20	; 32
	.db #0x3f	; 63
	.db #0x20	; 32
	.db #0x3f	; 63
	.db #0x20	; 32
	.db #0x3f	; 63
	.db #0x40	; 64
	.db #0x7f	; 127
	.db #0x0f	; 15
	.db #0xf0	; 240
	.db #0x0f	; 15
	.db #0xf0	; 240
	.db #0x0f	; 15
	.db #0xf0	; 240
	.db #0x0f	; 15
	.db #0xf0	; 240
	.db #0x0f	; 15
	.db #0xf0	; 240
	.db #0x0f	; 15
	.db #0xf0	; 240
	.db #0x0f	; 15
	.db #0xf0	; 240
	.db #0x0f	; 15
	.db #0xf0	; 240
	.db #0xff	; 255
	.db #0x20	; 32
	.db #0xff	; 255
	.db #0x20	; 32
	.db #0xff	; 255
	.db #0x10	; 16
	.db #0xff	; 255
	.db #0x10	; 16
	.db #0xff	; 255
	.db #0x08	; 8
	.db #0xff	; 255
	.db #0x08	; 8
	.db #0xff	; 255
	.db #0x04	; 4
	.db #0xff	; 255
	.db #0x04	; 4
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xfb	; 251
	.db #0x00	; 0
	.db #0xf3	; 243
	.db #0x00	; 0
	.db #0xe7	; 231
	.db #0x00	; 0
	.db #0x84	; 132
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x9f	; 159
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x1e	; 30
	.db #0x1e	; 30
	.db #0x7f	; 127
	.db #0x61	; 97	'a'
	.db #0xfc	; 252
	.db #0x80	; 128
	.db #0xfc	; 252
	.db #0x80	; 128
	.db #0x40	; 64
	.db #0x7f	; 127
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xc0	; 192
	.db #0x7f	; 127
	.db #0x60	; 96
	.db #0x3f	; 63
	.db #0xff	; 255
	.db #0x04	; 4
	.db #0xff	; 255
	.db #0x02	; 2
	.db #0xff	; 255
	.db #0x02	; 2
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xf9	; 249
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0xdf	; 223
	.db #0x00	; 0
	.db #0xbf	; 191
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x06	; 6
	.db #0xc3	; 195
	.db #0x00	; 0
	.db #0xc3	; 195
	.db #0x00	; 0
	.db #0xf1	; 241
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0xc2	; 194
	.db #0x00	; 0
	.db #0xf3	; 243
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x81	; 129
	.db #0x00	; 0
	.db #0x81	; 129
	.db #0x00	; 0
	.db #0xc1	; 193
	.db #0x00	; 0
	.db #0xc3	; 195
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf7	; 247
	.db #0x00	; 0
	.db #0xf7	; 247
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0xe1	; 225
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0xdf	; 223
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x04	; 4
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x09	; 9
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0xfc	; 252
	.db #0x80	; 128
	.db #0x3e	; 62
	.db #0xc0	; 192
	.db #0x1f	; 31
	.db #0xe0	; 224
	.db #0x0f	; 15
	.db #0xf0	; 240
	.db #0x07	; 7
	.db #0xf8	; 248
	.db #0x07	; 7
	.db #0xf8	; 248
	.db #0x07	; 7
	.db #0xf8	; 248
	.db #0x07	; 7
	.db #0x78	; 120	'x'
	.db #0x60	; 96
	.db #0x3f	; 63
	.db #0x60	; 96
	.db #0x3f	; 63
	.db #0xf0	; 240
	.db #0x1f	; 31
	.db #0xf0	; 240
	.db #0x1f	; 31
	.db #0xf0	; 240
	.db #0x1f	; 31
	.db #0xf8	; 248
	.db #0x0b	; 11
	.db #0xf8	; 248
	.db #0x09	; 9
	.db #0xf8	; 248
	.db #0x08	; 8
	.db #0xff	; 255
	.db #0x40	; 64
	.db #0xff	; 255
	.db #0x40	; 64
	.db #0xff	; 255
	.db #0x40	; 64
	.db #0xff	; 255
	.db #0x20	; 32
	.db #0xff	; 255
	.db #0x20	; 32
	.db #0xff	; 255
	.db #0x10	; 16
	.db #0xff	; 255
	.db #0x10	; 16
	.db #0xff	; 255
	.db #0x10	; 16
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x0f	; 15
	.db #0xff	; 255
	.db #0x11	; 17
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x07	; 7
	.db #0xff	; 255
	.db #0x07	; 7
	.db #0xff	; 255
	.db #0x0c	; 12
	.db #0xff	; 255
	.db #0x18	; 24
	.db #0xff	; 255
	.db #0xb1	; 177
	.db #0xff	; 255
	.db #0xf3	; 243
	.db #0xff	; 255
	.db #0xf6	; 246
	.db #0xff	; 255
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0xe0	; 224
	.db #0xfc	; 252
	.db #0xe0	; 224
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0xf9	; 249
	.db #0x00	; 0
	.db #0xf9	; 249
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x06	; 6
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x31	; 49	'1'
	.db #0x00	; 0
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0xe3	; 227
	.db #0x00	; 0
	.db #0xf1	; 241
	.db #0x00	; 0
	.db #0xf9	; 249
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x1c	; 28
	.db #0x10	; 16
	.db #0x1e	; 30
	.db #0x20	; 32
	.db #0x27	; 39
	.db #0x20	; 32
	.db #0x23	; 35
	.db #0x20	; 32
	.db #0x21	; 33
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x80	; 128
	.db #0xe0	; 224
	.db #0x07	; 7
	.db #0x38	; 56	'8'
	.db #0x07	; 7
	.db #0x18	; 24
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x07	; 7
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x38	; 56	'8'
	.db #0xfc	; 252
	.db #0x04	; 4
	.db #0xfc	; 252
	.db #0x04	; 4
	.db #0xfe	; 254
	.db #0x02	; 2
	.db #0xfe	; 254
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x70	; 112	'p'
	.db #0x0f	; 15
	.db #0x30	; 48	'0'
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x80	; 128
	.db #0xf0	; 240
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x08	; 8
	.db #0xff	; 255
	.db #0x08	; 8
	.db #0xff	; 255
	.db #0x04	; 4
	.db #0xff	; 255
	.db #0x04	; 4
	.db #0x07	; 7
	.db #0x04	; 4
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x1e	; 30
	.db #0xff	; 255
	.db #0x16	; 22
	.db #0xff	; 255
	.db #0x04	; 4
	.db #0xff	; 255
	.db #0x04	; 4
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x7c	; 124
	.db #0xff	; 255
	.db #0xee	; 238
	.db #0xff	; 255
	.db #0xc3	; 195
	.db #0xff	; 255
	.db #0x83	; 131
	.db #0xff	; 255
	.db #0x43	; 67	'C'
	.db #0xff	; 255
	.db #0x41	; 65	'A'
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xf9	; 249
	.db #0x00	; 0
	.db #0xf9	; 249
	.db #0x00	; 0
	.db #0xf3	; 243
	.db #0x00	; 0
	.db #0xf3	; 243
	.db #0x00	; 0
	.db #0xf3	; 243
	.db #0xc0	; 192
	.db #0xf3	; 243
	.db #0xc0	; 192
	.db #0xf3	; 243
	.db #0xe0	; 224
	.db #0xf3	; 243
	.db #0x60	; 96
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0xf0	; 240
	.db #0x80	; 128
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x07	; 7
	.db #0x18	; 24
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x8f	; 143
	.db #0xb0	; 176
	.db #0x8f	; 143
	.db #0x90	; 144
	.db #0xcf	; 207
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x40	; 64
	.db #0x7f	; 127
	.db #0x40	; 64
	.db #0x3f	; 63
	.db #0x20	; 32
	.db #0x3f	; 63
	.db #0x20	; 32
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x07	; 7
	.db #0xf1	; 241
	.db #0x60	; 96
	.db #0xf1	; 241
	.db #0x60	; 96
	.db #0xf1	; 241
	.db #0x70	; 112	'p'
	.db #0xf1	; 241
	.db #0x70	; 112	'p'
	.db #0xf1	; 241
	.db #0x70	; 112	'p'
	.db #0xf1	; 241
	.db #0x70	; 112	'p'
	.db #0xf1	; 241
	.db #0x70	; 112	'p'
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x07	; 7
	.db #0xf8	; 248
	.db #0x07	; 7
	.db #0xf8	; 248
	.db #0x07	; 7
	.db #0xf8	; 248
	.db #0x07	; 7
	.db #0xf8	; 248
	.db #0x07	; 7
	.db #0xf8	; 248
	.db #0x07	; 7
	.db #0xf8	; 248
	.db #0x07	; 7
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0xff	; 255
	.db #0x08	; 8
	.db #0xff	; 255
	.db #0x08	; 8
	.db #0xff	; 255
	.db #0x04	; 4
	.db #0xff	; 255
	.db #0x04	; 4
	.db #0xff	; 255
	.db #0x02	; 2
	.db #0xff	; 255
	.db #0x02	; 2
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0x1f	; 31
	.db #0x10	; 16
	.db #0xff	; 255
	.db #0x10	; 16
	.db #0xff	; 255
	.db #0x08	; 8
	.db #0xff	; 255
	.db #0x08	; 8
	.db #0xff	; 255
	.db #0x04	; 4
	.db #0xff	; 255
	.db #0x04	; 4
	.db #0xff	; 255
	.db #0x02	; 2
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x07	; 7
	.db #0xff	; 255
	.db #0x0e	; 14
	.db #0xff	; 255
	.db #0x18	; 24
	.db #0xff	; 255
	.db #0x30	; 48	'0'
	.db #0xff	; 255
	.db #0xe0	; 224
	.db #0xff	; 255
	.db #0x3e	; 62
	.db #0xff	; 255
	.db #0xf8	; 248
	.db #0xfe	; 254
	.db #0x80	; 128
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x60	; 96
	.db #0x1f	; 31
	.db #0x1e	; 30
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x60	; 96
	.db #0x1f	; 31
	.db #0x10	; 16
	.db #0x0f	; 15
	.db #0x08	; 8
	.db #0x07	; 7
	.db #0x04	; 4
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x86	; 134
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xcf	; 207
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0xe1	; 225
	.db #0x00	; 0
	.db #0x37	; 55	'7'
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0xf0	; 240
_hub_map:
	.db #0x67	; 103	'g'
	.db #0x67	; 103	'g'
	.db #0x67	; 103	'g'
	.db #0x66	; 102	'f'
	.db #0x68	; 104	'h'
	.db #0x69	; 105	'i'
	.db #0x6a	; 106	'j'
	.db #0x6b	; 107	'k'
	.db #0x6c	; 108	'l'
	.db #0x6d	; 109	'm'
	.db #0x5c	; 92
	.db #0x5c	; 92
	.db #0x5c	; 92
	.db #0x5c	; 92
	.db #0x5c	; 92
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x6e	; 110	'n'
	.db #0x6e	; 110	'n'
	.db #0x6e	; 110	'n'
_bubble_sprites:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x91	; 145
	.db #0xff	; 255
	.db #0xa1	; 161
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x85	; 133
	.db #0xfb	; 251
	.db #0x89	; 137
	.db #0xf7	; 247
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_enemies_sprites:
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x07	; 7
	.db #0x04	; 4
	.db #0x07	; 7
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x61	; 97	'a'
	.db #0x61	; 97	'a'
	.db #0x91	; 145
	.db #0xf1	; 241
	.db #0x90	; 144
	.db #0xf0	; 240
	.db #0x60	; 96
	.db #0x70	; 112	'p'
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x90	; 144
	.db #0xf0	; 240
	.db #0x8c	; 140
	.db #0xfc	; 252
	.db #0x90	; 144
	.db #0xf0	; 240
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x40	; 64
	.db #0xc0	; 192
	.db #0x40	; 64
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x12	; 18
	.db #0x1e	; 30
	.db #0x12	; 18
	.db #0x1e	; 30
	.db #0x0c	; 12
	.db #0x1c	; 28
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x12	; 18
	.db #0x1e	; 30
	.db #0x62	; 98	'b'
	.db #0x7e	; 126
	.db #0x12	; 18
	.db #0x1e	; 30
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x0f	; 15
	.db #0x09	; 9
	.db #0x1f	; 31
	.db #0x10	; 16
	.db #0x1f	; 31
	.db #0x18	; 24
	.db #0x3f	; 63
	.db #0x30	; 48	'0'
	.db #0x9f	; 159
	.db #0x9c	; 156
	.db #0xbf	; 191
	.db #0xb8	; 184
	.db #0xff	; 255
	.db #0xde	; 222
	.db #0xff	; 255
	.db #0x8a	; 138
	.db #0x7e	; 126
	.db #0x41	; 65	'A'
	.db #0x38	; 56	'8'
	.db #0x27	; 39
	.db #0x18	; 24
	.db #0x17	; 23
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x70	; 112	'p'
	.db #0x50	; 80	'P'
	.db #0x70	; 112	'p'
	.db #0x50	; 80	'P'
	.db #0xf0	; 240
	.db #0x90	; 144
	.db #0xfc	; 252
	.db #0x3c	; 60
	.db #0xca	; 202
	.db #0x7e	; 126
	.db #0x95	; 149
	.db #0xff	; 255
	.db #0x95	; 149
	.db #0xff	; 255
	.db #0xc2	; 194
	.db #0x7e	; 126
	.db #0xfc	; 252
	.db #0x3c	; 60
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x3c	; 60
	.db #0xfc	; 252
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x0f	; 15
	.db #0x0b	; 11
	.db #0x9f	; 159
	.db #0x99	; 153
	.db #0xff	; 255
	.db #0xf1	; 241
	.db #0xff	; 255
	.db #0xb1	; 177
	.db #0x7e	; 126
	.db #0x63	; 99	'c'
	.db #0x3e	; 62
	.db #0x33	; 51	'3'
	.db #0x3e	; 62
	.db #0x23	; 35
	.db #0x3e	; 62
	.db #0x32	; 50	'2'
	.db #0x3c	; 60
	.db #0x24	; 36
	.db #0x3c	; 60
	.db #0x34	; 52	'4'
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x4a	; 74	'J'
	.db #0x7e	; 126
	.db #0x95	; 149
	.db #0xff	; 255
	.db #0x95	; 149
	.db #0xff	; 255
	.db #0xc2	; 194
	.db #0x7e	; 126
	.db #0xfc	; 252
	.db #0x3c	; 60
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x38	; 56	'8'
	.db #0xf8	; 248
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x07	; 7
	.db #0x04	; 4
	.db #0x0f	; 15
	.db #0x0b	; 11
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xcf	; 207
	.db #0xff	; 255
	.db #0x87	; 135
	.db #0xff	; 255
	.db #0x87	; 135
	.db #0xff	; 255
	.db #0x43	; 67	'C'
	.db #0x7f	; 127
	.db #0x27	; 39
	.db #0x3e	; 62
	.db #0x7f	; 127
	.db #0x78	; 120	'x'
	.db #0xff	; 255
	.db #0xb1	; 177
	.db #0xff	; 255
	.db #0xb1	; 177
	.db #0xff	; 255
	.db #0x98	; 152
	.db #0x7f	; 127
	.db #0x5c	; 92
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xe0	; 224
	.db #0x20	; 32
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xca	; 202
	.db #0xfe	; 254
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x95	; 149
	.db #0xff	; 255
	.db #0x95	; 149
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0xc2	; 194
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x3f	; 63
	.db #0xd5	; 213
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0xe3	; 227
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xf0	; 240
	.db #0x10	; 16
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x07	; 7
	.db #0x04	; 4
	.db #0x0f	; 15
	.db #0x0b	; 11
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x27	; 39
	.db #0x3e	; 62
	.db #0x43	; 67	'C'
	.db #0x7e	; 126
	.db #0x87	; 135
	.db #0xfd	; 253
	.db #0x87	; 135
	.db #0xfd	; 253
	.db #0xcf	; 207
	.db #0xf8	; 248
	.db #0x7f	; 127
	.db #0x7c	; 124
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xe0	; 224
	.db #0x20	; 32
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xca	; 202
	.db #0xfe	; 254
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x95	; 149
	.db #0xff	; 255
	.db #0x95	; 149
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0xc2	; 194
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x3f	; 63
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf3	; 243
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xf0	; 240
	.db #0x10	; 16
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x07	; 7
	.db #0x04	; 4
	.db #0x0f	; 15
	.db #0x0c	; 12
	.db #0x3f	; 63
	.db #0x30	; 48	'0'
	.db #0x7f	; 127
	.db #0x46	; 70	'F'
	.db #0xfb	; 251
	.db #0x8f	; 143
	.db #0xf2	; 242
	.db #0x8f	; 143
	.db #0x70	; 112	'p'
	.db #0x4f	; 79	'O'
	.db #0x38	; 56	'8'
	.db #0x2f	; 47
	.db #0x3f	; 63
	.db #0x27	; 39
	.db #0x3f	; 63
	.db #0x27	; 39
	.db #0x7f	; 127
	.db #0x40	; 64
	.db #0x7f	; 127
	.db #0x43	; 67	'C'
	.db #0x7c	; 124
	.db #0x64	; 100	'd'
	.db #0x78	; 120	'x'
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xc0	; 192
	.db #0x40	; 64
	.db #0xe0	; 224
	.db #0x60	; 96
	.db #0xf8	; 248
	.db #0x18	; 24
	.db #0xfc	; 252
	.db #0xc4	; 196
	.db #0xbe	; 190
	.db #0xe2	; 226
	.db #0x9e	; 158
	.db #0xe2	; 226
	.db #0x1c	; 28
	.db #0xe4	; 228
	.db #0x38	; 56	'8'
	.db #0xe8	; 232
	.db #0xf8	; 248
	.db #0xc8	; 200
	.db #0xf8	; 248
	.db #0xc8	; 200
	.db #0xfc	; 252
	.db #0x04	; 4
	.db #0xfc	; 252
	.db #0x84	; 132
	.db #0x7c	; 124
	.db #0x4c	; 76	'L'
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x07	; 7
	.db #0x04	; 4
	.db #0x0f	; 15
	.db #0x0c	; 12
	.db #0x3f	; 63
	.db #0x30	; 48	'0'
	.db #0x7f	; 127
	.db #0x46	; 70	'F'
	.db #0xf9	; 249
	.db #0x8f	; 143
	.db #0xf2	; 242
	.db #0x8f	; 143
	.db #0x72	; 114	'r'
	.db #0x4f	; 79	'O'
	.db #0x38	; 56	'8'
	.db #0x2f	; 47
	.db #0x3f	; 63
	.db #0x27	; 39
	.db #0x3f	; 63
	.db #0x20	; 32
	.db #0x7f	; 127
	.db #0x40	; 64
	.db #0x7f	; 127
	.db #0x43	; 67	'C'
	.db #0x7c	; 124
	.db #0x64	; 100	'd'
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xc0	; 192
	.db #0x40	; 64
	.db #0xe0	; 224
	.db #0x60	; 96
	.db #0xf8	; 248
	.db #0x18	; 24
	.db #0xfc	; 252
	.db #0xc4	; 196
	.db #0x3e	; 62
	.db #0xe2	; 226
	.db #0x9e	; 158
	.db #0xe2	; 226
	.db #0x9c	; 156
	.db #0xe4	; 228
	.db #0x38	; 56	'8'
	.db #0xe8	; 232
	.db #0xf8	; 248
	.db #0xc8	; 200
	.db #0xf8	; 248
	.db #0x08	; 8
	.db #0xfc	; 252
	.db #0x04	; 4
	.db #0xfc	; 252
	.db #0x84	; 132
	.db #0x7c	; 124
	.db #0x4c	; 76	'L'
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x07	; 7
	.db #0x04	; 4
	.db #0x0f	; 15
	.db #0x0c	; 12
	.db #0x3f	; 63
	.db #0x30	; 48	'0'
	.db #0x7f	; 127
	.db #0x46	; 70	'F'
	.db #0xf9	; 249
	.db #0x8f	; 143
	.db #0xf2	; 242
	.db #0x8f	; 143
	.db #0x72	; 114	'r'
	.db #0x4f	; 79	'O'
	.db #0x38	; 56	'8'
	.db #0x2f	; 47
	.db #0x7f	; 127
	.db #0x67	; 103	'g'
	.db #0xff	; 255
	.db #0xf0	; 240
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xc0	; 192
	.db #0x40	; 64
	.db #0xe0	; 224
	.db #0x60	; 96
	.db #0xf8	; 248
	.db #0x18	; 24
	.db #0xfc	; 252
	.db #0xc4	; 196
	.db #0x3e	; 62
	.db #0xe2	; 226
	.db #0x9e	; 158
	.db #0xe2	; 226
	.db #0x9c	; 156
	.db #0xe4	; 228
	.db #0x38	; 56	'8'
	.db #0xe8	; 232
	.db #0xfc	; 252
	.db #0xcc	; 204
	.db #0xfe	; 254
	.db #0x1e	; 30
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xf8	; 248
	.db #0xf8	; 248
_game_over:
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x7c	; 124
	.db #0x20	; 32
	.db #0x60	; 96
	.db #0x22	; 34
	.db #0x6e	; 110	'n'
	.db #0x22	; 34
	.db #0x66	; 102	'f'
	.db #0x22	; 34
	.db #0x66	; 102	'f'
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x3c	; 60
	.db #0x3a	; 58
	.db #0x7e	; 126
	.db #0x22	; 34
	.db #0x66	; 102	'f'
	.db #0x22	; 34
	.db #0x66	; 102	'f'
	.db #0x02	; 2
	.db #0x7e	; 126
	.db #0x3a	; 58
	.db #0x7e	; 126
	.db #0x22	; 34
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x22	; 34
	.db #0x66	; 102	'f'
	.db #0x12	; 18
	.db #0x7e	; 126
	.db #0x2a	; 42
	.db #0x7e	; 126
	.db #0x22	; 34
	.db #0x66	; 102	'f'
	.db #0x22	; 34
	.db #0x66	; 102	'f'
	.db #0x22	; 34
	.db #0x66	; 102	'f'
	.db #0x22	; 34
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x7e	; 126
	.db #0x3e	; 62
	.db #0x7e	; 126
	.db #0x20	; 32
	.db #0x60	; 96
	.db #0x02	; 2
	.db #0x7e	; 126
	.db #0x3e	; 62
	.db #0x7e	; 126
	.db #0x20	; 32
	.db #0x60	; 96
	.db #0x02	; 2
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x3c	; 60
	.db #0x3a	; 58
	.db #0x7e	; 126
	.db #0x22	; 34
	.db #0x66	; 102	'f'
	.db #0x22	; 34
	.db #0x66	; 102	'f'
	.db #0x22	; 34
	.db #0x66	; 102	'f'
	.db #0x22	; 34
	.db #0x66	; 102	'f'
	.db #0x46	; 70	'F'
	.db #0x7e	; 126
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x22	; 34
	.db #0x66	; 102	'f'
	.db #0x22	; 34
	.db #0x66	; 102	'f'
	.db #0x22	; 34
	.db #0x66	; 102	'f'
	.db #0x22	; 34
	.db #0x66	; 102	'f'
	.db #0x22	; 34
	.db #0x66	; 102	'f'
	.db #0x22	; 34
	.db #0x66	; 102	'f'
	.db #0x14	; 20
	.db #0x3c	; 60
	.db #0x08	; 8
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x7c	; 124
	.db #0x3a	; 58
	.db #0x7e	; 126
	.db #0x22	; 34
	.db #0x66	; 102	'f'
	.db #0x22	; 34
	.db #0x66	; 102	'f'
	.db #0x04	; 4
	.db #0x7c	; 124
	.db #0x3a	; 58
	.db #0x7e	; 126
	.db #0x22	; 34
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x22	; 34
	.db #0x66	; 102	'f'
	.db #0x22	; 34
	.db #0x66	; 102	'f'
	.db #0x22	; 34
	.db #0x66	; 102	'f'
	.db #0x02	; 2
	.db #0x7e	; 126
	.db #0x3a	; 58
	.db #0x7e	; 126
	.db #0x22	; 34
	.db #0x66	; 102	'f'
	.db #0x22	; 34
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x7e	; 126
	.db #0x6e	; 110	'n'
	.db #0x7e	; 126
	.db #0x08	; 8
	.db #0x18	; 24
	.db #0x08	; 8
	.db #0x18	; 24
	.db #0x08	; 8
	.db #0x18	; 24
	.db #0x08	; 8
	.db #0x18	; 24
	.db #0x02	; 2
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x7e	; 126
	.db #0x20	; 32
	.db #0x60	; 96
	.db #0x04	; 4
	.db #0x3c	; 60
	.db #0x02	; 2
	.db #0x06	; 6
	.db #0x02	; 2
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x7e	; 126
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x7e	; 126
	.db #0x20	; 32
	.db #0x60	; 96
	.db #0x20	; 32
	.db #0x60	; 96
	.db #0x20	; 32
	.db #0x60	; 96
	.db #0x20	; 32
	.db #0x60	; 96
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x22	; 34
	.db #0x66	; 102	'f'
	.db #0x12	; 18
	.db #0x76	; 118	'v'
	.db #0x2a	; 42
	.db #0x7e	; 126
	.db #0x22	; 34
	.db #0x6e	; 110	'n'
	.db #0x22	; 34
	.db #0x66	; 102	'f'
	.db #0x22	; 34
	.db #0x66	; 102	'f'
	.db #0x22	; 34
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x22	; 34
	.db #0x66	; 102	'f'
	.db #0x22	; 34
	.db #0x66	; 102	'f'
	.db #0x22	; 34
	.db #0x66	; 102	'f'
	.db #0x22	; 34
	.db #0x66	; 102	'f'
	.db #0x2a	; 42
	.db #0x7e	; 126
	.db #0x12	; 18
	.db #0x7e	; 126
	.db #0x22	; 34
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x1c	; 28
	.db #0x02	; 2
	.db #0x3e	; 62
	.db #0x02	; 2
	.db #0x3e	; 62
	.db #0x02	; 2
	.db #0x3e	; 62
	.db #0x06	; 6
	.db #0x1e	; 30
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x1c	; 28
	.db #0x04	; 4
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_hub_no_element:
	.db #0x66	; 102	'f'
_hub_bubble:
	.db #0x6e	; 110	'n'
_hub_live:
	.db #0x67	; 103	'g'
;bubbles.c:19: void initBubbles(){  
;	---------------------------------
; Function initBubbles
; ---------------------------------
_initBubbles::
;bubbles.c:20: for( i = 0; i != MAX_BUBBLES_ON_SCREEN; i ++){
	ld	hl, #_i
	ld	(hl), #0x00
00108$:
;bubbles.c:21: bubbles_x[i] = 0;
	ld	a, #<(_bubbles_x)
	ld	hl, #_i
	add	a, (hl)
	ld	c, a
	ld	a, #>(_bubbles_x)
	adc	a, #0x00
	ld	b, a
	xor	a, a
	ld	(bc), a
;bubbles.c:22: bubbles_y[i] = 0;
	ld	a, #<(_bubbles_y)
	add	a, (hl)
	ld	c, a
	ld	a, #>(_bubbles_y)
	adc	a, #0x00
	ld	b, a
	xor	a, a
	ld	(bc), a
;bubbles.c:23: bubbles_active[i] = 0;     
	ld	a, #<(_bubbles_active)
	add	a, (hl)
	ld	c, a
	ld	a, #>(_bubbles_active)
	adc	a, #0x00
	ld	b, a
	xor	a, a
	ld	(bc), a
;bubbles.c:20: for( i = 0; i != MAX_BUBBLES_ON_SCREEN; i ++){
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x03
	jr	NZ, 00108$
;bubbles.c:25: player.used_bubbles = 0;
	ld	hl, #(_player + 0x0008)
	ld	(hl), #0x00
;c:/gbdk/include/gb/gb.h:610: shadow_OAM[nb].tile=tile; 
	ld	hl, #(_shadow_OAM + 0x0022)
	ld	(hl), #0x50
	ld	hl, #(_shadow_OAM + 0x0026)
	ld	(hl), #0x50
	ld	hl, #(_shadow_OAM + 0x002a)
	ld	(hl), #0x50
;c:/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM+32
;c:/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	xor	a, a
	ld	(bc), a
	inc	bc
	xor	a, a
	ld	(bc), a
;c:/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM+36
;c:/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	xor	a, a
	ld	(bc), a
	inc	bc
	xor	a, a
	ld	(bc), a
;c:/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM+40
;c:/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	xor	a, a
	ld	(bc), a
	inc	bc
	xor	a, a
	ld	(bc), a
;bubbles.c:34: set_win_tiles(17, 0, 1U, 1U, &hub_bubble);
	ld	bc, #_hub_bubble+0
	push	bc
	ld	de, #0x0101
	push	de
	xor	a, a
	ld	d,a
	ld	e,#0x11
	push	de
	call	_set_win_tiles
	add	sp, #6
;bubbles.c:35: set_win_tiles(18, 0, 1U, 1U, &hub_bubble);		
	push	bc
	ld	de, #0x0101
	push	de
	xor	a, a
	ld	d,a
	ld	e,#0x12
	push	de
	call	_set_win_tiles
	add	sp, #6
;bubbles.c:36: set_win_tiles(19, 0, 1U, 1U, &hub_bubble);		
	push	bc
	ld	de, #0x0101
	push	de
	xor	a, a
	ld	d,a
	ld	e,#0x13
	push	de
	call	_set_win_tiles
	add	sp, #6
;bubbles.c:37: }
	ret
;bubbles.c:39: void newBubble(){   	
;	---------------------------------
; Function newBubble
; ---------------------------------
_newBubble::
;bubbles.c:40: if(player.used_bubbles < 3){
	ld	a, (#(_player + 0x0008) + 0)
	sub	a, #0x03
	ret	NC
;bubbles.c:41: for( i = 0; i != MAX_BUBBLES_ON_SCREEN; i+=1u){
	ld	hl, #_i
	ld	(hl), #0x00
	ld	bc, #_bubbles_active+0
00109$:
;bubbles.c:42: if( !bubbles_active[i]){    
	ld	a, c
	ld	hl, #_i
	add	a, (hl)
	ld	e, a
	ld	a, b
	adc	a, #0x00
	ld	d, a
	ld	a, (de)
	or	a, a
	jr	NZ, 00110$
;bubbles.c:43: bubbles_y[i] = player.y + 8;
	ld	de, #_bubbles_y+0
	ld	a, e
	add	a, (hl)
	ld	e, a
	jr	NC, 00133$
	inc	d
00133$:
	ld	a, (#_player + 1)
	add	a, #0x08
	ld	(de), a
;bubbles.c:44: bubbles_active[i] = 1;
	ld	a, c
	ld	hl, #_i
	add	a, (hl)
	ld	c, a
	jr	NC, 00134$
	inc	b
00134$:
	ld	a, #0x01
	ld	(bc), a
;bubbles.c:45: bubbles_direction[i] = player.direction;
	ld	bc, #_bubbles_direction+0
	ld	a, c
	add	a, (hl)
	ld	e, a
	ld	a, b
	adc	a, #0x00
	ld	d, a
	ld	a, (#_player + 6)
	ld	(de), a
;bubbles.c:46: player.used_bubbles+=1U;
	ld	a, (#(_player + 0x0008) + 0)
	inc	a
	ld	(#(_player + 0x0008)),a
;bubbles.c:49: if(bubbles_direction[i] == 0x06){
	ld	a, c
	ld	hl, #_i
	add	a, (hl)
	ld	c, a
	jr	NC, 00135$
	inc	b
00135$:
	ld	a, (bc)
;bubbles.c:50: bubbles_x[i] = player.x + 16;
	ld	hl, #_player
	ld	c, (hl)
;bubbles.c:49: if(bubbles_direction[i] == 0x06){
	sub	a, #0x06
	jr	NZ, 00102$
;bubbles.c:50: bubbles_x[i] = player.x + 16;
	ld	de, #_bubbles_x+0
	ld	a, e
	ld	hl, #_i
	add	a, (hl)
	ld	e, a
	jr	NC, 00138$
	inc	d
00138$:
	ld	a, c
	add	a, #0x10
	ld	(de), a
	ret
00102$:
;bubbles.c:52: bubbles_x[i] = player.x;
	ld	de, #_bubbles_x+0
	ld	a, e
	ld	hl, #_i
	add	a, (hl)
	ld	e, a
	jr	NC, 00139$
	inc	d
00139$:
	ld	a, c
	ld	(de), a
;bubbles.c:54: break;
	ret
00110$:
;bubbles.c:41: for( i = 0; i != MAX_BUBBLES_ON_SCREEN; i+=1u){
	ld	hl, #_i
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x03
	jr	NZ, 00109$
;bubbles.c:58: }
	ret
;bubbles.c:65: void updateBubbles(){
;	---------------------------------
; Function updateBubbles
; ---------------------------------
_updateBubbles::
	dec	sp
;bubbles.c:66: if(player.used_bubbles){
	ld	a, (#(_player + 0x0008) + 0)
	or	a, a
	jp	Z, 00112$
;bubbles.c:68: for( j = 0; j != MAX_BUBBLES_ON_SCREEN; j+=1u){
	ld	hl, #_j
	ld	(hl), #0x00
00115$:
;bubbles.c:69: if(bubbles_active[j]){
	ld	a, #<(_bubbles_active)
	ld	hl, #_j
	add	a, (hl)
	ld	c, a
	ld	a, #>(_bubbles_active)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	or	a, a
	jr	Z, 00116$
;bubbles.c:70: if( bubbles_x[j] < 168  || bubbles_x[j] < 4){
	ld	a, #<(_bubbles_x)
	add	a, (hl)
	ld	c, a
	ld	a, #>(_bubbles_x)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	ldhl	sp,	#0
	ld	(hl), a
	ld	a, (hl)
	sub	a, #0xa8
	jr	C, 00104$
	ld	a, (hl)
	sub	a, #0x04
	jr	NC, 00105$
00104$:
;bubbles.c:72: if(bubbles_direction[j] == 0x06){
	ld	a, #<(_bubbles_direction)
	ld	hl, #_j
	add	a, (hl)
	ld	e, a
	ld	a, #>(_bubbles_direction)
	adc	a, #0x00
	ld	d, a
	ld	a, (de)
	sub	a, #0x06
	jr	NZ, 00102$
;bubbles.c:73: bubbles_x[j]+= 2u;			     	
	ldhl	sp,	#0
	ld	a, (hl)
	inc	a
	inc	a
	ld	(bc), a
	jr	00103$
00102$:
;bubbles.c:75: bubbles_x[j]-= 2u;
	ldhl	sp,	#0
	ld	a, (hl)
	dec	a
	dec	a
	ld	(bc), a
00103$:
;bubbles.c:78: move_sprite(8 + j, bubbles_x[j], bubbles_y[j]);					
	ld	a, #<(_bubbles_y)
	ld	hl, #_j
	add	a, (hl)
	ld	c, a
	ld	a, #>(_bubbles_y)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	ldhl	sp,	#0
	ld	(hl), a
	ld	a, #<(_bubbles_x)
	ld	hl, #_j
	add	a, (hl)
	ld	c, a
	ld	a, #>(_bubbles_x)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	ld	c, a
	ld	a, (hl)
	add	a, #0x08
	ld	e, a
;c:/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	h, #0x00
	ld	l, e
	add	hl, hl
	add	hl, hl
	ld	a, l
	add	a, #<(_shadow_OAM)
	ld	e, a
	ld	a, h
	adc	a, #>(_shadow_OAM)
	ld	d, a
;c:/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(de), a
	inc	de
	ld	a, c
	ld	(de), a
;bubbles.c:78: move_sprite(8 + j, bubbles_x[j], bubbles_y[j]);					
	jr	00116$
00105$:
;bubbles.c:80: deactiveBubble(j);
	ld	a, (#_j)
	push	af
	inc	sp
	call	_deactiveBubble
	inc	sp
00116$:
;bubbles.c:68: for( j = 0; j != MAX_BUBBLES_ON_SCREEN; j+=1u){
	ld	hl, #_j
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x03
	jp	NZ,00115$
00112$:
;bubbles.c:89: set_win_tiles(17, 0, 1U, 1U, &hub_bubble);
	ld	bc, #_hub_bubble+0
	push	bc
	ld	de, #0x0101
	push	de
	xor	a, a
	ld	d,a
	ld	e,#0x11
	push	de
	call	_set_win_tiles
	add	sp, #6
;bubbles.c:90: set_win_tiles(18, 0, 1U, 1U, &hub_bubble);		
	push	bc
	ld	de, #0x0101
	push	de
	xor	a, a
	ld	d,a
	ld	e,#0x12
	push	de
	call	_set_win_tiles
	add	sp, #6
;bubbles.c:91: set_win_tiles(19, 0, 1U, 1U, &hub_bubble);			
	push	bc
	ld	de, #0x0101
	push	de
	xor	a, a
	ld	d,a
	ld	e,#0x13
	push	de
	call	_set_win_tiles
	add	sp, #6
;bubbles.c:92: for(j = 0; j < player.used_bubbles; j+=1u){				
	ld	hl, #_j
	ld	(hl), #0x00
00118$:
	ld	hl, #(_player + 0x0008)
	ld	c, (hl)
	ld	hl, #_j
	ld	a, (hl)
	sub	a, c
	jr	NC, 00120$
;bubbles.c:93: set_win_tiles(17 + j, 0, 1U, 1U, &hub_no_element);
	ld	bc, #_hub_no_element+0
	ld	a, (hl)
	add	a, #0x11
	push	bc
	ld	h, #0x01
	push	hl
	inc	sp
	ld	h, #0x01
	push	hl
	inc	sp
	ld	h, #0x00
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_set_win_tiles
	add	sp, #6
;bubbles.c:92: for(j = 0; j < player.used_bubbles; j+=1u){				
	ld	hl, #_j
	inc	(hl)
	jr	00118$
00120$:
;bubbles.c:98: }
	inc	sp
	ret
;score.c:2: void updateScore(){
;	---------------------------------
; Function updateScore
; ---------------------------------
_updateScore::
;score.c:4: if(score == 20u){
	ld	hl, #_score
	ld	a, (hl)
	sub	a, #0x14
	inc	hl
	or	a, (hl)
	jr	NZ, 00102$
;score.c:5: max_enemies_on_creen = 3;
	ld	hl, #_max_enemies_on_creen
	ld	(hl), #0x03
00102$:
;score.c:8: if(score == 40u){
	ld	hl, #_score
	ld	a, (hl)
	sub	a, #0x28
	inc	hl
	or	a, (hl)
	jr	NZ, 00104$
;score.c:9: max_enemies_on_creen = 4;
	ld	hl, #_max_enemies_on_creen
	ld	(hl), #0x04
00104$:
;score.c:12: if(score == 60u){
	ld	hl, #_score
	ld	a, (hl)
	sub	a, #0x3c
	inc	hl
	or	a, (hl)
	jr	NZ, 00106$
;score.c:13: max_enemies_on_creen = 5;
	ld	hl, #_max_enemies_on_creen
	ld	(hl), #0x05
00106$:
;score.c:16: if(score == 80u){
	ld	hl, #_score
	ld	a, (hl)
	sub	a, #0x50
	inc	hl
	or	a, (hl)
	jr	NZ, 00108$
;score.c:17: max_enemies_on_creen = 6;
	ld	hl, #_max_enemies_on_creen
	ld	(hl), #0x06
00108$:
;score.c:20: if(score == 100u){
	ld	hl, #_score
	ld	a, (hl)
	sub	a, #0x64
	inc	hl
	or	a, (hl)
	jr	NZ, 00110$
;score.c:21: max_enemies_on_creen = 7;
	ld	hl, #_max_enemies_on_creen
	ld	(hl), #0x07
00110$:
;score.c:24: if(score == 120u){
	ld	hl, #_score
	ld	a, (hl)
	sub	a, #0x78
	inc	hl
	or	a, (hl)
	jr	NZ, 00112$
;score.c:25: max_enemies_on_creen = 8;
	ld	hl, #_max_enemies_on_creen
	ld	(hl), #0x08
00112$:
;score.c:28: if(score == 140u){
	ld	hl, #_score
	ld	a, (hl)
	sub	a, #0x8c
	inc	hl
	or	a, (hl)
	jr	NZ, 00114$
;score.c:29: max_enemies_on_creen = 9;
	ld	hl, #_max_enemies_on_creen
	ld	(hl), #0x09
00114$:
;score.c:32: temp_score = score;
	ld	hl, #_score
	ld	a, (hl+)
	ld	e, (hl)
	ld	hl, #_temp_score
	ld	(hl+), a
	ld	(hl), e
;score.c:34: if(score >= 100U) {
	ld	hl, #_score
	ld	a, (hl)
	sub	a, #0x64
	inc	hl
	ld	a, (hl)
	sbc	a, #0x00
	jr	C, 00116$
;score.c:35: temp_score = score / 100U;
	ld	hl, #0x0064
	push	hl
	ld	hl, #_score
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	__divuint
	add	sp, #4
	ld	hl, #_temp_score
	ld	a, e
	ld	(hl+), a
;score.c:36: temp_score+= 0x5C;		
	ld	a, d
	ld	(hl-), a
	ld	a, (hl)
	add	a, #0x5c
	ld	(hl+), a
	ld	a, (hl)
	adc	a, #0x00
	ld	(hl), a
;score.c:37: set_win_tiles(10u, 0, 1U, 1U, &temp_score);
	ld	hl, #_temp_score
	push	hl
	ld	de, #0x0101
	push	de
	xor	a, a
	ld	d,a
	ld	e,#0x0a
	push	de
	call	_set_win_tiles
	add	sp, #6
00116$:
;score.c:39: if(score >= 10U) {
	ld	hl, #_score
	ld	a, (hl)
	sub	a, #0x0a
	inc	hl
	ld	a, (hl)
	sbc	a, #0x00
	jr	C, 00118$
;score.c:40: temp_score = (score / 10U) % 10;
	ld	hl, #0x000a
	push	hl
	ld	hl, #_score
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	__divuint
	add	sp, #4
	ld	hl, #0x000a
	push	hl
	push	de
	call	__moduint
	add	sp, #4
	ld	hl, #_temp_score
	ld	a, e
	ld	(hl+), a
;score.c:41: temp_score+= 0x5C;
	ld	a, d
	ld	(hl-), a
	ld	a, (hl)
	add	a, #0x5c
	ld	(hl+), a
	ld	a, (hl)
	adc	a, #0x00
	ld	(hl), a
;score.c:42: set_win_tiles(11u, 0, 1U, 1U, &temp_score);
	ld	hl, #_temp_score
	push	hl
	ld	de, #0x0101
	push	de
	xor	a, a
	ld	d,a
	ld	e,#0x0b
	push	de
	call	_set_win_tiles
	add	sp, #6
00118$:
;score.c:44: if(score) {
	ld	hl, #_score + 1
	ld	a, (hl-)
	or	a, (hl)
	ret	Z
;score.c:45: temp_score = score % 10U;
	ld	hl, #0x000a
	push	hl
	ld	hl, #_score
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	__moduint
	add	sp, #4
	ld	hl, #_temp_score
	ld	a, e
	ld	(hl+), a
;score.c:46: temp_score+= 0x5C;
	ld	a, d
	ld	(hl-), a
	ld	a, (hl)
	add	a, #0x5c
	ld	(hl+), a
	ld	a, (hl)
	adc	a, #0x00
	ld	(hl), a
;score.c:47: set_win_tiles(12U, 0, 1U, 1U, &temp_score);		
	ld	hl, #_temp_score
	push	hl
	ld	de, #0x0101
	push	de
	xor	a, a
	ld	d,a
	ld	e,#0x0c
	push	de
	call	_set_win_tiles
	add	sp, #6
;score.c:50: }
	ret
;enemies.c:1: void enemieSplash(UINT8 x, UINT8 y){
;	---------------------------------
; Function enemieSplash
; ---------------------------------
_enemieSplash::
;enemies.c:2: enemies_splash_delay = 100u;
	ld	hl, #_enemies_splash_delay
	ld	(hl), #0x64
;c:/gbdk/include/gb/gb.h:610: shadow_OAM[nb].tile=tile; 
	ld	hl, #(_shadow_OAM + 0x002e)
	ld	(hl), #0x52
	ld	hl, #(_shadow_OAM + 0x0032)
	ld	(hl), #0x54
;enemies.c:6: move_sprite(11, x, y);
	ldhl	sp,	#3
	ld	a, (hl-)
	ld	b, a
	ld	c, (hl)
;c:/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x002c)
;c:/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;enemies.c:7: move_sprite(12, x + 8, y);
	ld	a, c
	add	a, #0x08
	ld	c, a
;c:/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x0030)
;c:/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;enemies.c:7: move_sprite(12, x + 8, y);
;enemies.c:9: }
	ret
;enemies.c:11: void deactiveEnemie(UINT8 i){	
;	---------------------------------
; Function deactiveEnemie
; ---------------------------------
_deactiveEnemie::
;enemies.c:12: enemies_x[i] = 0;
	ld	bc, #_enemies_x+0
	ldhl	sp,	#2
	ld	l, (hl)
	ld	h, #0x00
	add	hl, bc
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
;enemies.c:13: enemies_y[i] = 0;
	ld	bc, #_enemies_y+0
	ldhl	sp,	#2
	ld	l, (hl)
	ld	h, #0x00
	add	hl, bc
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
;enemies.c:14: enemies_active[i] = 0;
	ld	bc, #_enemies_active+0
	ldhl	sp,	#2
	ld	l, (hl)
	ld	h, #0x00
	add	hl, bc
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
;enemies.c:15: enemies_direction[i] = 0;
	ld	bc, #_enemies_direction+0
	ldhl	sp,	#2
	ld	l, (hl)
	ld	h, #0x00
	add	hl, bc
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
;enemies.c:16: enemies_jumps[i] = 0;	
	ld	bc, #_enemies_jumps+0
	ldhl	sp,	#2
	ld	l, (hl)
	ld	h, #0x00
	add	hl, bc
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
;enemies.c:17: }
	ret
;enemies.c:20: void collideWithEnemie(UINT8 i){
;	---------------------------------
; Function collideWithEnemie
; ---------------------------------
_collideWithEnemie::
	add	sp, #-6
;enemies.c:22: x1 = player.x+ 4;
	ld	a, (#_player + 0)
	add	a, #0x04
	ld	(#_x1),a
;enemies.c:23: y1 = player.y + 4;
	ld	a, (#(_player + 0x0001) + 0)
	add	a, #0x04
	ld	(#_y1),a
;enemies.c:24: w1 = 24u;
	ld	hl, #_w1
	ld	(hl), #0x18
;enemies.c:25: h1 = 24u;
	ld	hl, #_h1
	ld	(hl), #0x18
;enemies.c:26: x2 = enemies_x[i];							     		
	ld	de, #_enemies_x
	ldhl	sp,	#8
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	a, (de)
	ld	(#_x2),a
;enemies.c:27: w2 = 15;
	ld	hl, #_w2
	ld	(hl), #0x0f
;enemies.c:28: y2 = enemies_y[i] + 4;
	ld	de, #_enemies_y
	ldhl	sp,	#8
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	a, l
	ld	d, h
	ldhl	sp,	#2
	ld	(hl+), a
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	add	a, #0x04
	ld	(#_y2),a
;enemies.c:29: h2 = 10;
	ld	hl, #_h2
	ld	(hl), #0x0a
;enemies.c:31: s1 = x1 + w1; // r1 right edge past r2 left
	ld	a, (#_x1)
	add	a, #0x18
	ld	(#_s1),a
;enemies.c:32: s2 = x2 + w2; // r1 left edge past r2 right
	ld	a, (#_x2)
	add	a, #0x0f
	ld	(#_s2),a
;enemies.c:33: s3 = y1 + h1; // r1 top edge past r2 bottom
	ld	a, (#_y1)
	add	a, #0x18
	ld	(#_s3),a
;enemies.c:34: s4 = y2 + h2; // r1 bottom edge past r2 top*/
	ld	a, (#_y2)
	add	a, #0x0a
	ld	(#_s4),a
;enemies.c:36: if( x2 >= s1 || s2 <= x1 || y2 >= s3 || s4 <= y1 ){
	ld	a, (#_x2)
	ld	hl, #_s1
	sub	a, (hl)
	jr	NC, 00116$
	ld	a, (#_x1)
	ld	hl, #_s2
	sub	a, (hl)
	jr	NC, 00116$
	ld	a, (#_y2)
	ld	hl, #_s3
	sub	a, (hl)
	jr	NC, 00116$
	ld	a, (#_y1)
	ld	hl, #_s4
	sub	a, (hl)
	jp	C, 00117$
00116$:
;enemies.c:37: collision_1 =  0;
	ld	hl, #_collision_1
	ld	(hl), #0x00
;enemies.c:39: for( j = 0; j != MAX_BUBBLES_ON_SCREEN; j+=1u){
	ld	hl, #_j
	ld	(hl), #0x00
	ld	de, #_enemies_type
	ldhl	sp,	#8
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	a, l
	ld	d, h
	ldhl	sp,	#4
	ld	(hl+), a
	ld	(hl), d
00122$:
;enemies.c:40: if(bubbles_active[j]){
	ld	a, #<(_bubbles_active)
	ld	hl, #_j
	add	a, (hl)
	ld	c, a
	ld	a, #>(_bubbles_active)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	or	a, a
	jp	Z, 00123$
;enemies.c:41: x1 = bubbles_x[j];
	ld	a, #<(_bubbles_x)
	add	a, (hl)
	ld	c, a
	ld	a, #>(_bubbles_x)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	ld	(#_x1),a
;enemies.c:42: y1 = bubbles_y[j] + 4;
	ld	a, #<(_bubbles_y)
	ld	hl, #_j
	add	a, (hl)
	ld	c, a
	ld	a, #>(_bubbles_y)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	add	a, #0x04
	ld	(#_y1),a
;enemies.c:43: w1 = 8u;
	ld	hl, #_w1
	ld	(hl), #0x08
;enemies.c:44: h1 = 9u;
	ld	hl, #_h1
	ld	(hl), #0x09
;enemies.c:50: s1 = x1 + w1; // r1 right edge past r2 left
	ld	a, (#_x1)
	add	a, #0x08
	ld	(#_s1),a
;enemies.c:51: s2 = x2 + w2; // r1 left edge past r2 right
	ld	a, (#_x2)
	ld	hl, #_w2
	add	a, (hl)
	ld	(#_s2),a
;enemies.c:52: s3 = y1 + h1; // r1 top edge past r2 bottom
	ld	a, (#_y1)
	add	a, #0x09
	ld	(#_s3),a
;enemies.c:53: s4 = y2 + h2; // r1 bottom edge past r2 top*/
	ld	a, (#_y2)
	ld	hl, #_h2
	add	a, (hl)
	ld	(#_s4),a
;enemies.c:55: if( x2 >= s1 || s2 <= x1 || y2 >= s3 || s4 <= y1 ){
	ld	a, (#_x2)
	ld	hl, #_s1
	sub	a, (hl)
	jp	NC, 00123$
	ld	a, (#_x1)
	ld	hl, #_s2
	sub	a, (hl)
	jr	NC, 00123$
	ld	a, (#_y2)
	ld	hl, #_s3
	sub	a, (hl)
	jr	NC, 00123$
	ld	a, (#_y1)
	ld	hl, #_s4
	sub	a, (hl)
	jr	NC, 00123$
;enemies.c:60: enemieSplash(enemies_x[i], enemies_y[i]);
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	b, a
	pop	de
	push	de
	ld	a, (de)
	push	bc
	inc	sp
	push	af
	inc	sp
	call	_enemieSplash
	add	sp, #2
;enemies.c:63: if(score != 999u){
	ld	hl, #_score
	ld	a, (hl)
	sub	a, #0xe7
	jr	NZ, 00191$
	inc	hl
	ld	a, (hl)
	sub	a, #0x03
	jr	Z, 00106$
00191$:
;enemies.c:64: switch(enemies_type[i]){
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	cp	a, #0x02
	jr	Z, 00101$
	sub	a, #0x03
	jr	Z, 00102$
	jr	00103$
;enemies.c:65: case 2://fish
00101$:
;enemies.c:66: score+=3U;
	ld	hl, #_score
	ld	a, (hl)
	add	a, #0x03
	ld	(hl+), a
	ld	a, (hl)
	adc	a, #0x00
	ld	(hl), a
;enemies.c:67: break;
	jr	00104$
;enemies.c:68: case 3:
00102$:
;enemies.c:69: score+=2U;//star
	ld	hl, #_score
	ld	a, (hl)
	add	a, #0x02
	ld	(hl+), a
	ld	a, (hl)
	adc	a, #0x00
	ld	(hl), a
;enemies.c:70: break;
	jr	00104$
;enemies.c:71: default :
00103$:
;enemies.c:72: score+=1U;//bird
	ld	hl, #_score
	inc	(hl)
	jr	NZ, 00194$
	inc	hl
	inc	(hl)
00194$:
;enemies.c:74: }									
00104$:
;enemies.c:75: updateScore();							
	call	_updateScore
00106$:
;enemies.c:77: deactiveEnemie(i);
	ldhl	sp,	#8
	ld	a, (hl)
	push	af
	inc	sp
	call	_deactiveEnemie
	inc	sp
;enemies.c:78: deactiveBubble(j);
	ld	a, (#_j)
	push	af
	inc	sp
	call	_deactiveBubble
	inc	sp
00123$:
;enemies.c:39: for( j = 0; j != MAX_BUBBLES_ON_SCREEN; j+=1u){
	ld	hl, #_j
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x03
	jr	Z, 00124$
	jp	00122$
00117$:
;enemies.c:83: collision_1 = 1;
	ld	hl, #_collision_1
	ld	(hl), #0x01
00124$:
;enemies.c:87: }
	add	sp, #6
	ret
;enemies.c:94: void initEnemies(){		
;	---------------------------------
; Function initEnemies
; ---------------------------------
_initEnemies::
;enemies.c:95: used_enemies = 0;
	ld	hl, #_used_enemies
	ld	(hl), #0x00
;enemies.c:96: for(i = 0; i < max_enemies_on_creen; i+=1){		
	ld	hl, #_i
	ld	(hl), #0x00
00103$:
	ld	a, (#_i)
	ld	hl, #_max_enemies_on_creen
	sub	a, (hl)
	ret	NC
;enemies.c:97: deactiveEnemie(i);
	ld	a, (#_i)
	push	af
	inc	sp
	call	_deactiveEnemie
	inc	sp
;enemies.c:96: for(i = 0; i < max_enemies_on_creen; i+=1){		
	ld	hl, #_i
	inc	(hl)
;enemies.c:99: }
	jr	00103$
;enemies.c:104: void enemieSplashUpdate(){
;	---------------------------------
; Function enemieSplashUpdate
; ---------------------------------
_enemieSplashUpdate::
;enemies.c:105: if(enemies_splash_delay){
	ld	hl, #_enemies_splash_delay
	ld	a, (hl)
	or	a, a
	jr	Z, 00102$
;enemies.c:111: enemies_splash_delay-= 1u;
	dec	(hl)
	ret
00102$:
;c:/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM+44
;c:/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	xor	a, a
	ld	(bc), a
	inc	bc
	xor	a, a
	ld	(bc), a
;c:/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM+48
;c:/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	xor	a, a
	ld	(bc), a
	inc	bc
	xor	a, a
	ld	(bc), a
;enemies.c:114: move_sprite(12, 0, 0);
;enemies.c:116: }
	ret
;enemies.c:120: void updateEnemies(){
;	---------------------------------
; Function updateEnemies
; ---------------------------------
_updateEnemies::
;enemies.c:122: for( i = 0; i != max_enemies_on_creen; i+=1u){
	ld	hl, #_i
	ld	(hl), #0x00
00145$:
	ld	a, (#_i)
	ld	hl, #_max_enemies_on_creen
	sub	a, (hl)
	ret	Z
;enemies.c:123: if(enemies_active[i]){ 
	ld	bc, #_enemies_active+0
	ld	a, c
	ld	hl, #_i
	add	a, (hl)
	ld	e, a
	ld	a, b
	adc	a, #0x00
	ld	d, a
	ld	a, (de)
	or	a, a
	jp	Z, 00136$
;enemies.c:125: if( enemies_x[i] < 170  || enemies_x[i] < 1){															
	ld	a, #<(_enemies_x)
	add	a, (hl)
	ld	e, a
	ld	a, #>(_enemies_x)
	adc	a, #0x00
	ld	d, a
	ld	a, (de)
	cp	a, #0xaa
	jr	C, 00131$
	sub	a, #0x01
	jp	NC, 00132$
00131$:
;enemies.c:127: collideWithEnemie(i);
	push	bc
	ld	a, (#_i)
	push	af
	inc	sp
	call	_collideWithEnemie
	inc	sp
	pop	bc
;enemies.c:129: if(collision_1){ //collision		
	ld	a, (#_collision_1)
	or	a, a
	jr	Z, 00102$
;enemies.c:131: deactiveEnemie(i);
	ld	a, (#_i)
	push	af
	inc	sp
	call	_deactiveEnemie
	inc	sp
;enemies.c:132: enemieSplash(enemies_x[i], enemies_y[i]);
	ld	a, #<(_enemies_y)
	ld	hl, #_i
	add	a, (hl)
	ld	c, a
	ld	a, #>(_enemies_y)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	ld	b, a
	ld	a, #<(_enemies_x)
	add	a, (hl)
	ld	e, a
	ld	a, #>(_enemies_x)
	adc	a, #0x00
	ld	d, a
	ld	a, (de)
	push	bc
	inc	sp
	push	af
	inc	sp
	call	_enemieSplash
	add	sp, #2
;enemies.c:133: GAMESTATE = GAMESTATE_PLAYER_DIE;
	ld	hl, #_GAMESTATE
	ld	(hl), #0x09
;enemies.c:134: return;
	ret
00102$:
;enemies.c:139: if(enemies_active[i]){ 
	ld	a, c
	ld	hl, #_i
	add	a, (hl)
	ld	c, a
	jr	NC, 00230$
	inc	b
00230$:
	ld	a, (bc)
	or	a, a
	jp	Z, 00136$
;enemies.c:144: switch(enemies_type[i]){
	ld	a, #<(_enemies_type)
	add	a, (hl)
	ld	c, a
	ld	a, #>(_enemies_type)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	cp	a, #0x02
	jr	Z, 00103$
	sub	a, #0x03
	jr	Z, 00113$
	jp	00124$
;enemies.c:147: case 2: //fish
00103$:
;enemies.c:148: if(wave_fish < 16 ){
	ld	a, (#_wave_fish)
	sub	a, #0x10
	jr	NC, 00105$
;enemies.c:149: enemies_y[i]+= enemies_speed;			     	
	ld	a, #<(_enemies_y)
	ld	hl, #_i
	add	a, (hl)
	ld	c, a
	ld	a, #>(_enemies_y)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	ld	hl, #_enemies_speed
	add	a, (hl)
	ld	(bc), a
	jr	00106$
00105$:
;enemies.c:151: enemies_y[i]-= enemies_speed;			     	
	ld	a, #<(_enemies_y)
	ld	hl, #_i
	add	a, (hl)
	ld	c, a
	ld	a, #>(_enemies_y)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	ld	hl, #_enemies_speed
	sub	a, (hl)
	ld	(bc), a
00106$:
;enemies.c:155: if(wave_fish == 32 ){
	ld	a, (#_wave_fish)
	sub	a, #0x20
	jr	NZ, 00108$
;enemies.c:156: wave_fish = 0;
	ld	hl, #_wave_fish
	ld	(hl), #0x00
	jr	00109$
00108$:
;enemies.c:158: wave_fish+= 1;
	ld	hl, #_wave_fish
	inc	(hl)
00109$:
;enemies.c:161: if(enemies_direction[i]){
	ld	a, #<(_enemies_direction)
	ld	hl, #_i
	add	a, (hl)
	ld	c, a
	ld	a, #>(_enemies_direction)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	ld	c, a
;enemies.c:132: enemieSplash(enemies_x[i], enemies_y[i]);
	ld	a, #<(_enemies_x)
	add	a, (hl)
	ld	e, a
	ld	a, #>(_enemies_x)
	adc	a, #0x00
	ld	d, a
;enemies.c:162: enemies_x[i] += enemies_speed;				     		
	ld	a, (de)
;enemies.c:161: if(enemies_direction[i]){
	inc	c
	dec	c
	jr	Z, 00111$
;enemies.c:162: enemies_x[i] += enemies_speed;				     		
	ld	hl, #_enemies_speed
	add	a, (hl)
	ld	(de), a
	jp	00136$
00111$:
;enemies.c:164: enemies_x[i] -= enemies_speed;
	ld	hl, #_enemies_speed
	sub	a, (hl)
	ld	(de), a
;enemies.c:167: break;
	jp	00136$
;enemies.c:169: case 3: //star
00113$:
;enemies.c:170: if(enemies_y[i] < 96){
	ld	a, #<(_enemies_y)
	ld	hl, #_i
	add	a, (hl)
	ld	c, a
	ld	a, #>(_enemies_y)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	sub	a, #0x60
	jr	NC, 00115$
;enemies.c:171: enemies_direction[i] = 1;
	ld	a, #<(_enemies_direction)
	add	a, (hl)
	ld	c, a
	ld	a, #>(_enemies_direction)
	adc	a, #0x00
	ld	b, a
	ld	a, #0x01
	ld	(bc), a
;enemies.c:172: enemies_jumps[i]+=1;
	ld	a, #<(_enemies_jumps)
	add	a, (hl)
	ld	c, a
	ld	a, #>(_enemies_jumps)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	inc	a
	ld	(bc), a
;enemies.c:173: set_sprite_tile(16 + i, 0x6A );
	ld	a, (hl)
	add	a, #0x10
	ld	e, a
;c:/gbdk/include/gb/gb.h:610: shadow_OAM[nb].tile=tile; 
	ld	bc, #_shadow_OAM+0
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, bc
	inc	hl
	inc	hl
	ld	(hl), #0x6a
;enemies.c:174: set_sprite_tile(28 + i, 0x6C );										
	ld	a, (#_i)
	add	a, #0x1c
	ld	e, a
;c:/gbdk/include/gb/gb.h:610: shadow_OAM[nb].tile=tile; 
	ld	bc, #_shadow_OAM+0
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, bc
	inc	hl
	inc	hl
	ld	(hl), #0x6c
;enemies.c:174: set_sprite_tile(28 + i, 0x6C );										
00115$:
;enemies.c:177: if( enemies_y[i] > 136){
	ld	a, #<(_enemies_y)
	ld	hl, #_i
	add	a, (hl)
	ld	c, a
	ld	a, #>(_enemies_y)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	ld	c, a
	ld	a, #0x88
	sub	a, c
	jr	NC, 00120$
;enemies.c:178: if(enemies_jumps[i] < 1){
	ld	a, #<(_enemies_jumps)
	add	a, (hl)
	ld	c, a
	ld	a, #>(_enemies_jumps)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	sub	a, #0x01
	jr	NC, 00117$
;enemies.c:179: enemies_direction[i] = 0;
	ld	a, #<(_enemies_direction)
	add	a, (hl)
	ld	c, a
	ld	a, #>(_enemies_direction)
	adc	a, #0x00
	ld	b, a
	xor	a, a
	ld	(bc), a
;enemies.c:180: set_sprite_tile(16 + i, 0x66 );
	ld	a, (hl)
	add	a, #0x10
	ld	c, a
;c:/gbdk/include/gb/gb.h:610: shadow_OAM[nb].tile=tile; 
	ld	h, #0x00
	ld	l, c
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), #0x66
;enemies.c:181: set_sprite_tile(28 + i, 0x68 );											
	ld	a, (#_i)
	add	a, #0x1c
	ld	c, a
;c:/gbdk/include/gb/gb.h:610: shadow_OAM[nb].tile=tile; 
	ld	h, #0x00
	ld	l, c
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), #0x68
;enemies.c:181: set_sprite_tile(28 + i, 0x68 );											
	jr	00120$
00117$:
;enemies.c:183: deactiveEnemie(i);
	ld	a, (#_i)
	push	af
	inc	sp
	call	_deactiveEnemie
	inc	sp
;enemies.c:184: break;
	jr	00136$
00120$:
;enemies.c:189: if(enemies_direction[i]){
	ld	a, #<(_enemies_direction)
	ld	hl, #_i
	add	a, (hl)
	ld	c, a
	ld	a, #>(_enemies_direction)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	ld	c, a
;enemies.c:170: if(enemies_y[i] < 96){
	ld	a, #<(_enemies_y)
	add	a, (hl)
	ld	e, a
	ld	a, #>(_enemies_y)
	adc	a, #0x00
	ld	d, a
;enemies.c:190: enemies_y[i]+= enemies_speed;				     							     		
	ld	a, (de)
;enemies.c:189: if(enemies_direction[i]){
	inc	c
	dec	c
	jr	Z, 00122$
;enemies.c:190: enemies_y[i]+= enemies_speed;				     							     		
	ld	hl, #_enemies_speed
	add	a, (hl)
	ld	(de), a
	jr	00136$
00122$:
;enemies.c:192: enemies_y[i]-= enemies_speed;					     		
	ld	hl, #_enemies_speed
	sub	a, (hl)
	ld	(de), a
;enemies.c:195: break;
	jr	00136$
;enemies.c:196: default : //bird
00124$:
;enemies.c:197: if(enemies_direction[i]){
	ld	a, #<(_enemies_direction)
	ld	hl, #_i
	add	a, (hl)
	ld	c, a
	ld	a, #>(_enemies_direction)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	ld	c, a
;enemies.c:132: enemieSplash(enemies_x[i], enemies_y[i]);
	ld	a, #<(_enemies_x)
	add	a, (hl)
	ld	e, a
	ld	a, #>(_enemies_x)
	adc	a, #0x00
	ld	d, a
;enemies.c:162: enemies_x[i] += enemies_speed;				     		
	ld	a, (de)
;enemies.c:197: if(enemies_direction[i]){
	inc	c
	dec	c
	jr	Z, 00126$
;enemies.c:198: enemies_x[i]+= enemies_speed;			     	
	ld	hl, #_enemies_speed
	add	a, (hl)
	ld	(de), a
	jr	00136$
00126$:
;enemies.c:200: enemies_x[i]-= enemies_speed;
	ld	hl, #_enemies_speed
	sub	a, (hl)
	ld	(de), a
;enemies.c:204: }
	jr	00136$
00132$:
;enemies.c:211: deactiveEnemie(i);
	ld	a, (#_i)
	push	af
	inc	sp
	call	_deactiveEnemie
	inc	sp
00136$:
;enemies.c:218: move_sprite(16+i , enemies_x[i], enemies_y[i]);
	ld	a, #<(_enemies_y)
	ld	hl, #_i
	add	a, (hl)
	ld	c, a
	ld	a, #>(_enemies_y)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	ld	c, a
	ld	a, #<(_enemies_x)
	add	a, (hl)
	ld	e, a
	ld	a, #>(_enemies_x)
	adc	a, #0x00
	ld	d, a
	ld	a, (de)
	ld	b, a
	ld	a, (hl)
	add	a, #0x10
	ld	e, a
;c:/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	h, #0x00
	ld	l, e
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;c:/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;enemies.c:219: move_sprite(28+i , enemies_x[i] + 8, enemies_y[i] );
	ld	a, #<(_enemies_y)
	ld	hl, #_i
	add	a, (hl)
	ld	c, a
	ld	a, #>(_enemies_y)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	ld	c, a
	ld	a, #<(_enemies_x)
	add	a, (hl)
	ld	e, a
	ld	a, #>(_enemies_x)
	adc	a, #0x00
	ld	d, a
	ld	a, (de)
	add	a, #0x08
	ld	b, a
	ld	a, (hl)
	add	a, #0x1c
	ld	e, a
;c:/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	h, #0x00
	ld	l, e
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;c:/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;enemies.c:220: enemieSplashUpdate();
	call	_enemieSplashUpdate
;enemies.c:122: for( i = 0; i != max_enemies_on_creen; i+=1u){
	ld	hl, #_i
	inc	(hl)
;enemies.c:225: }
	jp	00145$
;enemies.c:228: void animateEnemies(){
;	---------------------------------
; Function animateEnemies
; ---------------------------------
_animateEnemies::
	add	sp, #-6
;enemies.c:229: if(enemie_delay > 4u){			  	
	ld	a, #0x04
	ld	hl, #_enemie_delay
	sub	a, (hl)
	jp	NC, 00115$
;enemies.c:230: enemie_delay = 0;
	ld	(hl), #0x00
;enemies.c:231: for(i = 0; i < max_enemies_on_creen; i +=1){
	ld	hl, #_i
	ld	(hl), #0x00
00126$:
	ld	a, (#_i)
	ld	hl, #_max_enemies_on_creen
	sub	a, (hl)
	jp	NC, 00128$
;enemies.c:233: if(enemies_active[i]){
	ld	a, #<(_enemies_active)
	ld	hl, #_i
	add	a, (hl)
	ld	c, a
	ld	a, #>(_enemies_active)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	or	a, a
	jp	Z, 00127$
;enemies.c:235: switch(enemies_type[i]){
	ld	a, #<(_enemies_type)
	add	a, (hl)
	ld	c, a
	ld	a, #>(_enemies_type)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	ld	c, a
;enemies.c:238: if(enemies_direction[i]){
	ld	de, #_enemies_direction
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	inc	sp
	inc	sp
	push	hl
;enemies.c:239: set_sprite_tile(16 + i, 0x5E + enemie_animation_b);
	ld	hl, #_i
	ld	b, (hl)
	ld	a, b
	add	a, #0x10
	ldhl	sp,	#2
	ld	(hl), a
;enemies.c:242: set_sprite_tile(28 + i, 0x5E + enemie_animation_b);
	ld	a, b
	add	a, #0x1c
	inc	hl
	ld	(hl), a
;enemies.c:235: switch(enemies_type[i]){
	ld	a,c
	cp	a,#0x02
	jr	Z, 00101$
	sub	a, #0x03
	jp	Z,00127$
	jp	00106$
;enemies.c:236: case 2 :
00101$:
;enemies.c:237: enemie_animation_b = enemie_animation_b ? 0 : 4;
	ld	a, (#_enemie_animation_b)
	or	a, a
	jr	Z, 00130$
	xor	a, a
	ldhl	sp,	#4
	ld	(hl+), a
	ld	(hl), a
	jr	00131$
00130$:
	ldhl	sp,	#4
	ld	(hl), #0x04
	xor	a, a
	inc	hl
	ld	(hl), a
00131$:
	ldhl	sp,	#4
	ld	a, (hl)
	ld	hl, #_enemie_animation_b
	ld	(hl), a
;enemies.c:238: if(enemies_direction[i]){
	pop	de
	push	de
	ld	a, (de)
	ld	b, a
;enemies.c:239: set_sprite_tile(16 + i, 0x5E + enemie_animation_b);
	ld	a, (hl)
	add	a, #0x5e
	ld	c, a
;enemies.c:238: if(enemies_direction[i]){
	ld	a, b
	or	a, a
	jr	Z, 00103$
;enemies.c:239: set_sprite_tile(16 + i, 0x5E + enemie_animation_b);
	ldhl	sp,	#2
	ld	e, (hl)
;c:/gbdk/include/gb/gb.h:610: shadow_OAM[nb].tile=tile; 
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), c
;enemies.c:240: set_sprite_tile(28 + i, 0x60 + enemie_animation_b);	
	ld	a, (#_enemie_animation_b)
	add	a, #0x60
	ld	c, a
	ld	a, (#_i)
	add	a, #0x1c
	ld	e, a
;c:/gbdk/include/gb/gb.h:610: shadow_OAM[nb].tile=tile; 
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), c
;enemies.c:240: set_sprite_tile(28 + i, 0x60 + enemie_animation_b);	
	jp	00127$
00103$:
;enemies.c:242: set_sprite_tile(28 + i, 0x5E + enemie_animation_b);
	ldhl	sp,	#3
	ld	e, (hl)
;c:/gbdk/include/gb/gb.h:610: shadow_OAM[nb].tile=tile; 
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), c
;enemies.c:243: set_sprite_tile(16 + i, 0x60 + enemie_animation_b);	
	ld	a, (#_enemie_animation_b)
	add	a, #0x60
	ld	c, a
	ld	a, (#_i)
	add	a, #0x10
	ld	e, a
;c:/gbdk/include/gb/gb.h:610: shadow_OAM[nb].tile=tile; 
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), c
;enemies.c:246: break;
	jr	00127$
;enemies.c:252: default:					
00106$:
;enemies.c:253: enemie_animation_a = enemie_animation_a ? 0 : 4;
	ld	a, (#_enemie_animation_a)
	or	a, a
	jr	Z, 00132$
	ld	bc, #0x0000
	jr	00133$
00132$:
	ld	bc, #0x0004
00133$:
	ld	hl, #_enemie_animation_a
	ld	(hl), c
;enemies.c:254: if(enemies_direction[i]){
	pop	de
	push	de
	ld	a, (de)
	ld	c, a
;enemies.c:255: set_sprite_tile(16 + i, 0x56 + enemie_animation_a);
	ld	a, (hl)
	add	a, #0x56
	ld	e, a
;enemies.c:254: if(enemies_direction[i]){
	ld	a, c
	or	a, a
	jr	Z, 00108$
;enemies.c:255: set_sprite_tile(16 + i, 0x56 + enemie_animation_a);
	ldhl	sp,	#2
	ld	c, (hl)
;c:/gbdk/include/gb/gb.h:610: shadow_OAM[nb].tile=tile; 
	ld	h, #0x00
	ld	l, c
	add	hl, hl
	add	hl, hl
	ld	bc, #_shadow_OAM
	add	hl, bc
	inc	hl
	inc	hl
	ld	(hl), e
;enemies.c:256: set_sprite_tile(28 + i, 0x58 + enemie_animation_a);
	ld	a, (#_enemie_animation_a)
	add	a, #0x58
	ld	c, a
	ld	a, (#_i)
	add	a, #0x1c
	ld	b, a
;c:/gbdk/include/gb/gb.h:610: shadow_OAM[nb].tile=tile; 
	ld	de, #_shadow_OAM+0
	ld	h, #0x00
	ld	l, b
	add	hl, hl
	add	hl, hl
	add	hl, de
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	a, c
	ld	(de), a
;enemies.c:256: set_sprite_tile(28 + i, 0x58 + enemie_animation_a);
	jr	00127$
00108$:
;enemies.c:258: set_sprite_tile(28 + i, 0x56 + enemie_animation_a);
	ldhl	sp,	#3
	ld	c, (hl)
;c:/gbdk/include/gb/gb.h:610: shadow_OAM[nb].tile=tile; 
	ld	h, #0x00
	ld	l, c
	add	hl, hl
	add	hl, hl
	ld	bc, #_shadow_OAM
	add	hl, bc
	inc	hl
	inc	hl
	ld	(hl), e
;enemies.c:259: set_sprite_tile(16 + i, 0x58 + enemie_animation_a);
	ld	a, (#_enemie_animation_a)
	add	a, #0x58
	ld	c, a
	ld	a, (#_i)
	add	a, #0x10
	ld	b, a
;c:/gbdk/include/gb/gb.h:610: shadow_OAM[nb].tile=tile; 
	ld	de, #_shadow_OAM+0
	ld	h, #0x00
	ld	l, b
	add	hl, hl
	add	hl, hl
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), c
;enemies.c:262: }
00127$:
;enemies.c:231: for(i = 0; i < max_enemies_on_creen; i +=1){
	ld	hl, #_i
	inc	(hl)
	jp	00126$
00115$:
;enemies.c:266: enemie_delay+= 1u;
	ld	hl, #_enemie_delay
	inc	(hl)
00128$:
;enemies.c:268: }	
	add	sp, #6
	ret
;enemies.c:270: void newEnemie(){  
;	---------------------------------
; Function newEnemie
; ---------------------------------
_newEnemie::
	add	sp, #-4
;enemies.c:273: for( i = 0; i != max_enemies_on_creen; i+=1u){
	ld	hl, #_i
	ld	(hl), #0x00
00147$:
	ld	a, (#_i)
	ld	hl, #_max_enemies_on_creen
	sub	a, (hl)
	jp	Z,00149$
;enemies.c:274: if( !enemies_active[i]){
	ld	a, #<(_enemies_active)
	ld	hl, #_i
	add	a, (hl)
	ld	c, a
	ld	a, #>(_enemies_active)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	or	a, a
	jp	NZ, 00148$
;enemies.c:276: random_number = rand();
	call	_rand
	ld	hl, #_random_number
	ld	(hl), e
;enemies.c:277: enemies_type[i] =  random_number >> 6; //0 - 3 
	ld	bc, #_enemies_type+0
	ld	a, c
	ld	hl, #_i
	add	a, (hl)
	ld	e, a
	ld	a, b
	adc	a, #0x00
	ld	d, a
	ld	a, (#_random_number)
	rlca
	rlca
	and	a, #0x03
	ld	(de), a
;enemies.c:278: random_number = rand();
	push	bc
	call	_rand
	pop	bc
	ld	hl, #_random_number
	ld	(hl), e
;enemies.c:279: enemies_direction[i] = random_number >> 7; // 0- 1*/
	ld	a, #<(_enemies_direction)
	ld	hl, #_i
	add	a, (hl)
	ld	e, a
	ld	a, #>(_enemies_direction)
	adc	a, #0x00
	ld	d, a
	ld	a, (#_random_number)
	rlca
	and	a, #0x01
	ld	(de), a
;enemies.c:281: switch(enemies_type[i]){		     	
	ld	a, c
	ld	hl, #_i
	add	a, (hl)
	ld	c, a
	jr	NC, 00217$
	inc	b
00217$:
	ld	a, (bc)
	ldhl	sp,	#3
	ld	(hl), a
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00101$
	ldhl	sp,	#3
	ld	a, (hl)
	sub	a, #0x03
	jp	Z,00105$
	jp	00112$
;enemies.c:283: case 2 : //fish
00101$:
;enemies.c:284: enemies_y[i] = 7;
	ld	de, #_enemies_y
	ld	hl, #_i
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	a, l
	ld	d, h
	ldhl	sp,	#2
	ld	(hl+), a
	ld	(hl), d
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	(hl), #0x07
;enemies.c:285: enemies_jumps[i] = 0;
	ld	de, #_enemies_jumps
	ld	hl, #_i
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	a, l
	ld	d, h
	ldhl	sp,	#2
	ld	(hl+), a
	ld	(hl), d
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	(hl), #0x00
;enemies.c:286: last_row = enemies_y[i];			     	
	ld	de, #_enemies_y
	ld	hl, #_i
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	a, l
	ld	d, h
	ldhl	sp,	#1
	ld	(hl+), a
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	(#_last_row),a
;enemies.c:287: enemies_y[i] = enemies_y[i] << 4;
	ldhl	sp,#1
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	inc	hl
	ld	(hl), a
	ld	a, (hl)
	swap	a
	and	a, #0xf0
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (hl)
	ld	(de), a
;enemies.c:289: if(enemies_direction[i]){
	ld	de, #_enemies_direction
	ld	hl, #_i
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	a, l
	ld	d, h
	ldhl	sp,	#2
	ld	(hl+), a
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jp	Z, 00103$
;enemies.c:290: enemies_x[i] = 0;	
	ld	de, #_enemies_x
	ld	hl, #_i
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	a, l
	ld	d, h
	ldhl	sp,	#2
	ld	(hl+), a
	ld	(hl), d
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	(hl), #0x00
;enemies.c:291: set_sprite_tile(16 + i, 0x5E );
	ld	a, (#_i)
	ldhl	sp,	#3
	ld	(hl), a
	ld	a, (hl)
	add	a, #0x10
	ld	(hl), a
;c:/gbdk/include/gb/gb.h:610: shadow_OAM[nb].tile=tile; 
	ld	a, (hl-)
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl)
	ld	(hl+), a
	ld	a, (hl)
	ld	(hl), a
	ld	a, #0x02
00220$:
	dec	hl
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00220$
	ld	de, #_shadow_OAM
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	hl, #0x0002
	add	hl, de
	ld	a, l
	ld	d, h
	ldhl	sp,	#2
	ld	(hl+), a
	ld	(hl), d
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	(hl), #0x5e
;enemies.c:292: set_sprite_tile(28 + i, 0x60 );
	ld	a, (#_i)
	add	a, #0x1c
	ldhl	sp,	#3
	ld	(hl), a
;c:/gbdk/include/gb/gb.h:610: shadow_OAM[nb].tile=tile; 
	ld	a, (hl-)
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl)
	ld	(hl+), a
	ld	a, (hl)
	ld	(hl), a
	ld	a, #0x02
00221$:
	dec	hl
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00221$
	ld	de, #_shadow_OAM
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	hl, #0x0002
	add	hl, de
	ld	a, l
	ld	d, h
	ldhl	sp,	#2
	ld	(hl+), a
	ld	(hl), d
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	(hl), #0x60
;enemies.c:293: set_sprite_prop(16 + i , 0x00);
	ld	a, (#_i)
	add	a, #0x10
	ldhl	sp,	#3
	ld	(hl), a
;c:/gbdk/include/gb/gb.h:638: shadow_OAM[nb].prop=prop;
	ld	a, (hl-)
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl)
	ld	(hl+), a
	ld	a, (hl)
	ld	(hl), a
	ld	a, #0x02
00222$:
	dec	hl
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00222$
	ld	de, #_shadow_OAM
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	hl, #0x0003
	add	hl, de
	ld	a, l
	ld	d, h
	ldhl	sp,	#2
	ld	(hl+), a
	ld	(hl), d
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	(hl), #0x00
;enemies.c:294: set_sprite_prop(28 + i , 0x00);
	ld	a, (#_i)
	add	a, #0x1c
	ldhl	sp,	#3
	ld	(hl), a
;c:/gbdk/include/gb/gb.h:638: shadow_OAM[nb].prop=prop;
	ld	a, (hl-)
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl)
	ld	(hl+), a
	ld	a, (hl)
	ld	(hl), a
	ld	a, #0x02
00223$:
	dec	hl
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00223$
	ld	de, #_shadow_OAM
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	hl, #0x0003
	add	hl, de
	ld	a, l
	ld	d, h
	ldhl	sp,	#2
	ld	(hl+), a
	ld	(hl), d
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	(hl), #0x00
;enemies.c:294: set_sprite_prop(28 + i , 0x00);
	jp	00122$
00103$:
;enemies.c:296: enemies_x[i] = 168;
	ld	bc, #_enemies_x+0
	ld	a, c
	ld	hl, #_i
	add	a, (hl)
	ld	c, a
	jr	NC, 00224$
	inc	b
00224$:
	ld	a, #0xa8
	ld	(bc), a
;enemies.c:297: set_sprite_tile(28 + i, 0x5E );
	ld	a, (hl)
	add	a, #0x1c
	ldhl	sp,	#3
	ld	(hl), a
;c:/gbdk/include/gb/gb.h:610: shadow_OAM[nb].tile=tile; 
	ld	a, (hl-)
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl)
	ld	(hl+), a
	ld	a, (hl)
	ld	(hl), a
	ld	a, #0x02
00225$:
	dec	hl
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00225$
	ld	de, #_shadow_OAM
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	hl, #0x0002
	add	hl, de
	ld	a, l
	ld	d, h
	ldhl	sp,	#2
	ld	(hl+), a
	ld	(hl), d
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	(hl), #0x5e
;enemies.c:298: set_sprite_tile(16 + i, 0x60 );
	ld	a, (#_i)
	add	a, #0x10
	ldhl	sp,	#3
	ld	(hl), a
;c:/gbdk/include/gb/gb.h:610: shadow_OAM[nb].tile=tile; 
	ld	a, (hl-)
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl)
	ld	(hl+), a
	ld	a, (hl)
	ld	(hl), a
	ld	a, #0x02
00226$:
	dec	hl
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00226$
	ld	de, #_shadow_OAM
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	hl, #0x0002
	add	hl, de
	ld	a, l
	ld	d, h
	ldhl	sp,	#2
	ld	(hl+), a
	ld	(hl), d
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	(hl), #0x60
;enemies.c:299: set_sprite_prop(16 + i, 0x20);
	ld	a, (#_i)
	add	a, #0x10
	ldhl	sp,	#3
	ld	(hl), a
;c:/gbdk/include/gb/gb.h:638: shadow_OAM[nb].prop=prop;
	ld	a, (hl-)
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl)
	ld	(hl+), a
	ld	a, (hl)
	ld	(hl), a
	ld	a, #0x02
00227$:
	dec	hl
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00227$
	ld	de, #_shadow_OAM
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	hl, #0x0003
	add	hl, de
	ld	a, l
	ld	d, h
	ldhl	sp,	#2
	ld	(hl+), a
	ld	(hl), d
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	(hl), #0x20
;enemies.c:300: set_sprite_prop(28 + i, 0x20);
	ld	a, (#_i)
	add	a, #0x1c
	ldhl	sp,	#3
	ld	(hl), a
;c:/gbdk/include/gb/gb.h:638: shadow_OAM[nb].prop=prop;
	ld	a, (hl-)
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl)
	ld	(hl+), a
	ld	a, (hl)
	ld	(hl), a
	ld	a, #0x02
00228$:
	dec	hl
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00228$
	ld	de, #_shadow_OAM
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	hl, #0x0003
	add	hl, de
	ld	a, l
	ld	d, h
	ldhl	sp,	#2
	ld	(hl+), a
	ld	(hl), d
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	(hl), #0x20
;enemies.c:302: break;
	jp	00122$
;enemies.c:304: case 3: //star
00105$:
;enemies.c:305: enemies_x[i] = random_number >> 4; // 0 - 8
	ld	a, #<(_enemies_x)
	ld	hl, #_i
	add	a, (hl)
	ld	c, a
	ld	a, #>(_enemies_x)
	adc	a, #0x00
	ld	b, a
	ld	a, (#_random_number)
	swap	a
	and	a, #0x0f
	ld	(bc), a
;enemies.c:306: if (last_row == enemies_x[i]){
	ld	a, #<(_enemies_x)
	ld	hl, #_i
	add	a, (hl)
	ld	c, a
	ld	a, #>(_enemies_x)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	ld	e, a
	ld	a, (#_last_row)
	sub	a, e
	jr	NZ, 00107$
;enemies.c:307: enemies_x[i]+=1;
	ld	a, e
	inc	a
	ld	(bc), a
00107$:
;enemies.c:310: if(enemies_x[i] == 0){
	ld	a, #<(_enemies_x)
	ld	hl, #_i
	add	a, (hl)
	ld	e, a
	ld	a, #>(_enemies_x)
	adc	a, #0x00
	ld	d, a
	ld	a, (de)
	or	a, a
	jr	NZ, 00109$
;enemies.c:311: enemies_x[i] = 1;
	ld	a, #0x01
	ld	(de), a
00109$:
;enemies.c:314: if(enemies_x[i] > 10){
	ld	a, #<(_enemies_x)
	ld	hl, #_i
	add	a, (hl)
	ld	c, a
	ld	a, #>(_enemies_x)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	ld	e, a
;enemies.c:315: enemies_x[i] = 10;
	ld	a,#0x0a
	cp	a,e
	jr	NC, 00111$
	ld	(bc), a
00111$:
;enemies.c:317: last_row = enemies_x[i];
	ld	a, #<(_enemies_x)
	ld	hl, #_i
	add	a, (hl)
	ld	c, a
	ld	a, #>(_enemies_x)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	ld	(#_last_row),a
;enemies.c:319: enemies_x[i] = enemies_x[i] << 4;		     	  	
	ld	a, (bc)
	swap	a
	and	a, #0xf0
	ld	(bc), a
;enemies.c:320: enemies_y[i] = 128;	
	ld	bc, #_enemies_y+0
	ld	a, c
	ld	hl, #_i
	add	a, (hl)
	ld	c, a
	jr	NC, 00231$
	inc	b
00231$:
	ld	a, #0x80
	ld	(bc), a
;enemies.c:321: set_sprite_tile(16 + i, 0x66 );
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl), a
	ld	a, (hl)
	add	a, #0x10
	ld	(hl), a
;c:/gbdk/include/gb/gb.h:610: shadow_OAM[nb].tile=tile; 
	ld	a, (hl-)
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl)
	ld	(hl+), a
	ld	a, (hl)
	ld	(hl), a
	ld	a, #0x02
00232$:
	dec	hl
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00232$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_shadow_OAM
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	hl, #0x0002
	add	hl, de
	ld	a, l
	ld	d, h
	ldhl	sp,	#2
	ld	(hl+), a
	ld	(hl), d
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	(hl), #0x66
;enemies.c:322: set_sprite_tile(28 + i, 0x68 );	
	ld	a, (#_i)
	ldhl	sp,	#3
	ld	(hl), a
	ld	a, (hl)
	add	a, #0x1c
	ld	(hl), a
;c:/gbdk/include/gb/gb.h:610: shadow_OAM[nb].tile=tile; 
	ld	a, (hl-)
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl)
	ld	(hl+), a
	ld	a, (hl)
	ld	(hl), a
	ld	a, #0x02
00233$:
	dec	hl
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00233$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_shadow_OAM
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	hl, #0x0002
	add	hl, de
	ld	a, l
	ld	d, h
	ldhl	sp,	#2
	ld	(hl+), a
	ld	(hl), d
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	(hl), #0x68
;enemies.c:323: set_sprite_prop(16 + i , 0x00);
	ld	a, (#_i)
	ldhl	sp,	#3
	ld	(hl), a
	ld	a, (hl)
	add	a, #0x10
	ld	(hl), a
;c:/gbdk/include/gb/gb.h:638: shadow_OAM[nb].prop=prop;
	ld	a, (hl-)
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl)
	ld	(hl+), a
	ld	a, (hl)
	ld	(hl), a
	ld	a, #0x02
00234$:
	dec	hl
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00234$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_shadow_OAM
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	hl, #0x0003
	add	hl, de
	ld	a, l
	ld	d, h
	ldhl	sp,	#2
	ld	(hl+), a
	ld	(hl), d
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	(hl), #0x00
;enemies.c:324: set_sprite_prop(28 + i , 0x00);		     		
	ld	a, (#_i)
	ldhl	sp,	#3
	ld	(hl), a
	ld	a, (hl)
	add	a, #0x1c
	ld	(hl), a
;c:/gbdk/include/gb/gb.h:638: shadow_OAM[nb].prop=prop;
	ld	a, (hl-)
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl)
	ld	(hl+), a
	ld	a, (hl)
	ld	(hl), a
	ld	a, #0x02
00235$:
	dec	hl
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00235$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_shadow_OAM
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	hl, #0x0003
	add	hl, de
	ld	a, l
	ld	d, h
	ldhl	sp,	#2
	ld	(hl+), a
	ld	(hl), d
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	(hl), #0x00
;enemies.c:326: break;
	jp	00122$
;enemies.c:328: default :
00112$:
;enemies.c:330: enemies_y[i] = random_number >> 5; // 0 - 8
	ld	bc, #_enemies_y+0
	ld	a, c
	ld	hl, #_i
	add	a, (hl)
	ld	e, a
	ld	a, b
	adc	a, #0x00
	ld	d, a
	ld	a, (#_random_number)
	swap	a
	rrca
	and	a, #0x07
	ld	(de), a
;enemies.c:331: if (last_row == enemies_y[i]){
	ld	a, c
	ld	hl, #_i
	add	a, (hl)
	ld	e, a
	ld	a, b
	adc	a, #0x00
	ld	d, a
	ld	a, (de)
	ldhl	sp,	#3
	ld	(hl), a
	ld	a, (#_last_row)
	ldhl	sp,	#3
	sub	a, (hl)
	jr	NZ, 00114$
;enemies.c:332: enemies_y[i]+=1;
	ldhl	sp,	#3
	ld	a, (hl)
	inc	a
	ld	(de), a
00114$:
;enemies.c:335: if(enemies_y[i] == 0){
	ld	a, c
	ld	hl, #_i
	add	a, (hl)
	ld	e, a
	ld	a, b
	adc	a, #0x00
	ld	d, a
	ld	a, (de)
	or	a, a
	jr	NZ, 00116$
;enemies.c:336: enemies_y[i] = 1;
	ld	a, #0x01
	ld	(de), a
00116$:
;enemies.c:339: if(enemies_y[i] > 6){
	ld	a, c
	ld	hl, #_i
	add	a, (hl)
	ld	e, a
	ld	a, b
	adc	a, #0x00
	ld	d, a
	ld	a, (de)
	ld	l, a
;enemies.c:340: enemies_y[i] = 6;
	ld	a,#0x06
	cp	a,l
	jr	NC, 00118$
	ld	(de), a
00118$:
;enemies.c:342: last_row = enemies_y[i];
	ld	a, c
	ld	hl, #_i
	add	a, (hl)
	ld	c, a
	jr	NC, 00238$
	inc	b
00238$:
	ld	a, (bc)
	ld	(#_last_row),a
;enemies.c:345: enemies_y[i] = enemies_y[i] << 4;		     	
	ld	a, (bc)
	swap	a
	and	a, #0xf0
	ld	(bc), a
;enemies.c:347: if(enemies_direction[i]){
	ld	a, #<(_enemies_direction)
	ld	hl, #_i
	add	a, (hl)
	ld	c, a
	ld	a, #>(_enemies_direction)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	or	a, a
	jp	Z, 00120$
;enemies.c:348: enemies_x[i] = 0;	
	ld	a, #<(_enemies_x)
	add	a, (hl)
	ld	c, a
	ld	a, #>(_enemies_x)
	adc	a, #0x00
	ld	b, a
	xor	a, a
	ld	(bc), a
;enemies.c:349: set_sprite_tile(16 + i, 0x56 );
	ld	a, (hl)
	add	a, #0x10
	ld	c, a
;c:/gbdk/include/gb/gb.h:610: shadow_OAM[nb].tile=tile; 
	ldhl	sp,	#2
	ld	(hl), c
	xor	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl)
	ld	(hl+), a
	ld	a, (hl)
	ld	(hl), a
	ld	a, #0x02
00239$:
	dec	hl
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00239$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_shadow_OAM
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	hl, #0x0002
	add	hl, de
	ld	a, l
	ld	d, h
	ldhl	sp,	#2
	ld	(hl+), a
	ld	(hl), d
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	(hl), #0x56
;enemies.c:350: set_sprite_tile(28 + i, 0x58 );
	ld	a, (#_i)
	add	a, #0x1c
	ld	c, a
;c:/gbdk/include/gb/gb.h:610: shadow_OAM[nb].tile=tile; 
	ldhl	sp,	#2
	ld	(hl), c
	xor	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl)
	ld	(hl+), a
	ld	a, (hl)
	ld	(hl), a
	ld	a, #0x02
00240$:
	dec	hl
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00240$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_shadow_OAM
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	hl, #0x0002
	add	hl, de
	ld	a, l
	ld	d, h
	ldhl	sp,	#2
	ld	(hl+), a
	ld	(hl), d
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	(hl), #0x58
;enemies.c:351: set_sprite_prop(16 + i , 0x00);
	ld	a, (#_i)
	add	a, #0x10
	ld	c, a
;c:/gbdk/include/gb/gb.h:638: shadow_OAM[nb].prop=prop;
	ldhl	sp,	#2
	ld	(hl), c
	xor	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl)
	ld	(hl+), a
	ld	a, (hl)
	ld	(hl), a
	ld	a, #0x02
00241$:
	dec	hl
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00241$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_shadow_OAM
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	hl, #0x0003
	add	hl, de
	ld	a, l
	ld	d, h
	ldhl	sp,	#2
	ld	(hl+), a
	ld	(hl), d
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	(hl), #0x00
;enemies.c:352: set_sprite_prop(28 + i , 0x00);
	ld	a, (#_i)
	add	a, #0x1c
	ld	c, a
;c:/gbdk/include/gb/gb.h:638: shadow_OAM[nb].prop=prop;
	ldhl	sp,	#2
	ld	(hl), c
	xor	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl)
	ld	(hl+), a
	ld	a, (hl)
	ld	(hl), a
	ld	a, #0x02
00242$:
	dec	hl
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00242$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_shadow_OAM
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	hl, #0x0003
	add	hl, de
	ld	a, l
	ld	d, h
	ldhl	sp,	#2
	ld	(hl+), a
	ld	(hl), d
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	(hl), #0x00
;enemies.c:352: set_sprite_prop(28 + i , 0x00);
	jp	00122$
00120$:
;enemies.c:354: enemies_x[i] = 168;
	ld	a, #<(_enemies_x)
	ld	hl, #_i
	add	a, (hl)
	ld	c, a
	ld	a, #>(_enemies_x)
	adc	a, #0x00
	ld	b, a
	ld	a, #0xa8
	ld	(bc), a
;enemies.c:355: set_sprite_tile(16 + i, 0x58 );
	ld	a, (hl)
	add	a, #0x10
	ld	c, a
;c:/gbdk/include/gb/gb.h:610: shadow_OAM[nb].tile=tile; 
	ldhl	sp,	#2
	ld	(hl), c
	xor	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl)
	ld	(hl+), a
	ld	a, (hl)
	ld	(hl), a
	ld	a, #0x02
00243$:
	dec	hl
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00243$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_shadow_OAM
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	hl, #0x0002
	add	hl, de
	ld	a, l
	ld	d, h
	ldhl	sp,	#2
	ld	(hl+), a
	ld	(hl), d
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	(hl), #0x58
;enemies.c:356: set_sprite_tile(28 + i, 0x56 );			     					     		
	ld	a, (#_i)
	add	a, #0x1c
	ld	c, a
;c:/gbdk/include/gb/gb.h:610: shadow_OAM[nb].tile=tile; 
	ldhl	sp,	#2
	ld	(hl), c
	xor	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl)
	ld	(hl+), a
	ld	a, (hl)
	ld	(hl), a
	ld	a, #0x02
00244$:
	dec	hl
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00244$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_shadow_OAM
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	hl, #0x0002
	add	hl, de
	ld	a, l
	ld	d, h
	ldhl	sp,	#2
	ld	(hl+), a
	ld	(hl), d
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	(hl), #0x56
;enemies.c:357: set_sprite_prop(16 + i, 0x20);
	ld	a, (#_i)
	add	a, #0x10
	ld	c, a
;c:/gbdk/include/gb/gb.h:638: shadow_OAM[nb].prop=prop;
	ldhl	sp,	#2
	ld	(hl), c
	xor	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl)
	ld	(hl+), a
	ld	a, (hl)
	ld	(hl), a
	ld	a, #0x02
00245$:
	dec	hl
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00245$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_shadow_OAM
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	hl, #0x0003
	add	hl, de
	ld	a, l
	ld	d, h
	ldhl	sp,	#2
	ld	(hl+), a
	ld	(hl), d
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	(hl), #0x20
;enemies.c:358: set_sprite_prop(28 + i, 0x20);
	ld	a, (#_i)
	add	a, #0x1c
	ld	c, a
;c:/gbdk/include/gb/gb.h:638: shadow_OAM[nb].prop=prop;
	ldhl	sp,	#2
	ld	(hl), c
	xor	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl)
	ld	(hl+), a
	ld	a, (hl)
	ld	(hl), a
	ld	a, #0x02
00246$:
	dec	hl
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00246$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_shadow_OAM
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	hl, #0x0003
	add	hl, de
	ld	a, l
	ld	d, h
	ldhl	sp,	#2
	ld	(hl+), a
	ld	(hl), d
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	(hl), #0x20
;enemies.c:362: }	
00122$:
;enemies.c:364: enemies_active[i] = 1;
	ld	a, #<(_enemies_active)
	ld	hl, #_i
	add	a, (hl)
	ld	c, a
	ld	a, #>(_enemies_active)
	adc	a, #0x00
	ld	b, a
	ld	a, #0x01
	ld	(bc), a
;enemies.c:365: used_enemies+=1U;
	ld	hl, #_used_enemies
	inc	(hl)
;enemies.c:368: break;
	jr	00149$
00148$:
;enemies.c:273: for( i = 0; i != max_enemies_on_creen; i+=1u){
	ld	hl, #_i
	inc	(hl)
	jp	00147$
00149$:
;enemies.c:372: }
	add	sp, #4
	ret
;player.c:2: void drawPlayerlives(){
;	---------------------------------
; Function drawPlayerlives
; ---------------------------------
_drawPlayerlives::
;player.c:3: set_win_tiles(0, 0, 1U, 1U, &hub_no_element);
	ld	bc, #_hub_no_element+0
	push	bc
	ld	de, #0x0101
	push	de
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_win_tiles
	add	sp, #6
;player.c:4: set_win_tiles(1, 0, 1U, 1U, &hub_no_element);		
	push	bc
	ld	de, #0x0101
	push	de
	xor	a, a
	ld	d,a
	ld	e,#0x01
	push	de
	call	_set_win_tiles
	add	sp, #6
;player.c:5: set_win_tiles(2, 0, 1U, 1U, &hub_no_element);
	push	bc
	ld	de, #0x0101
	push	de
	xor	a, a
	ld	d,a
	ld	e,#0x02
	push	de
	call	_set_win_tiles
	add	sp, #6
;player.c:7: for(i = 0; i < player.lives; i+=1u){				
	ld	hl, #_i
	ld	(hl), #0x00
00103$:
	ld	hl, #(_player + 0x0007)
	ld	c, (hl)
	ld	a, (#_i)
	sub	a, c
	ret	NC
;player.c:8: set_win_tiles(i, 0, 1U, 1U, &hub_live);
	ld	hl, #_hub_live
	push	hl
	ld	de, #0x0101
	push	de
	xor	a, a
	push	af
	inc	sp
	ld	a, (#_i)
	push	af
	inc	sp
	call	_set_win_tiles
	add	sp, #6
;player.c:7: for(i = 0; i < player.lives; i+=1u){				
	ld	hl, #_i
	inc	(hl)
;player.c:10: }
	jr	00103$
;player.c:12: void initPlayer(){
;	---------------------------------
; Function initPlayer
; ---------------------------------
_initPlayer::
;player.c:13: player.x = 0x58;
	ld	hl, #_player
	ld	(hl), #0x58
;player.c:14: player.y = 0x10;
	ld	hl, #(_player + 0x0001)
	ld	(hl), #0x10
;player.c:15: player.y_speed = 0x00;	
	ld	hl, #(_player + 0x0004)
	ld	(hl), #0x00
;player.c:16: player.sprite_hflip = 0x00;
	ld	hl, #(_player + 0x0009)
	ld	(hl), #0x00
;player.c:17: player.direction = 0x06;									
	ld	hl, #(_player + 0x0006)
	ld	(hl), #0x06
;player.c:18: player.lives-=1;
	ld	bc, #_player + 7
	ld	a, (bc)
	dec	a
	ld	(bc), a
;player.c:19: player.is_dying = 0x00;
	ld	hl, #(_player + 0x000b)
	ld	(hl), #0x00
;player.c:20: drawPlayerlives();	
;player.c:21: }
	jp  _drawPlayerlives
;player.c:23: void drawPlayer(){
;	---------------------------------
; Function drawPlayer
; ---------------------------------
_drawPlayer::
;player.c:24: if(player.sprite_hflip){
	ld	hl, #(_player + 0x0009)
	ld	c, (hl)
;player.c:25: set_sprite_tile(0, player.sprite_index + 10U);
	ld	a, (#(_player + 0x000a) + 0)
;player.c:24: if(player.sprite_hflip){
	inc	c
	dec	c
	jr	Z, 00102$
;player.c:25: set_sprite_tile(0, player.sprite_index + 10U);
	add	a, #0x0a
	ld	c, a
;c:/gbdk/include/gb/gb.h:610: shadow_OAM[nb].tile=tile; 
	ld	hl, #(_shadow_OAM + 0x0002)
	ld	(hl), c
;player.c:26: set_sprite_tile(1, player.sprite_index + 8U);	
	ld	a, (#(_player + 0x000a) + 0)
	add	a, #0x08
	ld	c, a
;c:/gbdk/include/gb/gb.h:610: shadow_OAM[nb].tile=tile; 
	ld	hl, #(_shadow_OAM + 0x0006)
	ld	(hl), c
;player.c:27: set_sprite_tile(2, player.sprite_index + 14U);
	ld	a, (#(_player + 0x000a) + 0)
	add	a, #0x0e
	ld	c, a
;c:/gbdk/include/gb/gb.h:610: shadow_OAM[nb].tile=tile; 
	ld	hl, #(_shadow_OAM + 0x000a)
	ld	(hl), c
;player.c:28: set_sprite_tile(3, player.sprite_index + 12U);		
	ld	a, (#(_player + 0x000a) + 0)
	add	a, #0x0c
	ld	c, a
;c:/gbdk/include/gb/gb.h:610: shadow_OAM[nb].tile=tile; 
	ld	hl, #(_shadow_OAM + 0x000e)
	ld	(hl), c
;player.c:29: set_sprite_tile(4, player.sprite_index + 2U);	
	ld	a, (#(_player + 0x000a) + 0)
	add	a, #0x02
	ld	c, a
;c:/gbdk/include/gb/gb.h:610: shadow_OAM[nb].tile=tile; 
	ld	hl, #(_shadow_OAM + 0x0012)
	ld	(hl), c
;player.c:30: set_sprite_tile(5, player.sprite_index);
	ld	hl, #(_player + 0x000a)
	ld	c, (hl)
;c:/gbdk/include/gb/gb.h:610: shadow_OAM[nb].tile=tile; 
	ld	hl, #(_shadow_OAM + 0x0016)
	ld	(hl), c
;player.c:31: set_sprite_tile(6, player.sprite_index + 6U);		
	ld	a, (#(_player + 0x000a) + 0)
	add	a, #0x06
	ld	c, a
;c:/gbdk/include/gb/gb.h:610: shadow_OAM[nb].tile=tile; 
	ld	hl, #(_shadow_OAM + 0x001a)
	ld	(hl), c
;player.c:32: set_sprite_tile(7, player.sprite_index + 4U);			
	ld	a, (#(_player + 0x000a) + 0)
	add	a, #0x04
	ld	c, a
;c:/gbdk/include/gb/gb.h:610: shadow_OAM[nb].tile=tile; 
	ld	hl, #(_shadow_OAM + 0x001e)
	ld	(hl), c
;player.c:32: set_sprite_tile(7, player.sprite_index + 4U);			
	jr	00103$
00102$:
;player.c:34: set_sprite_tile(0, player.sprite_index);
	ld	c, a
;c:/gbdk/include/gb/gb.h:610: shadow_OAM[nb].tile=tile; 
	ld	hl, #(_shadow_OAM + 0x0002)
	ld	(hl), c
;player.c:35: set_sprite_tile(1, player.sprite_index + 2U);	
	ld	a, (#(_player + 0x000a) + 0)
	add	a, #0x02
	ld	c, a
;c:/gbdk/include/gb/gb.h:610: shadow_OAM[nb].tile=tile; 
	ld	hl, #(_shadow_OAM + 0x0006)
	ld	(hl), c
;player.c:36: set_sprite_tile(2, player.sprite_index + 4U);
	ld	a, (#(_player + 0x000a) + 0)
	add	a, #0x04
	ld	c, a
;c:/gbdk/include/gb/gb.h:610: shadow_OAM[nb].tile=tile; 
	ld	hl, #(_shadow_OAM + 0x000a)
	ld	(hl), c
;player.c:37: set_sprite_tile(3, player.sprite_index + 6U);		
	ld	a, (#(_player + 0x000a) + 0)
	add	a, #0x06
	ld	c, a
;c:/gbdk/include/gb/gb.h:610: shadow_OAM[nb].tile=tile; 
	ld	hl, #(_shadow_OAM + 0x000e)
	ld	(hl), c
;player.c:38: set_sprite_tile(4, player.sprite_index + 8U);	
	ld	a, (#(_player + 0x000a) + 0)
	add	a, #0x08
	ld	c, a
;c:/gbdk/include/gb/gb.h:610: shadow_OAM[nb].tile=tile; 
	ld	hl, #(_shadow_OAM + 0x0012)
	ld	(hl), c
;player.c:39: set_sprite_tile(5, player.sprite_index + 10U);
	ld	a, (#(_player + 0x000a) + 0)
	add	a, #0x0a
	ld	c, a
;c:/gbdk/include/gb/gb.h:610: shadow_OAM[nb].tile=tile; 
	ld	hl, #(_shadow_OAM + 0x0016)
	ld	(hl), c
;player.c:40: set_sprite_tile(6, player.sprite_index + 12U);		
	ld	a, (#(_player + 0x000a) + 0)
	add	a, #0x0c
	ld	c, a
;c:/gbdk/include/gb/gb.h:610: shadow_OAM[nb].tile=tile; 
	ld	hl, #(_shadow_OAM + 0x001a)
	ld	(hl), c
;player.c:41: set_sprite_tile(7, player.sprite_index + 14U);
	ld	a, (#(_player + 0x000a) + 0)
	add	a, #0x0e
	ld	c, a
;c:/gbdk/include/gb/gb.h:610: shadow_OAM[nb].tile=tile; 
	ld	hl, #(_shadow_OAM + 0x001e)
	ld	(hl), c
;player.c:41: set_sprite_tile(7, player.sprite_index + 14U);
00103$:
;player.c:43: set_sprite_prop(0, player.sprite_hflip);
	ld	hl, #(_player + 0x0009)
	ld	c, (hl)
;c:/gbdk/include/gb/gb.h:638: shadow_OAM[nb].prop=prop;
	ld	hl, #(_shadow_OAM + 0x0003)
	ld	(hl), c
;player.c:44: set_sprite_prop(1, player.sprite_hflip);
	ld	hl, #(_player + 0x0009)
	ld	c, (hl)
;c:/gbdk/include/gb/gb.h:638: shadow_OAM[nb].prop=prop;
	ld	hl, #(_shadow_OAM + 0x0007)
	ld	(hl), c
;player.c:45: set_sprite_prop(2, player.sprite_hflip);
	ld	hl, #(_player + 0x0009)
	ld	c, (hl)
;c:/gbdk/include/gb/gb.h:638: shadow_OAM[nb].prop=prop;
	ld	hl, #(_shadow_OAM + 0x000b)
	ld	(hl), c
;player.c:46: set_sprite_prop(3, player.sprite_hflip);
	ld	hl, #(_player + 0x0009)
	ld	c, (hl)
;c:/gbdk/include/gb/gb.h:638: shadow_OAM[nb].prop=prop;
	ld	hl, #(_shadow_OAM + 0x000f)
	ld	(hl), c
;player.c:47: set_sprite_prop(4, player.sprite_hflip);
	ld	hl, #(_player + 0x0009)
	ld	c, (hl)
;c:/gbdk/include/gb/gb.h:638: shadow_OAM[nb].prop=prop;
	ld	hl, #(_shadow_OAM + 0x0013)
	ld	(hl), c
;player.c:48: set_sprite_prop(5, player.sprite_hflip);
	ld	hl, #(_player + 0x0009)
	ld	c, (hl)
;c:/gbdk/include/gb/gb.h:638: shadow_OAM[nb].prop=prop;
	ld	hl, #(_shadow_OAM + 0x0017)
	ld	(hl), c
;player.c:49: set_sprite_prop(6, player.sprite_hflip);
	ld	hl, #(_player + 0x0009)
	ld	c, (hl)
;c:/gbdk/include/gb/gb.h:638: shadow_OAM[nb].prop=prop;
	ld	hl, #(_shadow_OAM + 0x001b)
	ld	(hl), c
;player.c:50: set_sprite_prop(7, player.sprite_hflip);
	ld	hl, #(_player + 0x0009)
	ld	c, (hl)
;c:/gbdk/include/gb/gb.h:638: shadow_OAM[nb].prop=prop;
	ld	hl, #(_shadow_OAM + 0x001f)
	ld	(hl), c
;player.c:50: set_sprite_prop(7, player.sprite_hflip);
;player.c:51: }
	ret
;player.c:54: void movePlayer(){
;	---------------------------------
; Function movePlayer
; ---------------------------------
_movePlayer::
	dec	sp
;player.c:55: move_sprite(0, player.x, player.y);
	ld	hl, #(_player + 0x0001)
	ld	b, (hl)
	ld	hl, #_player
	ld	c, (hl)
;c:/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;c:/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;player.c:56: move_sprite(1, player.x + 8u, player.y);
	ld	hl, #(_player + 0x0001)
	ld	b, (hl)
	ld	a, (#_player + 0)
	add	a, #0x08
	ld	c, a
;c:/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x0004)
;c:/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;player.c:57: move_sprite(4, player.x + 16u, player.y);
	ld	hl, #(_player + 0x0001)
	ld	b, (hl)
	ld	a, (#_player + 0)
	add	a, #0x10
	ld	c, a
;c:/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x0010)
;c:/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;player.c:58: move_sprite(5, player.x + 24u, player.y);
	ld	hl, #(_player + 0x0001)
	ld	b, (hl)
	ld	a, (#_player + 0)
	add	a, #0x18
	ld	c, a
;c:/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x0014)
;c:/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;player.c:60: player.height = player.y + 16u;
	ld	a, (#(_player + 0x0001) + 0)
	add	a, #0x10
	ld	b, a
	ld	hl, #(_player + 0x0002)
	ld	(hl), b
;player.c:61: move_sprite(2, player.x, player.height);
	ldhl	sp,	#0
	ld	(hl), b
	ld	hl, #_player
	ld	c, (hl)
;c:/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	de, #_shadow_OAM+8
;c:/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(de), a
	inc	de
	ld	a, c
	ld	(de), a
;player.c:62: move_sprite(3, player.x + 8u, player.height);
	ld	a, (#_player + 0)
	add	a, #0x08
	ld	c, a
;c:/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x000c)
;c:/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;player.c:63: move_sprite(6, player.x + 16u, player.height);
	ld	a, (#_player + 0)
	add	a, #0x10
	ld	c, a
;c:/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x0018)
;c:/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;player.c:64: move_sprite(7, player.x + 24u, player.height);
	ld	a, (#_player + 0)
	add	a, #0x18
	ld	c, a
;c:/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x001c)
;c:/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;player.c:64: move_sprite(7, player.x + 24u, player.height);
;player.c:65: }
	inc	sp
	ret
;player.c:67: void animatePlayer(){
;	---------------------------------
; Function animatePlayer
; ---------------------------------
_animatePlayer::
;player.c:68: if(player.delay > 9u){
	ld	hl, #(_player + 0x0003)
	ld	c, (hl)
	ld	a, #0x09
	sub	a, c
	jr	NC, 00104$
;player.c:69: player.delay = 0;
	ld	hl, #(_player + 0x0003)
	ld	(hl), #0x00
;player.c:70: if(!player.is_dying){
	ld	a, (#(_player + 0x000b) + 0)
	or	a, a
	ret	NZ
;player.c:71: player.sprite_index =  player.sprite_index ? 0 : 16u;
	ld	hl, #_player + 10
	ld	a, (hl)
	or	a, a
	jr	Z, 00108$
	ld	de, #0x0000
	jr	00109$
00108$:
	ld	de, #0x0010
00109$:
	ld	(hl), e
	ret
00104$:
;player.c:74: player.delay+= 1u;
	inc	c
	ld	hl, #(_player + 0x0003)
	ld	(hl), c
;player.c:76: }	
	ret
;player.c:80: void movePlayerToLeft(){
;	---------------------------------
; Function movePlayerToLeft
; ---------------------------------
_movePlayerToLeft::
;player.c:81: player.sprite_hflip= 0x20;
	ld	bc, #_player+0
	ld	hl, #(_player + 0x0009)
	ld	(hl), #0x20
;player.c:82: player.direction = 0x04;
	ld	hl, #(_player + 0x0006)
	ld	(hl), #0x04
;player.c:83: if(player.x != 8u){
	ld	a, (bc)
	cp	a, #0x08
	ret	Z
;player.c:84: player.x-= 0x02;	
	dec	a
	dec	a
	ld	(bc), a
;player.c:86: }
	ret
;player.c:88: void movePlayerToRight(){
;	---------------------------------
; Function movePlayerToRight
; ---------------------------------
_movePlayerToRight::
;player.c:89: player.sprite_hflip= 0x00;
	ld	bc, #_player+0
	ld	hl, #(_player + 0x0009)
	ld	(hl), #0x00
;player.c:90: player.direction = 0x06;				
	ld	hl, #(_player + 0x0006)
	ld	(hl), #0x06
;player.c:91: if(player.x != 136u){
	ld	a, (bc)
	cp	a, #0x88
	ret	Z
;player.c:92: player.x+= 0x02;	
	add	a, #0x02
	ld	(bc), a
;player.c:94: }
	ret
;player.c:97: void playerJump(){
;	---------------------------------
; Function playerJump
; ---------------------------------
_playerJump::
;player.c:98: if( player.y > 14u){	
	ld	hl, #_player + 1
	ld	c, (hl)
	ld	a, #0x0e
	sub	a, c
	ret	NC
;player.c:99: player.y_speed = player.jump_force;
	ld	bc, #_player + 4
	ld	a, (#(_player + 0x0005) + 0)
	ld	(bc), a
;player.c:101: }
	ret
;player.c:106: void updatePlayer(){
;	---------------------------------
; Function updatePlayer
; ---------------------------------
_updatePlayer::
;player.c:107: if(player.y_speed != 0x00){
	ld	de, #_player + 4
	ld	a, (de)
	or	a, a
	jr	Z, 00102$
;player.c:108: player.y_speed-= 0x01;
	dec	a
	ld	(de), a
00102$:
;player.c:111: player.y-= player.y_speed;				
	ld	bc, #_player + 1
	ld	a, (bc)
	push	af
	ld	a, (de)
	ld	e, a
	pop	af
	sub	a, e
	ld	(bc), a
;player.c:113: player.y+= GRAVITY;	
	inc	a
	ld	(bc), a
;player.c:117: drawPlayer();
	call	_drawPlayer
;player.c:118: movePlayer();
	call	_movePlayer
;player.c:119: animatePlayer();		
;player.c:120: }
	jp  _animatePlayer
;player.c:122: void playSoundJump(){
;	---------------------------------
; Function playSoundJump
; ---------------------------------
_playSoundJump::
;player.c:129: }
	ret
;game_states.c:3: void animateWater(){
;	---------------------------------
; Function animateWater
; ---------------------------------
_animateWater::
;game_states.c:4: if(water_delay > 9u){
	ld	a, #0x09
	ld	hl, #_water_delay
	sub	a, (hl)
	jp	NC, 00105$
;game_states.c:5: water_delay = 0;
	ld	(hl), #0x00
;game_states.c:7: if(water_animation < 512u){		
	ld	hl, #_water_animation + 1
	dec	hl
	ld	a, (hl+)
	ld	a, (hl)
	sub	a, #0x02
	jp	NC, 00102$
;game_states.c:10: memcpy( (void *)0x9580, &water[water_animation], SPRITE_LENGTH);
	ld	bc, #_water+0
	ld	a, c
	dec	hl
	add	a, (hl)
	ld	e, a
	ld	a, b
	inc	hl
	adc	a, (hl)
	ld	d, a
	push	bc
	ld	hl, #0x0010
	push	hl
	push	de
	ld	hl, #0x9580
	push	hl
	call	_memcpy
	add	sp, #6
	pop	bc
;game_states.c:11: memcpy( (void *)0x95A0, &water[(water_animation + 16u) ], SPRITE_LENGTH);
	ld	hl, #_water_animation + 1
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	add	hl, bc
	push	bc
	ld	de, #0x0010
	push	de
	push	hl
	ld	hl, #0x95a0
	push	hl
	call	_memcpy
	add	sp, #6
	pop	bc
;game_states.c:12: memcpy( (void *)0x9590, &water[(water_animation + 32u) ], SPRITE_LENGTH);
	ld	hl, #_water_animation + 1
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0020
	add	hl, de
	add	hl, bc
	push	bc
	ld	de, #0x0010
	push	de
	push	hl
	ld	hl, #0x9590
	push	hl
	call	_memcpy
	add	sp, #6
	pop	bc
;game_states.c:13: memcpy( (void *)0x95B0, &water[(water_animation + 48u) ], SPRITE_LENGTH);
	ld	hl, #_water_animation + 1
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0030
	add	hl, de
	add	hl, bc
	ld	de, #0x0010
	push	de
	push	hl
	ld	hl, #0x95b0
	push	hl
	call	_memcpy
	add	sp, #6
;game_states.c:15: water_animation+= 64u;			
	ld	hl, #_water_animation + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0040
	add	hl, bc
	ld	a, l
	ld	d, h
	ld	hl, #_water_animation
	ld	(hl+), a
	ld	(hl), d
	ret
00102$:
;game_states.c:17: water_animation = 0;
	ld	hl, #_water_animation
	ld	(hl), #0x00
	inc	hl
	ld	(hl), #0x00
;game_states.c:18: water_delay = 10u;
	ld	hl, #_water_delay
	ld	(hl), #0x0a
	ret
00105$:
;game_states.c:21: water_delay+= 1u;
	ld	hl, #_water_delay
	inc	(hl)
;game_states.c:23: }	
	ret
;game_states.c:33: void stateGameBoot() {	
;	---------------------------------
; Function stateGameBoot
; ---------------------------------
_stateGameBoot::
;game_states.c:34: disable_interrupts();
	call	_disable_interrupts
;game_states.c:35: SPRITES_8x16;        
	ldh	a, (_LCDC_REG+0)
	or	a, #0x04
	ldh	(_LCDC_REG+0),a
;game_states.c:36: enable_interrupts();	
	call	_enable_interrupts
;game_states.c:37: random_seed = DIV_REG;
	ldh	a, (_DIV_REG+0)
	ld	(#_random_seed),a
	xor	a, a
	ld	(_random_seed + 1), a
;game_states.c:38: GAMESTATE = GAMESTATE_LOGO;	
	ld	hl, #_GAMESTATE
	ld	(hl), #0x06
;game_states.c:39: }
	ret
;game_states.c:42: void stateGameLogo(){	
;	---------------------------------
; Function stateGameLogo
; ---------------------------------
_stateGameLogo::
;game_states.c:43: if(!frame_counter){	
	ld	hl, #_frame_counter + 1
	ld	a, (hl-)
	or	a, (hl)
	jr	NZ, 00102$
;game_states.c:44: HIDE_SPRITES;
	ldh	a, (_LCDC_REG+0)
	and	a, #0xfd
	ldh	(_LCDC_REG+0),a
;game_states.c:45: HIDE_WIN;
	ldh	a, (_LCDC_REG+0)
	and	a, #0xdf
	ldh	(_LCDC_REG+0),a
;game_states.c:46: HIDE_BKG;
	ldh	a, (_LCDC_REG+0)
	and	a, #0xfe
	ldh	(_LCDC_REG+0),a
;game_states.c:51: SHOW_BKG;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x01
	ldh	(_LCDC_REG+0),a
;game_states.c:52: SHOW_SPRITES;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x02
	ldh	(_LCDC_REG+0),a
00102$:
;game_states.c:55: if(frame_counter != 30u){
	ld	hl, #_frame_counter
	ld	a, (hl)
	sub	a, #0x1e
	inc	hl
	or	a, (hl)
	jr	Z, 00104$
;game_states.c:56: frame_counter+= 1u;
	ld	hl, #_frame_counter
	inc	(hl)
	ret	NZ
	inc	hl
	inc	(hl)
	ret
00104$:
;game_states.c:58: GAMESTATE = GAMESTATE_TITLE;	
	ld	hl, #_GAMESTATE
	ld	(hl), #0x02
;game_states.c:59: frame_counter = 0;		
	ld	hl, #_frame_counter
	ld	a, #0x00
	ld	(hl+), a
	ld	(hl), #0x00
;game_states.c:61: }
	ret
;game_states.c:66: void stateGameIntro(){
;	---------------------------------
; Function stateGameIntro
; ---------------------------------
_stateGameIntro::
;game_states.c:67: GAMESTATE = GAMESTATE_TITLE;
	ld	hl, #_GAMESTATE
	ld	(hl), #0x02
;game_states.c:68: frame_counter = 0;
	ld	hl, #_frame_counter
	ld	a, #0x00
	ld	(hl+), a
	ld	(hl), #0x00
;game_states.c:69: }
	ret
;game_states.c:72: void stateGameTitle(){
;	---------------------------------
; Function stateGameTitle
; ---------------------------------
_stateGameTitle::
;game_states.c:73: if(frame_counter == 0){
	ld	hl, #_frame_counter + 1
	ld	a, (hl-)
	or	a, (hl)
	jr	NZ, 00102$
;game_states.c:74: HIDE_BKG;
	ldh	a, (_LCDC_REG+0)
	and	a, #0xfe
	ldh	(_LCDC_REG+0),a
;game_states.c:75: HIDE_WIN;
	ldh	a, (_LCDC_REG+0)
	and	a, #0xdf
	ldh	(_LCDC_REG+0),a
;game_states.c:76: HIDE_SPRITES;
	ldh	a, (_LCDC_REG+0)
	and	a, #0xfd
	ldh	(_LCDC_REG+0),a
;game_states.c:80: SHOW_BKG;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x01
	ldh	(_LCDC_REG+0),a
;game_states.c:81: frame_counter = 1;
	ld	a, #0x01
	ld	(hl+), a
	ld	(hl), #0x00
00102$:
;game_states.c:86: if(joypad() & J_START){		
	call	_joypad
	ld	a, e
	rlca
	ret	NC
;game_states.c:88: GAMESTATE = GAMESTATE_LOAD_GAMEPLAY;
	ld	hl, #_GAMESTATE
	ld	(hl), #0x08
;game_states.c:89: frame_counter = 0;
	ld	hl, #_frame_counter
	ld	a, #0x00
	ld	(hl+), a
	ld	(hl), #0x00
;game_states.c:91: }
	ret
;game_states.c:93: void stateGameGameOver(){	
;	---------------------------------
; Function stateGameGameOver
; ---------------------------------
_stateGameGameOver::
;game_states.c:95: if( frame_counter == 0){
	ld	hl, #_frame_counter + 1
	ld	a, (hl-)
	or	a, (hl)
	jp	NZ, 00104$
;game_states.c:96: frame_counter = 1;
	ld	a, #0x01
	ld	(hl+), a
	ld	(hl), #0x00
;game_states.c:98: HIDE_WIN;
	ldh	a, (_LCDC_REG+0)
	and	a, #0xdf
	ldh	(_LCDC_REG+0),a
;game_states.c:99: HIDE_SPRITES;
	ldh	a, (_LCDC_REG+0)
	and	a, #0xfd
	ldh	(_LCDC_REG+0),a
;game_states.c:101: set_sprite_data(0, 28, game_over);
	ld	hl, #_game_over
	push	hl
	ld	a, #0x1c
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_sprite_data
	add	sp, #4
;c:/gbdk/include/gb/gb.h:610: shadow_OAM[nb].tile=tile; 
	ld	hl, #(_shadow_OAM + 0x0002)
	ld	(hl), #0x00
	ld	hl, #(_shadow_OAM + 0x0006)
	ld	(hl), #0x02
	ld	hl, #(_shadow_OAM + 0x000a)
	ld	(hl), #0x04
	ld	hl, #(_shadow_OAM + 0x000e)
	ld	(hl), #0x06
	ld	hl, #(_shadow_OAM + 0x0012)
	ld	(hl), #0x08
	ld	hl, #(_shadow_OAM + 0x0016)
	ld	(hl), #0x0a
	ld	hl, #(_shadow_OAM + 0x001a)
	ld	(hl), #0x06
	ld	hl, #(_shadow_OAM + 0x001e)
	ld	(hl), #0x0c
;c:/gbdk/include/gb/gb.h:638: shadow_OAM[nb].prop=prop;
	ld	hl, #(_shadow_OAM + 0x0003)
	ld	(hl), #0x00
	ld	hl, #(_shadow_OAM + 0x0007)
	ld	(hl), #0x00
	ld	hl, #(_shadow_OAM + 0x000b)
	ld	(hl), #0x00
	ld	hl, #(_shadow_OAM + 0x000f)
	ld	(hl), #0x00
	ld	hl, #(_shadow_OAM + 0x0013)
	ld	(hl), #0x00
	ld	hl, #(_shadow_OAM + 0x0017)
	ld	(hl), #0x00
	ld	hl, #(_shadow_OAM + 0x001b)
	ld	(hl), #0x00
	ld	hl, #(_shadow_OAM + 0x001f)
	ld	(hl), #0x00
;c:/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;c:/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	ld	a, #0x30
	ld	(hl+), a
	ld	(hl), #0x38
;c:/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x0004)
;c:/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	ld	a, #0x30
	ld	(hl+), a
	ld	(hl), #0x40
;c:/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x0008)
;c:/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	ld	a, #0x30
	ld	(hl+), a
	ld	(hl), #0x48
;c:/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x000c)
;c:/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	ld	a, #0x30
	ld	(hl+), a
	ld	(hl), #0x50
;c:/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x0010)
;c:/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	ld	a, #0x30
	ld	(hl+), a
	ld	(hl), #0x5c
;c:/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x0014)
;c:/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	ld	a, #0x30
	ld	(hl+), a
	ld	(hl), #0x64
;c:/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x0018)
;c:/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	ld	a, #0x30
	ld	(hl+), a
	ld	(hl), #0x6c
;c:/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x001c)
;c:/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	ld	a, #0x30
	ld	(hl+), a
	ld	(hl), #0x74
;game_states.c:131: if (score > hi_score){		
	ld	de, #_hi_score
	ld	hl, #_score
	ld	a, (de)
	sub	a, (hl)
	inc	hl
	inc	de
	ld	a, (de)
	sbc	a, (hl)
	jp	NC, 00102$
;c:/gbdk/include/gb/gb.h:610: shadow_OAM[nb].tile=tile; 
	ld	hl, #(_shadow_OAM + 0x0022)
	ld	(hl), #0x16
	ld	hl, #(_shadow_OAM + 0x0026)
	ld	(hl), #0x06
	ld	hl, #(_shadow_OAM + 0x002a)
	ld	(hl), #0x18
	ld	hl, #(_shadow_OAM + 0x002e)
	ld	(hl), #0x12
	ld	hl, #(_shadow_OAM + 0x0032)
	ld	(hl), #0x14
	ld	hl, #(_shadow_OAM + 0x0036)
	ld	(hl), #0x08
	ld	hl, #(_shadow_OAM + 0x003a)
	ld	(hl), #0x0c
	ld	hl, #(_shadow_OAM + 0x003e)
	ld	(hl), #0x06
	ld	hl, #(_shadow_OAM + 0x0042)
	ld	(hl), #0x1a
	ld	(hl), #0x1a
;c:/gbdk/include/gb/gb.h:638: shadow_OAM[nb].prop=prop;
	ld	hl, #(_shadow_OAM + 0x0023)
	ld	(hl), #0x00
	ld	hl, #(_shadow_OAM + 0x0027)
	ld	(hl), #0x00
	ld	hl, #(_shadow_OAM + 0x002b)
	ld	(hl), #0x00
	ld	hl, #(_shadow_OAM + 0x002f)
	ld	(hl), #0x00
	ld	hl, #(_shadow_OAM + 0x0033)
	ld	(hl), #0x00
	ld	hl, #(_shadow_OAM + 0x0037)
	ld	(hl), #0x00
	ld	hl, #(_shadow_OAM + 0x003b)
	ld	(hl), #0x00
	ld	hl, #(_shadow_OAM + 0x003f)
	ld	(hl), #0x00
	ld	hl, #(_shadow_OAM + 0x0043)
	ld	(hl), #0x00
;c:/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x0020)
;c:/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	ld	a, #0x40
	ld	(hl+), a
	ld	(hl), #0x38
;c:/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x0024)
;c:/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	ld	a, #0x40
	ld	(hl+), a
	ld	(hl), #0x40
;c:/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x0028)
;c:/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	ld	a, #0x40
	ld	(hl+), a
	ld	(hl), #0x48
;c:/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x002c)
;c:/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	ld	a, #0x40
	ld	(hl+), a
	ld	(hl), #0x54
;c:/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x0030)
;c:/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	ld	a, #0x40
	ld	(hl+), a
	ld	(hl), #0x5c
;c:/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x0034)
;c:/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	ld	a, #0x40
	ld	(hl+), a
	ld	(hl), #0x64
;c:/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x0038)
;c:/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	ld	a, #0x40
	ld	(hl+), a
	ld	(hl), #0x6c
;c:/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x003c)
;c:/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	ld	a, #0x40
	ld	(hl+), a
	ld	(hl), #0x74
;c:/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x0040)
;c:/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	ld	a, #0x40
	ld	(hl+), a
	ld	(hl), #0x7c
;game_states.c:164: move_sprite(16, 124, 64);			
00102$:
;game_states.c:167: SHOW_SPRITES;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x02
	ldh	(_LCDC_REG+0),a
;game_states.c:168: SHOW_WIN;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x20
	ldh	(_LCDC_REG+0),a
00104$:
;game_states.c:171: animateWater();	
	call	_animateWater
;game_states.c:173: if(joypad() & J_START){		
	call	_joypad
	ld	a, e
	rlca
	ret	NC
;c:/gbdk/include/gb/gb.h:610: shadow_OAM[nb].tile=tile; 
	ld	hl, #(_shadow_OAM + 0x002e)
	ld	(hl), #0x72
	ld	hl, #(_shadow_OAM + 0x0032)
	ld	(hl), #0x72
	ld	hl, #(_shadow_OAM + 0x0036)
	ld	(hl), #0x72
	ld	hl, #(_shadow_OAM + 0x003a)
	ld	(hl), #0x72
	ld	hl, #(_shadow_OAM + 0x003e)
	ld	(hl), #0x72
	ld	hl, #(_shadow_OAM + 0x0042)
	ld	(hl), #0x72
;c:/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM+44
;c:/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	xor	a, a
	ld	(bc), a
	inc	bc
	xor	a, a
	ld	(bc), a
;c:/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM+48
;c:/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	xor	a, a
	ld	(bc), a
	inc	bc
	xor	a, a
	ld	(bc), a
;c:/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM+52
;c:/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	xor	a, a
	ld	(bc), a
	inc	bc
	xor	a, a
	ld	(bc), a
;c:/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM+56
;c:/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	xor	a, a
	ld	(bc), a
	inc	bc
	xor	a, a
	ld	(bc), a
;c:/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM+60
;c:/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	xor	a, a
	ld	(bc), a
	inc	bc
	xor	a, a
	ld	(bc), a
;c:/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM+64
;c:/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	xor	a, a
	ld	(bc), a
	inc	bc
	xor	a, a
	ld	(bc), a
;game_states.c:187: GAMESTATE = GAMESTATE_LOAD_GAMEPLAY;
	ld	hl, #_GAMESTATE
	ld	(hl), #0x08
;game_states.c:188: frame_counter = 0;
	ld	hl, #_frame_counter
	ld	a, #0x00
	ld	(hl+), a
	ld	(hl), #0x00
;game_states.c:191: }
	ret
;game_states.c:193: void stateGameLoadGameplay(){
;	---------------------------------
; Function stateGameLoadGameplay
; ---------------------------------
_stateGameLoadGameplay::
;game_states.c:195: if(!frame_counter){
	ld	hl, #_frame_counter + 1
	ld	a, (hl-)
	or	a, (hl)
	jp	NZ, 00102$
;game_states.c:196: wait_vbl_done();
	call	_wait_vbl_done
;game_states.c:198: HIDE_BKG;
	ldh	a, (_LCDC_REG+0)
	and	a, #0xfe
	ldh	(_LCDC_REG+0),a
;game_states.c:199: HIDE_WIN;
	ldh	a, (_LCDC_REG+0)
	and	a, #0xdf
	ldh	(_LCDC_REG+0),a
;game_states.c:200: HIDE_SPRITES;
	ldh	a, (_LCDC_REG+0)
	and	a, #0xfd
	ldh	(_LCDC_REG+0),a
;game_states.c:202: set_bkg_data(0, background_tile_count, background_tile_data);
	ld	de, #_background_tile_data+0
	ld	hl, #_background_tile_count
	ld	a, (hl+)
	ld	b, a
	ld	c, (hl)
	push	de
	push	bc
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_data
	add	sp, #4
;game_states.c:203: set_win_data(0x5C, 19, hub); //hub
	ld	hl, #_hub
	push	hl
	ld	de, #0x135c
	push	de
	call	_set_win_data
	add	sp, #4
;game_states.c:204: set_bkg_tiles(0, 0, 20, 18, background_map_data);
	ld	hl, #_background_map_data
	push	hl
	ld	de, #0x1214
	push	de
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;game_states.c:205: set_win_tiles(0, 0, 20, 1, hub_map);
	ld	hl, #_hub_map
	push	hl
	ld	de, #0x0114
	push	de
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_win_tiles
	add	sp, #6
;game_states.c:206: set_sprite_data(0, 80, player_sprites);
	ld	hl, #_player_sprites
	push	hl
	ld	a, #0x50
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_sprite_data
	add	sp, #4
;game_states.c:207: set_sprite_data(80, 2, bubble_sprites);
	ld	hl, #_bubble_sprites
	push	hl
	ld	de, #0x0250
	push	de
	call	_set_sprite_data
	add	sp, #4
;game_states.c:208: set_sprite_data(82, 32, enemies_sprites);
	ld	hl, #_enemies_sprites
	push	hl
	ld	de, #0x2052
	push	de
	call	_set_sprite_data
	add	sp, #4
;c:/gbdk/include/gb/gb.h:564: WX_REG=x, WY_REG=y;
	ld	a, #0x07
	ldh	(_WX_REG+0),a
	ld	a, #0x88
	ldh	(_WY_REG+0),a
;game_states.c:211: OBP0_REG = 0xC4; //11 00 01 00
	ld	a, #0xc4
	ldh	(_OBP0_REG+0),a
;game_states.c:220: player.lives = 3u;
	ld	hl, #(_player + 0x0007)
	ld	(hl), #0x03
;game_states.c:222: player.jump_force = 0x06;	
	ld	hl, #(_player + 0x0005)
	ld	(hl), #0x06
;game_states.c:224: player.x = 0x58;
	ld	hl, #_player
	ld	(hl), #0x58
;game_states.c:225: player.y = 0x10;
	ld	hl, #(_player + 0x0001)
	ld	(hl), #0x10
;game_states.c:226: player.y_speed = 0x00;
	ld	hl, #(_player + 0x0004)
	ld	(hl), #0x00
;game_states.c:228: player.sprite_hflip = 0x00;
	ld	hl, #(_player + 0x0009)
	ld	(hl), #0x00
;game_states.c:229: fx_jump_finished = 0x01;
	ld	hl, #_fx_jump_finished
	ld	(hl), #0x01
;game_states.c:230: player.direction = 0x06;
	ld	hl, #(_player + 0x0006)
	ld	(hl), #0x06
;game_states.c:232: score = 0u;
	ld	hl, #_score
	ld	a, #0x00
	ld	(hl+), a
	ld	(hl), #0x00
;game_states.c:234: max_enemies_on_creen = 2;
	ld	hl, #_max_enemies_on_creen
	ld	(hl), #0x02
;game_states.c:237: enemies_speed = 1;
	ld	hl, #_enemies_speed
	ld	(hl), #0x01
;game_states.c:239: random_seed |= (UWORD)DIV_REG << 8;
	ldh	a, (_DIV_REG+0)
	ld	b, a
	ld	c, #0x00
	ld	hl, #_random_seed
	ld	a, (hl)
	or	a, c
	ld	(hl+), a
	ld	a, (hl)
	or	a, b
;game_states.c:240: initrand(random_seed);
	ld	(hl-), a
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_initrand
	add	sp, #2
;game_states.c:242: drawPlayer();
	call	_drawPlayer
;game_states.c:243: movePlayer();
	call	_movePlayer
;game_states.c:244: initBubbles();
	call	_initBubbles
;game_states.c:245: initEnemies();
	call	_initEnemies
;game_states.c:249: SHOW_BKG;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x01
	ldh	(_LCDC_REG+0),a
;game_states.c:250: SHOW_WIN;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x20
	ldh	(_LCDC_REG+0),a
00102$:
;game_states.c:253: if(frame_counter != 20){
	ld	hl, #_frame_counter
	ld	a, (hl)
	sub	a, #0x14
	inc	hl
	or	a, (hl)
	jr	Z, 00104$
;game_states.c:254: frame_counter+= 1u;
	ld	hl, #_frame_counter
	inc	(hl)
	ret	NZ
	inc	hl
	inc	(hl)
	ret
00104$:
;game_states.c:256: SHOW_SPRITES;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x02
	ldh	(_LCDC_REG+0),a
;game_states.c:257: GAMESTATE = GAMESTATE_PLAY;	
	ld	hl, #_GAMESTATE
	ld	(hl), #0x03
;game_states.c:258: frame_counter = 0;		
	ld	hl, #_frame_counter
	ld	a, #0x00
	ld	(hl+), a
	ld	(hl), #0x00
;game_states.c:260: }
	ret
;main.c:30: void stateGamePlayerDie(){
;	---------------------------------
; Function stateGamePlayerDie
; ---------------------------------
_stateGamePlayerDie::
;main.c:31: player.is_dying = 1u;
	ld	hl, #(_player + 0x000b)
	ld	(hl), #0x01
;main.c:33: player.sprite_index = 48u;
;main.c:32: if( !frame_counter){
	ld	hl, #_frame_counter + 1
	ld	a, (hl-)
	or	a, (hl)
	jr	NZ, 00102$
;main.c:33: player.sprite_index = 48u;
	ld	hl, #(_player + 0x000a)
	ld	(hl), #0x30
00102$:
;main.c:37: if(frame_counter != 60u ){
	ld	hl, #_frame_counter
	ld	a, (hl)
	sub	a, #0x3c
	inc	hl
	or	a, (hl)
	jr	Z, 00110$
;main.c:38: frame_counter+=1u;		
	ld	hl, #_frame_counter
	inc	(hl)
	jp	NZ,_updatePlayer
	inc	hl
	inc	(hl)
	jp	_updatePlayer
00110$:
;main.c:41: if(player.y < 144){			
	ld	a, (#(_player + 0x0001) + 0)
	cp	a, #0x90
	jr	NC, 00107$
;main.c:42: player.y+=1;					
	inc	a
	ld	(#(_player + 0x0001)),a
;main.c:43: player.sprite_index = 64u;			
	ld	hl, #(_player + 0x000a)
	ld	(hl), #0x40
	jp	_updatePlayer
00107$:
;main.c:46: player.y = 14u;
	ld	hl, #(_player + 0x0001)
	ld	(hl), #0x0e
;main.c:47: player.sprite_index = 0;			
	ld	hl, #(_player + 0x000a)
	ld	(hl), #0x00
;main.c:50: if(player.lives){
	ld	a, (#(_player + 0x0007) + 0)
	or	a, a
	jr	Z, 00104$
;main.c:51: fx_jump_finished = 0x01;				
	ld	hl, #_fx_jump_finished
	ld	(hl), #0x01
;main.c:52: initPlayer();
	call	_initPlayer
;main.c:53: initBubbles();
	call	_initBubbles
;main.c:54: initEnemies();
	call	_initEnemies
;main.c:55: GAMESTATE = GAMESTATE_PLAY;		
	ld	hl, #_GAMESTATE
	ld	(hl), #0x03
;main.c:56: frame_counter = 0;
	ld	hl, #_frame_counter
	ld	a, #0x00
	ld	(hl+), a
	ld	(hl), #0x00
	jp	_updatePlayer
00104$:
;main.c:60: initEnemies();
	call	_initEnemies
;main.c:61: initBubbles();
	call	_initBubbles
;main.c:62: player.x = 0;
	ld	hl, #_player
	ld	(hl), #0x00
;main.c:63: player.y = 0;
	ld	hl, #(_player + 0x0001)
	ld	(hl), #0x00
;main.c:64: GAMESTATE = GAMESTATE_OVER;	
	ld	hl, #_GAMESTATE
	ld	(hl), #0x05
;main.c:65: frame_counter = 0;				
	ld	hl, #_frame_counter
	ld	a, #0x00
	ld	(hl+), a
	ld	(hl), #0x00
;main.c:70: updatePlayer();
;main.c:72: }
	jp  _updatePlayer
;main.c:75: void stateGamePlay(){
;	---------------------------------
; Function stateGamePlay
; ---------------------------------
_stateGamePlay::
;main.c:77: oldjoystate = joystate;
	ld	a, (#_joystate)
	ld	(#_oldjoystate),a
;main.c:78: joystate = joypad();
	call	_joypad
	ld	hl, #_joystate
	ld	(hl), e
;main.c:80: if(joypad()){
	call	_joypad
	ld	a, e
	or	a, a
	jr	Z, 00113$
;main.c:83: if (ISDOWN(J_LEFT)){			
	ld	a, (#_joystate)
	bit	1, a
	jr	Z, 00102$
;main.c:84: movePlayerToLeft();
	call	_movePlayerToLeft
00102$:
;main.c:87: if (ISDOWN(J_RIGHT)){			
	ld	a, (#_joystate)
	rrca
	jr	NC, 00104$
;main.c:88: movePlayerToRight();
	call	_movePlayerToRight
00104$:
;main.c:92: if (ISDOWN(J_A) ){ //JUMP
	ld	a, (#_joystate)
	bit	4, a
	jr	Z, 00106$
;main.c:93: playerJump();
	call	_playerJump
00106$:
;main.c:99: if(ISDOWN(J_B)){
	ld	a, (#_joystate)
	bit	5, a
	jr	Z, 00108$
;main.c:100: player.sprite_index = 32u;		
	ld	hl, #(_player + 0x000a)
	ld	(hl), #0x20
00108$:
;main.c:103: if(CLICKED(J_B)){
	ld	a, (#_joystate)
	bit	5, a
	jr	Z, 00113$
	ld	a, (#_joystate)
	and	a, #0x20
	ld	c, a
	ld	b, #0x00
	ld	a, (#_oldjoystate)
	and	a, #0x20
	ld	e, a
	ld	d, #0x00
	ld	a, e
	sub	a, c
	jr	NZ, 00171$
	ld	a, d
	sub	a, b
	jr	Z, 00113$
00171$:
;main.c:107: newBubble();
	call	_newBubble
00113$:
;main.c:112: updatePlayer();
	call	_updatePlayer
;main.c:113: updateEnemies();		
	call	_updateEnemies
;main.c:114: updateBubbles();	
	call	_updateBubbles
;main.c:115: animateEnemies();
	call	_animateEnemies
;main.c:117: if(delay_new_enemie > 40){
	ld	a, #0x28
	ld	hl, #_delay_new_enemie
	sub	a, (hl)
	jr	NC, 00115$
;main.c:118: newEnemie();
	call	_newEnemie
;main.c:119: delay_new_enemie = 0;	
	ld	hl, #_delay_new_enemie
	ld	(hl), #0x00
	jr	00116$
00115$:
;main.c:121: delay_new_enemie+= 1;	
	ld	hl, #_delay_new_enemie
	inc	(hl)
00116$:
;main.c:126: animateWater();	
	call	_animateWater
;main.c:128: if (player.y > 144u){ 	  		
	ld	hl, #(_player + 0x0001)
	ld	c, (hl)
	ld	a, #0x90
	sub	a, c
	ret	NC
;main.c:129: GAMESTATE = GAMESTATE_PLAYER_DIE;	  	
	ld	hl, #_GAMESTATE
	ld	(hl), #0x09
;main.c:132: }
	ret
;main.c:135: void main() {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:136: stateGameBoot();
	call	_stateGameBoot
;main.c:137: while (1) {		
00111$:
;main.c:138: wait_vbl_done();
	call	_wait_vbl_done
;main.c:142: switch (GAMESTATE){
	ld	a, #0x09
	ld	hl, #_GAMESTATE
	sub	a, (hl)
	jr	C, 00111$
	ld	c, (hl)
	ld	b, #0x00
	ld	hl, #00125$
	add	hl, bc
	add	hl, bc
	add	hl, bc
	jp	(hl)
00125$:
	jp	00111$
	jp	00103$
	jp	00104$
	jp	00101$
	jp	00111$
	jp	00108$
	jp	00102$
	jp	00111$
	jp	00105$
	jp	00106$
;main.c:144: case GAMESTATE_PLAY:
00101$:
;main.c:146: stateGamePlay();				
	call	_stateGamePlay
;main.c:147: break;
	jr	00111$
;main.c:149: case GAMESTATE_LOGO:
00102$:
;main.c:150: stateGameLogo();
	call	_stateGameLogo
;main.c:151: break;
	jr	00111$
;main.c:153: case GAMESTATE_INTRO:
00103$:
;main.c:156: stateGameIntro();
	call	_stateGameIntro
;main.c:157: break;
	jr	00111$
;main.c:159: case GAMESTATE_TITLE:
00104$:
;main.c:160: stateGameTitle();
	call	_stateGameTitle
;main.c:162: break;
	jr	00111$
;main.c:164: case GAMESTATE_LOAD_GAMEPLAY:
00105$:
;main.c:165: stateGameLoadGameplay();
	call	_stateGameLoadGameplay
;main.c:166: break;
	jr	00111$
;main.c:170: case GAMESTATE_PLAYER_DIE:								
00106$:
;main.c:171: stateGamePlayerDie();				
	call	_stateGamePlayerDie
;main.c:172: break;
	jr	00111$
;main.c:178: case GAMESTATE_OVER:
00108$:
;main.c:180: stateGameGameOver();
	call	_stateGameGameOver
;main.c:182: }
;main.c:184: }
	jr	00111$
	.area _CODE
	.area _CABS (ABS)
