#include <stdint.h>
#include "config.h"
#include QMK_KEYBOARD_H

// MacOS macros
#define SC_SHOT SGUI(KC_4)
#define SC_SHOT_APP SGUI(KC_5)
#define WINDOW_SWITCH LGUI(KC_GRAVE)

// Browser navigation
#define TAB_R LCTL(KC_TAB)
#define TAB_L LCTL(LSFT(KC_TAB))
#define BR_BACK LGUI(KC_LEFT)
#define BR_FWD LGUI(KC_RIGHT)

enum tap_dance_codes {
    /*
     * Single tap: Types a period
     * Hold: Types an exclamation mark
     * Double tap: Types two periods
     * Triple tap: Types three periods
     */
    DANCE_1,

    /*
     * Single tap: Types a comma
     * Hold: Types a hypen/minus
     * Double tap: Types two commas
     * Triple tap: Types three commas
     */
    DANCE_2,

    /*
     * Single tap: Types a slash
     * Hold: Types a dash/underscore
     * Double tap: Types two slashes
     * Triple tap: Types three slashes
     */
    DANCE_3,

    // ----- Self defined -----
    /*
     * Single tap: Next track
     * Double tap: Previous track
     */
    PREV_NEXT,

    /*
     * Single tap: Full page screenshot
     * Hold: Open screenshot app
     */
    SCRN_SHOT,
};

enum layers {
    BASE,
    SYM,
    NUM,
    NAV,
    OTHER,
};

enum combos { LU_COLON, FP_WRITE, CD_TAB };

enum custom_keycodes { VIM_SAVE = SAFE_RANGE };

/*
 * Other methods
 * - MT(modifier, key): Momentary toggle, holds the modifier while the key is pressed
 * - OSM(modifier): One shot modifier, holds the modifier until the next key is pressed
 * - TO(layer): Toggle to layer
 */

// 3x5_2 Layout
const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    // Colemak DH Layout
    [BASE] = LAYOUT(KC_Q, KC_W, KC_F, KC_P, KC_B, /*|----|*/ KC_J, KC_L, KC_U, KC_Y, KC_BSPC,
                    // -------
                    KC_A, KC_R, MT(MOD_LALT, KC_S), MT(MOD_LGUI, KC_T), KC_G, /*|----|*/ KC_M, MT(MOD_RGUI, KC_N), MT(MOD_LALT, KC_E), KC_I, KC_O,
                    // -------
                    KC_Z, KC_X, KC_C, KC_D, KC_V, /*|----|*/ KC_K, KC_H, TD(DANCE_2), TD(DANCE_1), TD(DANCE_3),
                    // -------
                    MT(MOD_HYPR, KC_SPACE), MT(MOD_LCTL, KC_ESC), /*|----|*/ MT(MOD_LSFT, KC_ENTER), TO(SYM)),

    [SYM] = LAYOUT(KC_ESC, KC_DLR, KC_PERC, KC_PLUS, KC_HASH, /*|----|*/ KC_CIRC, KC_EXLM, KC_AMPR, KC_PIPE, KC_BSPC,
                   // -------
                   KC_TAB, KC_MINS, MT(MOD_LALT, KC_EQL), LGUI_T(KC_DQUO), KC_GRAVE, /*|----|*/ KC_BSLS, KC_LCBR, KC_RCBR, KC_ASTR, KC_ENTER,
                   // -------
                   KC_CAPS, KC_SCLN, KC_COLN, KC_QUOTE, KC_AT, /*|----|*/ KC_LBRC, KC_LPRN, KC_RPRN, KC_RBRC, TO(NAV),
                   // -------
                   TO(BASE), KC_SPACE, /*|----|*/ OSM(MOD_LSFT), TO(NUM)),

    [NUM] = LAYOUT(KC_ESC, KC_BRID, KC_BRIU, KC_AUDIO_VOL_DOWN, KC_AUDIO_VOL_UP, /*|----|*/ KC_PERC, KC_7, KC_8, KC_9, KC_BSPC,
                   // -------
                   KC_TAB, KC_MEDIA_PLAY_PAUSE, MT(MOD_LALT, KC_PLUS), MT(MOD_LGUI, KC_MINS), KC_DOT, /*|----|*/ KC_EQL, KC_4, KC_5, KC_6, KC_ENTER,
                   // -------
                   TD(PREV_NEXT), KC_MUTE, KC_ASTR, KC_SLSH, SC_SHOT_APP, /*|----|*/ KC_0, KC_1, KC_2, KC_3, TO(NAV),
                   // -------
                   TO(BASE), KC_SPACE, /*|----|*/ OSM(MOD_LSFT), TO(SYM)),

    [NAV] = LAYOUT(BR_BACK, BR_FWD, TAB_L, TAB_R, XXXXXXX, /*|----|*/ XXXXXXX, KC_WH_D, KC_WH_U, XXXXXXX, KC_BSPC,
                   // ------
                   OSM(MOD_LSFT), OSM(MOD_LCTL), OSM(MOD_LALT), OSM(MOD_LGUI), XXXXXXX, /*|----|*/ KC_LEFT, KC_DOWN, KC_UP, KC_RIGHT, KC_ENTER,
                   // ------
                   XXXXXXX, WINDOW_SWITCH, XXXXXXX, XXXXXXX, SC_SHOT_APP, /*|----|*/ KC_HOME, XXXXXXX, XXXXXXX, KC_END, MO(OTHER),
                   // ------
                   TO(BASE), KC_SPACE, /*|----|*/ KC_TAB, TO(NUM)),

    /*
     * Only able to get to this layer from NAV (third) layer
     * Sleep/Lock computer
     * Toggle Combo mode
     * Reboot/booload keyboard
     */
    [OTHER] = LAYOUT(XXXXXXX, QK_BOOT, XXXXXXX, XXXXXXX, XXXXXXX, /*|----|*/ XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
                     // -------
                     XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, /*|----|*/ XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
                     // -------
                     XXXXXXX, CM_TOGG, XXXXXXX, XXXXXXX, XXXXXXX, /*|----|*/ XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
                     // -------
                     TO(BASE), OSM(MOD_LSFT), /*|----|*/ OSM(MOD_RCTL), TO(SYM))};

// ----- Combos -----
const uint16_t PROGMEM lu_combo[] = {KC_L, KC_U, COMBO_END};
const uint16_t PROGMEM fp_combo[] = {KC_F, KC_P, COMBO_END};
const uint16_t PROGMEM cd_combo[] = {KC_C, KC_D, COMBO_END};

combo_t key_combos[] = {
    [LU_COLON] = COMBO(lu_combo, KC_COLN),
    [FP_WRITE] = COMBO(fp_combo, VIM_SAVE),
    [CD_TAB]   = COMBO(cd_combo, KC_TAB),
};

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
    switch (keycode) {
        case VIM_SAVE:
            if (record->event.pressed) {
                tap_code16(KC_COLON);
                tap_code16(KC_W);
                tap_code16(KC_ENTER);
                return false; // Skip all further processing of this key
            }
            break;
        case LGUI_T(KC_DQUO):
            if (record->tap.count && record->event.pressed) {
                tap_code16(KC_DQUO);
                return false;
            }
            break;
        default:
            return true; // Process all other keycodes normally
    }

    return true;
}

// ----- Tap Dance -----
extern bool g_suspend_state;
#define GET_TAP_KC(dual_role_key) dual_role_key & 0xFF
uint16_t last_keycode  = KC_NO;
uint8_t  last_modifier = 0;

typedef struct {
    bool    is_press_action;
    uint8_t step;
} tap;

enum { SINGLE_TAP = 1, SINGLE_HOLD, DOUBLE_TAP, DOUBLE_HOLD, DOUBLE_SINGLE_TAP, MORE_TAPS };

static tap dance_state = {.is_press_action = true, .step = 0};

void    on_dance_1(tap_dance_state_t *state, void *user_data);
uint8_t dance_1_dance_step(tap_dance_state_t *state);
void    dance_1_finished(tap_dance_state_t *state, void *user_data);
void    dance_1_reset(tap_dance_state_t *state, void *user_data);

void on_dance_1(tap_dance_state_t *state, void *user_data) {
    if (state->count == 3) {
        tap_code16(KC_DOT);
        tap_code16(KC_DOT);
        tap_code16(KC_DOT);
    }
    if (state->count > 3) {
        tap_code16(KC_DOT);
    }
}

uint8_t dance_1_dance_step(tap_dance_state_t *state) {
    if (state->count == 1) {
        if (state->interrupted || !state->pressed)
            return SINGLE_TAP;
        else
            return SINGLE_HOLD;
    } else if (state->count == 2) {
        if (state->interrupted)
            return DOUBLE_SINGLE_TAP;
        else if (state->pressed)
            return DOUBLE_HOLD;
        else
            return DOUBLE_TAP;
    }
    return MORE_TAPS;
}

void dance_1_finished(tap_dance_state_t *state, void *user_data) {
    dance_state.step = dance_1_dance_step(state);
    switch (dance_state.step) {
        case SINGLE_TAP:
            register_code16(KC_DOT);
            break;
        case SINGLE_HOLD:
            register_code16(KC_EXLM);
            break;
        case DOUBLE_TAP:
            register_code16(KC_DOT);
            register_code16(KC_DOT);
            break;
        case DOUBLE_SINGLE_TAP:
            tap_code16(KC_DOT);
            register_code16(KC_DOT);
            break;
    }
}

void dance_1_reset(tap_dance_state_t *state, void *user_data) {
    wait_ms(10);
    switch (dance_state.step) {
        case SINGLE_TAP:
            unregister_code16(KC_DOT);
            break;
        case SINGLE_HOLD:
            unregister_code16(KC_EXLM);
            break;
        case DOUBLE_TAP:
            unregister_code16(KC_DOT);
            break;
        case DOUBLE_SINGLE_TAP:
            unregister_code16(KC_DOT);
            break;
    }
    dance_state.step = 0;
}

void    on_dance_2(tap_dance_state_t *state, void *user_data);
uint8_t dance_2_dance_step(tap_dance_state_t *state);
void    dance_2_finished(tap_dance_state_t *state, void *user_data);
void    dance_2_reset(tap_dance_state_t *state, void *user_data);

void on_dance_2(tap_dance_state_t *state, void *user_data) {
    if (state->count == 3) {
        tap_code16(KC_COMM);
        tap_code16(KC_COMM);
        tap_code16(KC_COMM);
    }
    if (state->count > 3) {
        tap_code16(KC_COMM);
    }
}

uint8_t dance_2_dance_step(tap_dance_state_t *state) {
    if (state->count == 1) {
        if (state->interrupted || !state->pressed)
            return SINGLE_TAP;
        else
            return SINGLE_HOLD;
    } else if (state->count == 2) {
        if (state->interrupted)
            return DOUBLE_SINGLE_TAP;
        else if (state->pressed)
            return DOUBLE_HOLD;
        else
            return DOUBLE_TAP;
    }
    return MORE_TAPS;
}

void dance_2_finished(tap_dance_state_t *state, void *user_data) {
    dance_state.step = dance_2_dance_step(state);
    switch (dance_state.step) {
        case SINGLE_TAP:
            register_code16(KC_COMM);
            break;
        case SINGLE_HOLD:
            register_code16(KC_MINS);
            break;
        case DOUBLE_TAP:
            register_code16(KC_COMM);
            register_code16(KC_COMM);
            break;
        case DOUBLE_SINGLE_TAP:
            tap_code16(KC_COMM);
            register_code16(KC_COMM);
            break;
    }
}

void dance_2_reset(tap_dance_state_t *state, void *user_data) {
    wait_ms(10);
    switch (dance_state.step) {
        case SINGLE_TAP:
            unregister_code16(KC_COMM);
            break;
        case SINGLE_HOLD:
            unregister_code16(KC_MINS);
            break;
        case DOUBLE_TAP:
            unregister_code16(KC_COMM);
            break;
        case DOUBLE_SINGLE_TAP:
            unregister_code16(KC_COMM);
            break;
    }
    dance_state.step = 0;
}

void    on_dance_3(tap_dance_state_t *state, void *user_data);
uint8_t dance_3_dance_step(tap_dance_state_t *state);
void    dance_3_finished(tap_dance_state_t *state, void *user_data);
void    dance_3_reset(tap_dance_state_t *state, void *user_data);

void on_dance_3(tap_dance_state_t *state, void *user_data) {
    if (state->count == 3) {
        tap_code16(KC_SLASH);
        tap_code16(KC_SLASH);
        tap_code16(KC_SLASH);
    }
    if (state->count > 3) {
        tap_code16(KC_SLASH);
    }
}

uint8_t dance_3_dance_step(tap_dance_state_t *state) {
    if (state->count == 1) {
        if (state->interrupted || !state->pressed)
            return SINGLE_TAP;
        else
            return SINGLE_HOLD;
    } else if (state->count == 2) {
        if (state->interrupted)
            return DOUBLE_SINGLE_TAP;
        else if (state->pressed)
            return DOUBLE_HOLD;
        else
            return DOUBLE_TAP;
    }
    return MORE_TAPS;
}

void dance_3_finished(tap_dance_state_t *state, void *user_data) {
    dance_state.step = dance_3_dance_step(state);
    switch (dance_state.step) {
        case SINGLE_TAP:
            register_code16(KC_SLASH);
            break;
        case SINGLE_HOLD:
            register_code16(S(KC_MINS));
            break;
        case DOUBLE_TAP:
            register_code16(KC_SLASH);
            register_code16(KC_SLASH);
            break;
        case DOUBLE_SINGLE_TAP:
            tap_code16(KC_SLASH);
            register_code16(KC_SLASH);
            break;
    }
}

void dance_3_reset(tap_dance_state_t *state, void *user_data) {
    wait_ms(10);
    switch (dance_state.step) {
        case SINGLE_TAP:
            unregister_code16(KC_SLASH);
            break;
        case SINGLE_HOLD:
            unregister_code16(S(KC_MINS));
            break;
        case DOUBLE_TAP:
            unregister_code16(KC_SLASH);
            break;
        case DOUBLE_SINGLE_TAP:
            unregister_code16(KC_SLASH);
            break;
    }
    dance_state.step = 0;
}

void    on_prev_next(tap_dance_state_t *state, void *user_data);
uint8_t prev_next_dance_step(tap_dance_state_t *state);
void    prev_next_finished(tap_dance_state_t *state, void *user_data);
void    prev_next_reset(tap_dance_state_t *state, void *user_data);

void on_prev_next(tap_dance_state_t *state, void *user_data) {
    if (state->count >= 3) {
        tap_code16(KC_MPRV);
    }
}

uint8_t prev_next_dance_step(tap_dance_state_t *state) {
    if (state->count == 1) {
        if (state->interrupted || !state->pressed)
            return SINGLE_TAP;
        else
            return SINGLE_HOLD;
    } else if (state->count == 2) {
        if (state->interrupted)
            return DOUBLE_SINGLE_TAP;
        else if (state->pressed)
            return DOUBLE_HOLD;
        else
            return DOUBLE_TAP;
    }
    return MORE_TAPS;
}

void prev_next_finished(tap_dance_state_t *state, void *user_data) {
    dance_state.step = prev_next_dance_step(state);
    switch (dance_state.step) {
        case SINGLE_TAP:
            tap_code16(KC_MNXT);
            break;
        case SINGLE_HOLD:
        case DOUBLE_TAP:
        case DOUBLE_SINGLE_TAP:
            tap_code16(KC_MPRV);
            break;
    }
}

void prev_next_reset(tap_dance_state_t *state, void *user_data) {
    wait_ms(10);
    dance_state.step = 0;
}

void    on_scrn_shot(tap_dance_state_t *state, void *user_data);
uint8_t scrn_shot_dance_step(tap_dance_state_t *state);
void    scrn_shot_finished(tap_dance_state_t *state, void *user_data);
void    scrn_shot_reset(tap_dance_state_t *state, void *user_data);

void on_scrn_shot(tap_dance_state_t *state, void *user_data) {
    if (state->count >= 3) {
        tap_code16(SC_SHOT);
    }
}

uint8_t scrn_shot_dance_step(tap_dance_state_t *state) {
    if (state->count == 1) {
        if (state->interrupted || !state->pressed)
            return SINGLE_TAP;
        else
            return SINGLE_HOLD;
    }
    return MORE_TAPS;
}

void scrn_shot_finished(tap_dance_state_t *state, void *user_data) {
    switch (scrn_shot_dance_step(state)) {
        case SINGLE_TAP:
            tap_code16(SC_SHOT);
            break;
        case SINGLE_HOLD:
            tap_code16(SC_SHOT_APP);
            break;
    }
}

void scrn_shot_reset(tap_dance_state_t *state, void *user_data) {
    wait_ms(10);
    dance_state.step = 0;
}

tap_dance_action_t tap_dance_actions[] = {
    [DANCE_1] = ACTION_TAP_DANCE_FN_ADVANCED(on_dance_1, dance_1_finished, dance_1_reset), [DANCE_2] = ACTION_TAP_DANCE_FN_ADVANCED(on_dance_2, dance_2_finished, dance_2_reset), [DANCE_3] = ACTION_TAP_DANCE_FN_ADVANCED(on_dance_3, dance_3_finished, dance_3_reset), [PREV_NEXT] = ACTION_TAP_DANCE_FN_ADVANCED(on_prev_next, prev_next_finished, prev_next_reset), [SCRN_SHOT] = ACTION_TAP_DANCE_FN_ADVANCED(on_scrn_shot, scrn_shot_finished, scrn_shot_reset),
};
